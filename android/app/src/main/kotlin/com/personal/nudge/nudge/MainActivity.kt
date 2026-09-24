package com.personal.nudge.nudge

import android.app.AlarmManager
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.provider.Settings
import android.util.Log
import android.view.WindowManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.BroadcastReceiver
import android.content.IntentFilter
import android.media.AudioAttributes
import android.media.MediaMetadataRetriever
import android.media.MediaPlayer
import android.os.Handler
import android.os.Looper
import java.io.File


class MainActivity : FlutterActivity() {

    companion object {

        private const val TAG = "NudgeMainActivity"

        const val ALARM_CHANNEL =
            "com.personal.nudge/alarm"

        const val RELIABILITY_CHANNEL =
            "com.personal.nudge/reliability"

        const val ACTION_START_ALARM =
            "com.personal.nudge.ACTION_START_ALARM"

        const val ACTION_ALARM_DISMISSED =
            "com.personal.nudge.ACTION_ALARM_DISMISSED"
    }

    private var launchAlarmId: Int? = null

    private var launchReminderId: String? = null

    private var alarmChannel: MethodChannel? = null
    private var previewMediaPlayer: MediaPlayer? = null
    private var previewHandler: Handler? = null
    private var previewRunnable: Runnable? = null
    private var alarmDismissReceiver: BroadcastReceiver? = null

    override fun onCreate(
        savedInstanceState: Bundle?
    ) {

        super.onCreate(
            savedInstanceState
        )

        configureLockScreenDisplay()

        registerAlarmDismissReceiver()

        handleAlarmLaunchIntent(
            intent
        )
    }

    override fun onNewIntent(
        intent: Intent
    ) {

        super.onNewIntent(intent)

        setIntent(intent)

        handleAlarmLaunchIntent(
            intent
        )

        notifyFlutterAlarmIfReady()
    }

    override fun onResume() {

        super.onResume()

        notifyFlutterAlarmIfReady()
    }

    private fun registerAlarmDismissReceiver() {
        val filter = IntentFilter(ACTION_ALARM_DISMISSED)
        alarmDismissReceiver = object : BroadcastReceiver() {
            override fun onReceive(context: Context?, intent: Intent?) {
                Log.i(TAG, "ACTION_ALARM_DISMISSED received, closing alarm UI")
                performCloseAlarmUi()
                alarmChannel?.invokeMethod("onAlarmDismissed", null)
            }
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            registerReceiver(alarmDismissReceiver, filter, Context.RECEIVER_NOT_EXPORTED)
        } else {
            registerReceiver(alarmDismissReceiver, filter)
        }
    }

    private fun performCloseAlarmUi() {
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O_MR1) {
                setShowWhenLocked(false)
                setTurnScreenOn(false)
            }
            @Suppress("DEPRECATION")
            window.clearFlags(
                WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON or
                    WindowManager.LayoutParams.FLAG_SHOW_WHEN_LOCKED or
                    WindowManager.LayoutParams.FLAG_TURN_SCREEN_ON
            )
            moveTaskToBack(true)
        } catch (e: Exception) {
            Log.e(TAG, "Error performing close alarm UI", e)
        }
    }

    private fun stopAudioPreviewInternal() {
        try {
            previewRunnable?.let { previewHandler?.removeCallbacks(it) }
            previewRunnable = null
            previewHandler = null
            previewMediaPlayer?.let {
                if (it.isPlaying) {
                    it.stop()
                }
                it.reset()
                it.release()
            }
            previewMediaPlayer = null
        } catch (e: Exception) {
            Log.w(TAG, "stopAudioPreviewInternal error", e)
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        stopAudioPreviewInternal()
        try {
            alarmDismissReceiver?.let { unregisterReceiver(it) }
        } catch (_: Exception) {}
    }

    private fun configureLockScreenDisplay() {

        if (
            Build.VERSION.SDK_INT >=
            Build.VERSION_CODES.O_MR1
        ) {

            setShowWhenLocked(true)

            setTurnScreenOn(true)
        }

        @Suppress("DEPRECATION")
        window.addFlags(
            WindowManager.LayoutParams.FLAG_SHOW_WHEN_LOCKED or
                WindowManager.LayoutParams.FLAG_TURN_SCREEN_ON or
                WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON
        )
    }

    private fun handleAlarmLaunchIntent(
        intent: Intent?
    ) {

        if (intent == null) {
            return
        }

        if (
            intent.hasExtra("alarm_id")
        ) {

            launchAlarmId =
                intent.getIntExtra(
                    "alarm_id",
                    -1
                )
        }

        launchReminderId =
            intent.getStringExtra(
                "reminder_id"
            )
    }

    private fun notifyFlutterAlarmIfReady() {

        val alarmId =
            launchAlarmId
                ?: return

        alarmChannel?.invokeMethod(
            "onAlarmTriggered",
            mapOf(
                "alarmId" to alarmId,
                "reminderId" to launchReminderId
            )
        )
    }

    private fun clearLaunchAlarmData() {

        launchAlarmId = null

        launchReminderId = null
    }

    override fun configureFlutterEngine(
        flutterEngine: FlutterEngine
    ) {

        super.configureFlutterEngine(
            flutterEngine
        )

        alarmChannel =
            MethodChannel(
                flutterEngine.dartExecutor
                    .binaryMessenger,
                ALARM_CHANNEL
            )

        alarmChannel?.setMethodCallHandler {
            call,
            result ->

            when (call.method) {

                "getAlarmData" -> {

                    val data =
                        mapOf(
                            "alarmId" to launchAlarmId,
                            "reminderId" to launchReminderId
                        )

                    clearLaunchAlarmData()

                    result.success(
                        data
                    )
                }

                "canScheduleExactAlarms" -> {

                    val alarmManager =
                        getSystemService(
                            Context.ALARM_SERVICE
                        ) as AlarmManager

                    result.success(
                        if (
                            Build.VERSION.SDK_INT >=
                            Build.VERSION_CODES.S
                        ) {
                            alarmManager
                                .canScheduleExactAlarms()
                        } else {
                            true
                        }
                    )
                }

                "openExactAlarmSettings" -> {

                    if (
                        Build.VERSION.SDK_INT <
                        Build.VERSION_CODES.S
                    ) {

                        result.success(true)

                        return@setMethodCallHandler
                    }

                    try {

                        val intent =
                            Intent(
                                Settings
                                    .ACTION_REQUEST_SCHEDULE_EXACT_ALARM,
                                Uri.parse(
                                    "package:$packageName"
                                )
                            )

                        startActivity(intent)

                        result.success(true)

                    } catch (e: Exception) {

                        Log.e(
                            TAG,
                            "Unable to open exact alarm settings",
                            e
                        )

                        try {

                            val fallback =
                                Intent(
                                    Settings
                                        .ACTION_MANAGE_APPLICATIONS_SETTINGS
                                )

                            startActivity(
                                fallback
                            )

                            result.success(true)

                        } catch (fallbackError: Exception) {

                            result.error(
                                "SETTINGS_ERROR",
                                fallbackError.message,
                                null
                            )
                        }
                    }
                }

                "canUseFullScreenIntent" -> {

                    if (
                        Build.VERSION.SDK_INT >=
                        Build.VERSION_CODES.UPSIDE_DOWN_CAKE
                    ) {

                        val manager =
                            getSystemService(
                                Context.NOTIFICATION_SERVICE
                            ) as NotificationManager

                        result.success(
                            manager
                                .canUseFullScreenIntent()
                        )

                    } else {

                        result.success(true)
                    }
                }

                "openFullScreenIntentSettings" -> {

                    if (
                        Build.VERSION.SDK_INT <
                        Build.VERSION_CODES.UPSIDE_DOWN_CAKE
                    ) {

                        result.success(true)

                        return@setMethodCallHandler
                    }

                    try {

                        val intent =
                            Intent(
                                Settings
                                    .ACTION_MANAGE_APP_USE_FULL_SCREEN_INTENT,
                                Uri.parse(
                                    "package:$packageName"
                                )
                            )

                        startActivity(intent)

                        result.success(true)

                    } catch (e: Exception) {

                        Log.e(
                            TAG,
                            "Unable to open full screen intent settings",
                            e
                        )

                        result.error(
                            "SETTINGS_ERROR",
                            e.message,
                            null
                        )
                    }
                }

                "scheduleAlarm" -> {

                    try {

                        val id =
                            call.argument<Int>(
                                "id"
                            )
                                ?: throw IllegalArgumentException(
                                    "Missing alarm id"
                                )

                        val reminderId =
                            call.argument<String>(
                                "reminderId"
                            )
                                ?: throw IllegalArgumentException(
                                    "Missing reminder id"
                                )

                        val title =
                            call.argument<String>(
                                "title"
                            )
                                ?: "Nudge Reminder"

                        val message =
                            call.argument<String>(
                                "message"
                            )
                                ?: ""

                        val vibration =
                            call.argument<Boolean>(
                                "vibration"
                            )
                                ?: true

                        val triggerAtMillis =
                            call.argument<Number>(
                                "triggerAtMillis"
                            )?.toLong()
                                ?: throw IllegalArgumentException(
                                    "Missing triggerAtMillis"
                                )

                        if (
                            triggerAtMillis <=
                            System.currentTimeMillis()
                        ) {

                            throw IllegalArgumentException(
                                "Alarm time must be in the future"
                            )
                        }

                        val alarmManager =
                            getSystemService(
                                Context.ALARM_SERVICE
                            ) as AlarmManager

                        if (
                            Build.VERSION.SDK_INT >=
                            Build.VERSION_CODES.S
                        ) {

                            if (
                                !alarmManager
                                    .canScheduleExactAlarms()
                            ) {

                                result.error(
                                    "EXACT_ALARM_PERMISSION_REQUIRED",
                                    "Allow setting alarms and reminders for Nudge.",
                                    null
                                )

                                return@setMethodCallHandler
                            }
                        }

                        val alarmIntent =
                            Intent(
                                this,
                                AlarmReceiver::class.java
                            ).apply {

                                action =
                                    ACTION_START_ALARM

                                putExtra(
                                    "id",
                                    id
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

                        val pendingIntent =
                            PendingIntent.getBroadcast(
                                this,
                                id,
                                alarmIntent,
                                PendingIntent.FLAG_UPDATE_CURRENT or
                                    PendingIntent.FLAG_IMMUTABLE
                            )

                        val showIntent =
                            Intent(
                                this,
                                MainActivity::class.java
                            ).apply {

                                putExtra(
                                    "alarm_id",
                                    id
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
                                this,
                                id,
                                showIntent,
                                PendingIntent.FLAG_UPDATE_CURRENT or
                                    PendingIntent.FLAG_IMMUTABLE
                            )

                        val alarmClockInfo =
                            AlarmManager.AlarmClockInfo(
                                triggerAtMillis,
                                showPendingIntent
                            )

                        alarmManager.setAlarmClock(
                            alarmClockInfo,
                            pendingIntent
                        )

                        Log.i(
                            TAG,
                            "ALARM_SCHEDULE_SUCCESS id=$id reminder=$reminderId trigger=$triggerAtMillis"
                        )

                        result.success(true)

                    } catch (
                        e: SecurityException
                    ) {

                        Log.e(
                            TAG,
                            "ALARM_PERMISSION_FAILURE",
                            e
                        )

                        result.error(
                            "EXACT_ALARM_PERMISSION_REQUIRED",
                            e.message,
                            null
                        )

                    } catch (
                        e: Exception
                    ) {

                        Log.e(
                            TAG,
                            "ALARM_SCHEDULE_FAILURE",
                            e
                        )

                        result.error(
                            "ALARM_ERROR",
                            e.message,
                            null
                        )
                    }
                }

                "cancelAlarm" -> {

                    try {

                        val id =
                            call.argument<Int>(
                                "id"
                            )
                                ?: throw IllegalArgumentException(
                                    "Missing alarm id"
                                )

                        val alarmManager =
                            getSystemService(
                                Context.ALARM_SERVICE
                            ) as AlarmManager

                        val intent =
                            Intent(
                                this,
                                AlarmReceiver::class.java
                            ).apply {

                                action =
                                    ACTION_START_ALARM
                            }

                        val pendingIntent =
                            PendingIntent.getBroadcast(
                                this,
                                id,
                                intent,
                                PendingIntent.FLAG_UPDATE_CURRENT or
                                    PendingIntent.FLAG_IMMUTABLE
                            )

                        alarmManager.cancel(
                            pendingIntent
                        )

                        pendingIntent.cancel()

                        result.success(true)

                    } catch (e: Exception) {

                        result.error(
                            "ALARM_CANCEL_ERROR",
                            e.message,
                            null
                        )
                    }
                }

                "dismissAlarm" -> {

                    try {

                        stopService(
                            Intent(
                                this,
                                AlarmRingingService::class.java
                            )
                        )

                        val manager =
                            getSystemService(
                                Context.NOTIFICATION_SERVICE
                            ) as NotificationManager

                        manager.cancelAll()

                        result.success(true)

                    } catch (e: Exception) {

                        result.error(
                            "DISMISS_ERROR",
                            e.message,
                            null
                        )
                    }
                }

                "closeAlarmUi" -> {
                    performCloseAlarmUi()
                    result.success(true)
                }

                "getAudioDuration" -> {
                    val filePath = call.argument<String>("filePath")
                    if (filePath == null) {
                        result.error("ARGUMENT_ERROR", "Missing filePath", null)
                        return@setMethodCallHandler
                    }
                    try {
                        val retriever = MediaMetadataRetriever()
                        retriever.setDataSource(filePath)
                        val durationStr = retriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_DURATION)
                        val title = retriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_TITLE)
                        val artist = retriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_ARTIST)
                        retriever.release()
                        val durationMs = durationStr?.toLongOrNull() ?: 0L
                        result.success(
                            mapOf(
                                "durationMs" to durationMs,
                                "title" to (title ?: File(filePath).nameWithoutExtension),
                                "artist" to (artist ?: "")
                            )
                        )
                    } catch (e: Exception) {
                        Log.e(TAG, "getAudioDuration failed", e)
                        result.error("AUDIO_ERROR", e.message, null)
                    }
                }

                "playAudioPreview" -> {
                    val filePath = call.argument<String>("filePath")
                    val startMs = call.argument<Int>("startMs") ?: 0
                    val endMs = call.argument<Int>("endMs") ?: -1

                    if (filePath == null) {
                        result.error("ARGUMENT_ERROR", "Missing filePath", null)
                        return@setMethodCallHandler
                    }
                    try {
                        stopAudioPreviewInternal()
                        previewHandler = Handler(Looper.getMainLooper())
                        previewMediaPlayer = MediaPlayer().apply {
                            setAudioAttributes(
                                AudioAttributes.Builder()
                                    .setUsage(AudioAttributes.USAGE_MEDIA)
                                    .setContentType(AudioAttributes.CONTENT_TYPE_MUSIC)
                                    .build()
                            )
                            setDataSource(filePath)
                            prepare()
                            seekTo(startMs)
                            start()
                        }
                        if (endMs > startMs) {
                            val segmentDuration = (endMs - startMs).toLong()
                            previewRunnable = object : Runnable {
                                override fun run() {
                                    try {
                                        previewMediaPlayer?.let { player ->
                                            if (player.isPlaying) {
                                                player.seekTo(startMs)
                                                previewHandler?.postDelayed(this, segmentDuration)
                                            }
                                        }
                                    } catch (e: Exception) {
                                        Log.w(TAG, "Preview loop error", e)
                                    }
                                }
                            }
                            previewHandler?.postDelayed(previewRunnable!!, segmentDuration)
                        }
                        result.success(true)
                    } catch (e: Exception) {
                        Log.e(TAG, "playAudioPreview failed", e)
                        result.error("PREVIEW_ERROR", e.message, null)
                    }
                }

                "stopAudioPreview" -> {
                    stopAudioPreviewInternal()
                    result.success(true)
                }

                "saveCustomAlarmSound" -> {
                    val filePath = call.argument<String>("filePath")
                    val startMs = call.argument<Int>("startMs") ?: 0
                    val endMs = call.argument<Int>("endMs") ?: -1
                    val title = call.argument<String>("title") ?: (filePath?.let { File(it).name } ?: "Custom Alarm")

                    val prefs = getSharedPreferences("nudge_alarm_prefs", Context.MODE_PRIVATE)
                    prefs.edit()
                        .putString("custom_sound_path", filePath)
                        .putInt("custom_start_ms", startMs)
                        .putInt("custom_end_ms", endMs)
                        .putString("custom_sound_title", title)
                        .apply()
                    result.success(true)
                }

                "getCustomAlarmSound" -> {
                    val prefs = getSharedPreferences("nudge_alarm_prefs", Context.MODE_PRIVATE)
                    val path = prefs.getString("custom_sound_path", null)
                    if (path != null && File(path).exists()) {
                        result.success(
                            mapOf(
                                "filePath" to path,
                                "startMs" to prefs.getInt("custom_start_ms", 0),
                                "endMs" to prefs.getInt("custom_end_ms", -1),
                                "title" to (prefs.getString("custom_sound_title", null) ?: File(path).name)
                            )
                        )
                    } else {
                        result.success(null)
                    }
                }

                "clearCustomAlarmSound" -> {
                    val prefs = getSharedPreferences("nudge_alarm_prefs", Context.MODE_PRIVATE)
                    prefs.edit().clear().apply()
                    result.success(true)
                }

                else -> {

                    result.notImplemented()
                }
            }
        }

        MethodChannel(
            flutterEngine.dartExecutor
                .binaryMessenger,
            RELIABILITY_CHANNEL
        ).setMethodCallHandler {
            call,
            result ->

            when (call.method) {

                "isIgnoringBatteryOptimizations" -> {

                    val powerManager =
                        getSystemService(
                            Context.POWER_SERVICE
                        ) as android.os.PowerManager

                    result.success(
                        powerManager
                            .isIgnoringBatteryOptimizations(
                                packageName
                            )
                    )
                }

                "openBatteryOptimizationSettings" -> {

                    try {

                        val intent =
                            Intent(
                                Settings
                                    .ACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS
                            ).apply {

                                data =
                                    Uri.parse(
                                        "package:$packageName"
                                    )
                            }

                        startActivity(intent)

                        result.success(true)

                    } catch (e: Exception) {

                        result.error(
                            "SETTINGS_ERROR",
                            e.message,
                            null
                        )
                    }
                }

                "openExactAlarmSettings" -> {

                    if (
                        Build.VERSION.SDK_INT <
                        Build.VERSION_CODES.S
                    ) {

                        result.success(true)

                        return@setMethodCallHandler
                    }

                    try {

                        val intent =
                            Intent(
                                Settings
                                    .ACTION_REQUEST_SCHEDULE_EXACT_ALARM,
                                Uri.parse(
                                    "package:$packageName"
                                )
                            )

                        startActivity(intent)

                        result.success(true)

                    } catch (e: Exception) {

                        Log.e(
                            TAG,
                            "Unable to open exact alarm settings",
                            e
                        )

                        try {

                            val fallback =
                                Intent(
                                    Settings
                                        .ACTION_MANAGE_APPLICATIONS_SETTINGS
                                )

                            startActivity(
                                fallback
                            )

                            result.success(true)

                        } catch (fallbackError: Exception) {

                            result.error(
                                "SETTINGS_ERROR",
                                fallbackError.message,
                                null
                            )
                        }
                    }
                }

                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}
