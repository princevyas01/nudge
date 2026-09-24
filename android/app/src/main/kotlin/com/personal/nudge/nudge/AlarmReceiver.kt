package com.personal.nudge.nudge

import android.app.AlarmManager
import android.app.PendingIntent
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Build
import android.util.Log
import java.util.concurrent.Executors

class AlarmReceiver : BroadcastReceiver() {

    companion object {

        private const val TAG =
            "NudgeAlarmReceiver"

        const val ACTION_START_ALARM =
            "com.personal.nudge.ACTION_START_ALARM"
    }

    override fun onReceive(
        context: Context,
        intent: Intent
    ) {

        when (intent.action) {

            ACTION_START_ALARM -> {

                handleAlarmTrigger(
                    context,
                    intent
                )
            }

            Intent.ACTION_BOOT_COMPLETED,
            Intent.ACTION_MY_PACKAGE_REPLACED,
            Intent.ACTION_TIME_CHANGED,
            Intent.ACTION_TIMEZONE_CHANGED,
            AlarmManager.ACTION_SCHEDULE_EXACT_ALARM_PERMISSION_STATE_CHANGED -> {

                handleSystemReschedule(
                    context
                )
            }
        }
    }

    private fun handleAlarmTrigger(
        context: Context,
        intent: Intent
    ) {

        val alarmId =
            intent.getIntExtra(
                "id",
                -1
            )

        if (alarmId <= 0) {

            Log.e(
                TAG,
                "Invalid alarm id"
            )

            return
        }

        val reminderId =
            intent.getStringExtra(
                "reminderId"
            )

        val title =
            intent.getStringExtra(
                "title"
            ) ?: "Nudge Reminder"

        val message =
            intent.getStringExtra(
                "message"
            ) ?: ""

        val vibration =
            intent.getBooleanExtra(
                "vibration",
                true
            )

        Log.i(
            TAG,
            "ALARM_RECEIVER_TRIGGERED alarmId=$alarmId reminderId=$reminderId"
        )

        val serviceIntent =
            Intent(
                context,
                AlarmRingingService::class.java
            ).apply {

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
                    title
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

        try {

            if (
                Build.VERSION.SDK_INT >=
                Build.VERSION_CODES.O
            ) {

                context.startForegroundService(
                    serviceIntent
                )

            } else {

                context.startService(
                    serviceIntent
                )
            }

        } catch (e: Exception) {

            Log.e(
                TAG,
                "ALARM_SERVICE_START_FAILED",
                e
            )
        }
    }

    private fun handleSystemReschedule(
        context: Context
    ) {

        Log.i(
            TAG,
            "SYSTEM_RECONCILIATION_TRIGGERED"
        )

        val pending =
            goAsync()

        Executors.newSingleThreadExecutor()
            .execute {

                try {

                    AlarmRepositoryNative
                        .reconcile(
                            context
                        )

                } catch (e: Exception) {

                    Log.e(
                        TAG,
                        "ALARM_RECONCILIATION_FAILED",
                        e
                    )

                } finally {

                    pending.finish()
                }
            }
    }
}
