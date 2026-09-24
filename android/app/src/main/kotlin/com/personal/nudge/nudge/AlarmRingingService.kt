package com.personal.nudge.nudge

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.Context
import android.content.Intent
import android.content.pm.ServiceInfo
import android.media.AudioAttributes
import android.media.AudioManager
import android.media.MediaPlayer
import android.media.RingtoneManager
import android.net.Uri
import android.os.Build
import android.os.IBinder
import android.os.PowerManager
import android.os.VibrationEffect
import android.os.Vibrator
import android.provider.Settings
import android.util.Log
import android.os.Handler
import android.os.Looper
import java.io.File

import androidx.core.app.NotificationCompat

class AlarmRingingService : Service() {

    companion object {

        private const val TAG =
            "NudgeAlarmService"

        const val CHANNEL_ID =
            "nudge_alarm_channel_final"

        private const val ACTION_STOP =
            "STOP_ALARM"

        const val ACTION_ALARM_DISMISSED =
            "com.personal.nudge.ACTION_ALARM_DISMISSED"
    }

    private var mediaPlayer:
        MediaPlayer? = null

    private var vibrator:
        Vibrator? = null

    private var wakeLock:
        PowerManager.WakeLock? = null

    private var loopHandler: Handler? = null
    private var loopRunnable: Runnable? = null

    override fun onBind(
        intent: Intent?
    ): IBinder? = null

    override fun onStartCommand(
        intent: Intent?,
        flags: Int,
        startId: Int
    ): Int {

        if (
            intent?.action ==
            ACTION_STOP
        ) {

            sendBroadcast(
                Intent(ACTION_ALARM_DISMISSED).setPackage(packageName)
            )

            stopAlarm()

            return START_NOT_STICKY
        }

        val id =
            intent?.getIntExtra(
                "id",
                1
            ) ?: 1

        val reminderId =
            intent?.getStringExtra(
                "reminderId"
            )

        val title =
            intent?.getStringExtra(
                "title"
            ) ?: "Nudge Reminder"

        val message =
            intent?.getStringExtra(
                "message"
            ) ?: ""

        val vibrationEnabled =
            intent?.getBooleanExtra(
                "vibration",
                true
            ) ?: true

        Log.i(
            TAG,
            "ALARM_SERVICE_STARTED alarmId=$id reminderId=$reminderId"
        )

        acquireWakeLock()

        createChannel()

        val fullScreenIntent =
            Intent(
                this,
                MainActivity::class.java
            ).apply {

                setFlags(
                    Intent.FLAG_ACTIVITY_NEW_TASK or
                        Intent.FLAG_ACTIVITY_CLEAR_TOP or
                        Intent.FLAG_ACTIVITY_SINGLE_TOP
                )

                putExtra(
                    "alarm_id",
                    id
                )

                putExtra(
                    "reminder_id",
                    reminderId
                )
            }

        val fullScreenPendingIntent =
            PendingIntent.getActivity(
                this,
                id,
                fullScreenIntent,
                PendingIntent.FLAG_UPDATE_CURRENT or
                    PendingIntent.FLAG_IMMUTABLE
            )

        val stopIntent =
            Intent(
                this,
                AlarmRingingService::class.java
            ).apply {
                action =
                    ACTION_STOP
            }

        val stopPendingIntent =
            PendingIntent.getService(
                this,
                id,
                stopIntent,
                PendingIntent.FLAG_UPDATE_CURRENT or
                    PendingIntent.FLAG_IMMUTABLE
            )

        val builder =
            NotificationCompat
                .Builder(
                    this,
                    CHANNEL_ID
                )
                .setSmallIcon(
                    android.R.drawable
                        .ic_lock_idle_alarm
                )
                .setContentTitle(
                    title
                )
                .setContentText(
                    message
                )
                .setCategory(
                    NotificationCompat
                        .CATEGORY_ALARM
                )
                .setPriority(
                    NotificationCompat
                        .PRIORITY_MAX
                )
                .setVisibility(
                    NotificationCompat
                        .VISIBILITY_PUBLIC
                )
                .setOngoing(true)
                .setAutoCancel(false)
                .addAction(
                    0,
                    "Dismiss",
                    stopPendingIntent
                )

        if (
            Build.VERSION.SDK_INT < 34 ||
            canUseFullScreenIntent()
        ) {

            builder.setFullScreenIntent(
                fullScreenPendingIntent,
                true
            )
        }

        val notification =
            builder.build()

        try {

            if (
                Build.VERSION.SDK_INT >=
                Build.VERSION_CODES.Q
            ) {

                startForeground(
                    id,
                    notification,
                    ServiceInfo
                        .FOREGROUND_SERVICE_TYPE_MEDIA_PLAYBACK
                )

            } else {

                startForeground(
                    id,
                    notification
                )
            }

        } catch (e: Exception) {

            Log.e(
                TAG,
                "ALARM_FOREGROUND_START_FAILED",
                e
            )

            stopAlarm()

            return START_NOT_STICKY
        }

        startAlarmAudio(
            vibrationEnabled
        )

        return START_STICKY
    }

    private fun canUseFullScreenIntent():
        Boolean {

        if (
            Build.VERSION.SDK_INT <
            Build.VERSION_CODES.UPSIDE_DOWN_CAKE
        ) {
            return true
        }

        val manager =
            getSystemService(
                Context.NOTIFICATION_SERVICE
            ) as NotificationManager

        return manager.canUseFullScreenIntent()
    }

    private fun createChannel() {

        if (
            Build.VERSION.SDK_INT >=
            Build.VERSION_CODES.O
        ) {

            val channel =
                NotificationChannel(
                    CHANNEL_ID,
                    "Nudge Alarms",
                    NotificationManager
                        .IMPORTANCE_HIGH
                )

            channel.description =
                "Critical reminder alarms"

            channel.setSound(
                null,
                null
            )

            channel.enableVibration(
                false
            )

            channel.lockscreenVisibility =
                NotificationCompat
                    .VISIBILITY_PUBLIC

            getSystemService(
                NotificationManager::class.java
            )?.createNotificationChannel(
                channel
            )
        }
    }

    private fun startAlarmAudio(
        vibrationEnabled: Boolean
    ) {

        stopAudio()

        // 1. Try Custom Alarm Sound if configured
        try {
            val prefs = getSharedPreferences("nudge_alarm_prefs", Context.MODE_PRIVATE)
            val customSoundPath = prefs.getString("custom_sound_path", null)
            val customStartMs = prefs.getInt("custom_start_ms", 0)
            val customEndMs = prefs.getInt("custom_end_ms", -1)

            if (customSoundPath != null && File(customSoundPath).exists()) {
                mediaPlayer = MediaPlayer().apply {
                    setAudioAttributes(
                        AudioAttributes.Builder()
                            .setUsage(AudioAttributes.USAGE_ALARM)
                            .setContentType(AudioAttributes.CONTENT_TYPE_SONIFICATION)
                            .build()
                    )
                    setDataSource(this@AlarmRingingService, Uri.fromFile(File(customSoundPath)))
                    prepare()
                    seekTo(customStartMs)
                    setVolume(1.0f, 1.0f)
                    start()
                }

                if (customEndMs > customStartMs) {
                    val segmentDuration = (customEndMs - customStartMs).toLong()
                    loopHandler = Handler(Looper.getMainLooper())
                    loopRunnable = object : Runnable {
                        override fun run() {
                            try {
                                mediaPlayer?.let { player ->
                                    if (player.isPlaying) {
                                        player.seekTo(customStartMs)
                                        loopHandler?.postDelayed(this, segmentDuration)
                                    }
                                }
                            } catch (e: Exception) {
                                Log.w(TAG, "Custom alarm loop error", e)
                            }
                        }
                    }
                    loopHandler?.postDelayed(loopRunnable!!, segmentDuration)
                } else {
                    mediaPlayer?.isLooping = true
                }

                Log.i(TAG, "ALARM_AUDIO_STARTED_CUSTOM path=$customSoundPath start=$customStartMs end=$customEndMs")
                if (vibrationEnabled) {
                    startVibration()
                }
                return
            }
        } catch (e: Exception) {
            Log.e(TAG, "Failed playing custom sound, falling back to system alarm", e)
            stopAudio()
        }

        // 2. Default System Alarm fallback

        try {

            val uri =
                RingtoneManager
                    .getDefaultUri(
                        RingtoneManager.TYPE_ALARM
                    )
                    ?: Settings.System
                        .DEFAULT_ALARM_ALERT_URI

            val audioManager =
                getSystemService(
                    Context.AUDIO_SERVICE
                ) as AudioManager

            Log.i(
                TAG,
                "ALARM_AUDIO_STREAM_VOLUME=${audioManager.getStreamVolume(AudioManager.STREAM_ALARM)}"
            )

            Log.i(
                TAG,
                "ALARM_AUDIO_MAX_VOLUME=${audioManager.getStreamMaxVolume(AudioManager.STREAM_ALARM)}"
            )

            mediaPlayer =
                MediaPlayer().apply {

                    setAudioAttributes(
                        AudioAttributes.Builder()
                            .setUsage(
                                AudioAttributes
                                    .USAGE_ALARM
                            )
                            .setContentType(
                                AudioAttributes
                                    .CONTENT_TYPE_SONIFICATION
                            )
                            .build()
                    )

                    setDataSource(
                        this@AlarmRingingService,
                        uri
                    )

                    isLooping = true

                    prepare()

                    // START AT FULL APPLICATION VOLUME.
                    // Do not use the previous 10% ramp.
                    setVolume(
                        1.0f,
                        1.0f
                    )

                    start()
                }

            Log.i(
                TAG,
                "ALARM_AUDIO_STARTED"
            )

            if (
                vibrationEnabled
            ) {

                startVibration()
            }

        } catch (e: Exception) {

            Log.e(
                TAG,
                "ALARM_AUDIO_FAILED",
                e
            )

            // Notification must still remain active
            // even if the ringtone itself fails.

            if (
                vibrationEnabled
            ) {
                startVibration()
            }
        }
    }

    private fun startVibration() {

        try {

            vibrator =
                getSystemService(
                    Context.VIBRATOR_SERVICE
                ) as? Vibrator

            val pattern =
                longArrayOf(
                    0,
                    800,
                    800
                )

            if (
                Build.VERSION.SDK_INT >=
                Build.VERSION_CODES.O
            ) {

                vibrator?.vibrate(
                    VibrationEffect
                        .createWaveform(
                            pattern,
                            0
                        )
                )

            } else {

                @Suppress(
                    "DEPRECATION"
                )

                vibrator?.vibrate(
                    pattern,
                    0
                )
            }

        } catch (e: Exception) {

            Log.e(
                TAG,
                "ALARM_VIBRATION_FAILED",
                e
            )
        }
    }

    private fun acquireWakeLock() {

        try {

            val powerManager =
                getSystemService(
                    Context.POWER_SERVICE
                ) as PowerManager

            wakeLock?.let {

                if (it.isHeld) {
                    it.release()
                }
            }

            wakeLock =
                powerManager.newWakeLock(
                    PowerManager
                        .PARTIAL_WAKE_LOCK,
                    "Nudge:AlarmWakeLock"
                )

            wakeLock?.acquire(
                120_000L
            )

        } catch (e: Exception) {

            Log.e(
                TAG,
                "WAKE_LOCK_FAILED",
                e
            )
        }
    }

    private fun stopAudio() {

        try {
            mediaPlayer?.stop()
        } catch (_: Exception) {
        }

        try {
            mediaPlayer?.release()
        } catch (_: Exception) {
        }

        mediaPlayer = null

        try {
            vibrator?.cancel()
        } catch (_: Exception) {
        }

        vibrator = null
    }

    private fun stopAlarm() {

        Log.i(
            TAG,
            "ALARM_DISMISSED"
        )

        stopAudio()

        try {

            wakeLock?.let {

                if (it.isHeld) {
                    it.release()
                }
            }

        } catch (_: Exception) {
        }

        wakeLock = null

        val manager =
            getSystemService(
                NotificationManager::class.java
            )

        manager?.cancelAll()

        if (
            Build.VERSION.SDK_INT >=
            Build.VERSION_CODES.N
        ) {

            stopForeground(
                STOP_FOREGROUND_REMOVE
            )

        } else {

            @Suppress(
                "DEPRECATION"
            )

            stopForeground(true)
        }

        stopSelf()
    }

    override fun onTaskRemoved(
        rootIntent: Intent?
    ) {

        // Do NOT stop the service here.
        // The alarm is already active and must keep ringing.

        Log.i(
            TAG,
            "Alarm service task removed; keeping alarm active"
        )

        super.onTaskRemoved(
            rootIntent
        )
    }

    override fun onDestroy() {

        stopAlarm()

        super.onDestroy()
    }
}
