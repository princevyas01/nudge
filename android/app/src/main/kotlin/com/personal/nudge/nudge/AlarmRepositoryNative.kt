package com.personal.nudge.nudge

import android.app.AlarmManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.os.Build
import android.util.Log
import java.time.Instant
import java.time.LocalDateTime
import java.time.OffsetDateTime
import java.time.ZoneId

object AlarmRepositoryNative {

    private const val TAG =
        "NudgeAlarmRepository"

    fun reconcile(
        context: Context
    ) {

        val dbFile =
            context.getDatabasePath(
                "nudge_v2.db"
            )

        if (!dbFile.exists()) {

            Log.i(
                TAG,
                "Database does not exist yet"
            )

            return
        }

        val db =
            android.database.sqlite.SQLiteDatabase
                .openDatabase(
                    dbFile.absolutePath,
                    null,
                    android.database.sqlite.SQLiteDatabase.OPEN_READWRITE
                )

        try {

            val alarmManager =
                context.getSystemService(
                    Context.ALARM_SERVICE
                ) as AlarmManager

            if (
                Build.VERSION.SDK_INT >=
                Build.VERSION_CODES.S &&
                !alarmManager.canScheduleExactAlarms()
            ) {

                Log.w(
                    TAG,
                    "Exact alarm permission unavailable; marking alarms unsynced"
                )

                db.execSQL(
                    """
                    UPDATE reminders
                    SET isAlarmSynced = 0
                    WHERE isDone = 0
                      AND isArchived = 0
                    """.trimIndent()
                )

                return
            }

            val cursor =
                db.rawQuery(
                    """
                    SELECT
                        id,
                        message,
                        scheduledAt,
                        vibrationEnabled
                    FROM reminders
                    WHERE isDone = 0
                      AND isArchived = 0
                    """.trimIndent(),
                    null
                )

            cursor.use {

                while (it.moveToNext()) {

                    val reminderId =
                        it.getString(0)

                    val message =
                        it.getString(1)
                            ?: ""

                    val scheduledAt =
                        it.getString(2)

                    val vibration =
                        it.getInt(3) == 1

                    val triggerMillis =
                        parseTimestamp(
                            scheduledAt
                        )
                            ?: continue

                    val alarmId =
                        fnv1aHash32(
                            reminderId
                        )

                    val alarmIntent =
                        Intent(
                            context,
                            AlarmReceiver::class.java
                        ).apply {

                            action =
                                AlarmReceiver.ACTION_START_ALARM

                            putExtra(
                                "id",
                                alarmId
                            )

                            putExtra(
                                "reminderId",
                                reminderId
                            )

                            putExtra(
                                "title",
                                "Nudge Reminder"
                            )

                            putExtra(
                                "message",
                                message
                            )

                            putExtra(
                                "vibration",
                                vibration
                            )
                        }

                    val pendingIntent =
                        PendingIntent.getBroadcast(
                            context,
                            alarmId,
                            alarmIntent,
                            PendingIntent.FLAG_UPDATE_CURRENT or
                                PendingIntent.FLAG_IMMUTABLE
                        )

                    if (
                        triggerMillis <=
                        System.currentTimeMillis()
                    ) {

                        db.execSQL(
                            """
                            UPDATE reminders
                            SET isAlarmSynced = 0
                            WHERE id = ?
                            """.trimIndent(),
                            arrayOf(reminderId)
                        )

                        continue
                    }

                    val showIntent =
                        Intent(
                            context,
                            MainActivity::class.java
                        ).apply {

                            putExtra(
                                "alarm_id",
                                alarmId
                            )

                            putExtra(
                                "reminder_id",
                                reminderId
                            )

                            setFlags(
                                Intent.FLAG_ACTIVITY_NEW_TASK or
                                    Intent.FLAG_ACTIVITY_CLEAR_TOP or
                                    Intent.FLAG_ACTIVITY_SINGLE_TOP
                            )
                        }

                    val showPendingIntent =
                        PendingIntent.getActivity(
                            context,
                            alarmId,
                            showIntent,
                            PendingIntent.FLAG_UPDATE_CURRENT or
                                PendingIntent.FLAG_IMMUTABLE
                        )

                    alarmManager.setAlarmClock(
                        AlarmManager.AlarmClockInfo(
                            triggerMillis,
                            showPendingIntent
                        ),
                        pendingIntent
                    )

                    db.execSQL(
                        """
                        UPDATE reminders
                        SET isAlarmSynced = 1
                        WHERE id = ?
                        """.trimIndent(),
                        arrayOf(reminderId)
                    )

                    Log.i(
                        TAG,
                        "ALARM_RESTORED reminder=$reminderId trigger=$triggerMillis"
                    )
                }
            }

        } finally {

            db.close()
        }
    }

    private fun parseTimestamp(
        raw: String?
    ): Long? {

        if (raw.isNullOrBlank()) {
            return null
        }

        return try {

            Instant.parse(
                raw
            ).toEpochMilli()

        } catch (_: Exception) {

            try {

                OffsetDateTime.parse(
                    raw
                ).toInstant()
                    .toEpochMilli()

            } catch (_: Exception) {

                try {

                    LocalDateTime.parse(
                        raw
                    )
                        .atZone(
                            ZoneId.systemDefault()
                        )
                        .toInstant()
                        .toEpochMilli()

                } catch (_: Exception) {

                    null
                }
            }
        }
    }

    private fun fnv1aHash32(
        value: String
    ): Int {

        var hash =
            0x811c9dc5.toInt()

        for (
            byte in value.toByteArray(
                Charsets.UTF_8
            )
        ) {

            hash =
                hash xor
                    (byte.toInt() and 0xff)

            hash =
                hash * 0x01000193
        }

        return hash and
            0x7fffffff
    }
}
