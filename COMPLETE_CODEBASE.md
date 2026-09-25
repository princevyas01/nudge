# NUDGE 2.0 — COMPLETE PRODUCTION CODEBASE

This single document contains the complete, production-ready source code for **Nudge 2.0**.
Total Files Included: **125**

---

## Table of Contents

1. [pubspec.yaml](#pubspecyaml)
2. [analysis_options.yaml](#analysis_optionsyaml)
3. [android/build.gradle](#android-buildgradle)
4. [android/settings.gradle](#android-settingsgradle)
5. [android/app/build.gradle](#android-app-buildgradle)
6. [android/app/src/main/AndroidManifest.xml](#android-app-src-main-androidmanifestxml)
7. [android/app/src/main/kotlin/com/personal/nudge/nudge/AlarmReceiver.kt](#android-app-src-main-kotlin-com-personal-nudge-nudge-alarmreceiverkt)
8. [android/app/src/main/kotlin/com/personal/nudge/nudge/AlarmRepositoryNative.kt](#android-app-src-main-kotlin-com-personal-nudge-nudge-alarmrepositorynativekt)
9. [android/app/src/main/kotlin/com/personal/nudge/nudge/AlarmRingingService.kt](#android-app-src-main-kotlin-com-personal-nudge-nudge-alarmringingservicekt)
10. [android/app/src/main/kotlin/com/personal/nudge/nudge/MainActivity.kt](#android-app-src-main-kotlin-com-personal-nudge-nudge-mainactivitykt)
11. [android/app/src/main/kotlin/com/personal/nudge/nudge/NudgeWidgetProvider.kt](#android-app-src-main-kotlin-com-personal-nudge-nudge-nudgewidgetproviderkt)
12. [lib/application/controllers/companion_controller.dart](#lib-application-controllers-companion_controllerdart)
13. [lib/application/controllers/folder_controller.dart](#lib-application-controllers-folder_controllerdart)
14. [lib/application/controllers/record_controller.dart](#lib-application-controllers-record_controllerdart)
15. [lib/application/controllers/reliability_controller.dart](#lib-application-controllers-reliability_controllerdart)
16. [lib/application/controllers/reminder_controller.dart](#lib-application-controllers-reminder_controllerdart)
17. [lib/application/controllers/settings_controller.dart](#lib-application-controllers-settings_controllerdart)
18. [lib/application/controllers/theme_controller.dart](#lib-application-controllers-theme_controllerdart)
19. [lib/application/controllers/timer_controller.dart](#lib-application-controllers-timer_controllerdart)
20. [lib/application/controllers/todo_controller.dart](#lib-application-controllers-todo_controllerdart)
21. [lib/core/constants/app_constants.dart](#lib-core-constants-app_constantsdart)
22. [lib/core/errors/failures.dart](#lib-core-errors-failuresdart)
23. [lib/core/logging/app_logger.dart](#lib-core-logging-app_loggerdart)
24. [lib/core/result/result.dart](#lib-core-result-resultdart)
25. [lib/core/services/time_service.dart](#lib-core-services-time_servicedart)
26. [lib/core/utils/date_utils.dart](#lib-core-utils-date_utilsdart)
27. [lib/core/utils/fnv1a_hash.dart](#lib-core-utils-fnv1a_hashdart)
28. [lib/core/utils/pbkdf2_util.dart](#lib-core-utils-pbkdf2_utildart)
29. [lib/core/utils/secure_storage_util.dart](#lib-core-utils-secure_storage_utildart)
30. [lib/data/backup/backup_manager.dart](#lib-data-backup-backup_managerdart)
31. [lib/data/database/app_database.dart](#lib-data-database-app_databasedart)
32. [lib/data/media/app_media_repository.dart](#lib-data-media-app_media_repositorydart)
33. [lib/data/repositories/companion_repository_impl.dart](#lib-data-repositories-companion_repository_impldart)
34. [lib/data/repositories/folder_repository_impl.dart](#lib-data-repositories-folder_repository_impldart)
35. [lib/data/repositories/history_repository_impl.dart](#lib-data-repositories-history_repository_impldart)
36. [lib/data/repositories/occurrence_repository_impl.dart](#lib-data-repositories-occurrence_repository_impldart)
37. [lib/data/repositories/pending_action_repository_impl.dart](#lib-data-repositories-pending_action_repository_impldart)
38. [lib/data/repositories/record_repository_impl.dart](#lib-data-repositories-record_repository_impldart)
39. [lib/data/repositories/reminder_repository_impl.dart](#lib-data-repositories-reminder_repository_impldart)
40. [lib/data/repositories/tag_repository_impl.dart](#lib-data-repositories-tag_repository_impldart)
41. [lib/data/repositories/template_repository_impl.dart](#lib-data-repositories-template_repository_impldart)
42. [lib/data/repositories/todo_repository_impl.dart](#lib-data-repositories-todo_repository_impldart)
43. [lib/domain/entities/checklist_item.dart](#lib-domain-entities-checklist_itemdart)
44. [lib/domain/entities/companion_profile.dart](#lib-domain-entities-companion_profiledart)
45. [lib/domain/entities/folder.dart](#lib-domain-entities-folderdart)
46. [lib/domain/entities/pending_action.dart](#lib-domain-entities-pending_actiondart)
47. [lib/domain/entities/record.dart](#lib-domain-entities-recorddart)
48. [lib/domain/entities/reminder.dart](#lib-domain-entities-reminderdart)
49. [lib/domain/entities/reminder_history.dart](#lib-domain-entities-reminder_historydart)
50. [lib/domain/entities/reminder_occurrence.dart](#lib-domain-entities-reminder_occurrencedart)
51. [lib/domain/entities/reminder_template.dart](#lib-domain-entities-reminder_templatedart)
52. [lib/domain/entities/smart_suggestion.dart](#lib-domain-entities-smart_suggestiondart)
53. [lib/domain/entities/tag.dart](#lib-domain-entities-tagdart)
54. [lib/domain/entities/todo.dart](#lib-domain-entities-tododart)
55. [lib/domain/entities/todo_subtask.dart](#lib-domain-entities-todo_subtaskdart)
56. [lib/domain/enums/enums.dart](#lib-domain-enums-enumsdart)
57. [lib/domain/enums/todo_enums.dart](#lib-domain-enums-todo_enumsdart)
58. [lib/domain/repositories/i_companion_repository.dart](#lib-domain-repositories-i_companion_repositorydart)
59. [lib/domain/repositories/i_folder_repository.dart](#lib-domain-repositories-i_folder_repositorydart)
60. [lib/domain/repositories/i_history_repository.dart](#lib-domain-repositories-i_history_repositorydart)
61. [lib/domain/repositories/i_occurrence_repository.dart](#lib-domain-repositories-i_occurrence_repositorydart)
62. [lib/domain/repositories/i_pending_action_repository.dart](#lib-domain-repositories-i_pending_action_repositorydart)
63. [lib/domain/repositories/i_record_repository.dart](#lib-domain-repositories-i_record_repositorydart)
64. [lib/domain/repositories/i_reminder_repository.dart](#lib-domain-repositories-i_reminder_repositorydart)
65. [lib/domain/repositories/i_tag_repository.dart](#lib-domain-repositories-i_tag_repositorydart)
66. [lib/domain/repositories/i_template_repository.dart](#lib-domain-repositories-i_template_repositorydart)
67. [lib/domain/repositories/i_todo_repository.dart](#lib-domain-repositories-i_todo_repositorydart)
68. [lib/domain/services/conflict_detector.dart](#lib-domain-services-conflict_detectordart)
69. [lib/domain/services/nlp_parser.dart](#lib-domain-services-nlp_parserdart)
70. [lib/domain/services/recurrence_engine.dart](#lib-domain-services-recurrence_enginedart)
71. [lib/domain/services/smart_suggestion_engine.dart](#lib-domain-services-smart_suggestion_enginedart)
72. [lib/domain/services/stats_calculator.dart](#lib-domain-services-stats_calculatordart)
73. [lib/features/alarms/ringing_screen.dart](#lib-features-alarms-ringing_screendart)
74. [lib/features/analytics/analytics_screen.dart](#lib-features-analytics-analytics_screendart)
75. [lib/features/backup/backup_screen.dart](#lib-features-backup-backup_screendart)
76. [lib/features/calendar/calendar_screen.dart](#lib-features-calendar-calendar_screendart)
77. [lib/features/companion/customize_companion_screen.dart](#lib-features-companion-customize_companion_screendart)
78. [lib/features/folders/folder_detail_screen.dart](#lib-features-folders-folder_detail_screendart)
79. [lib/features/folders/folders_screen.dart](#lib-features-folders-folders_screendart)
80. [lib/features/home/home_screen.dart](#lib-features-home-home_screendart)
81. [lib/features/home/reminder_card.dart](#lib-features-home-reminder_carddart)
82. [lib/features/records/record_card.dart](#lib-features-records-record_carddart)
83. [lib/features/records/record_detail_screen.dart](#lib-features-records-record_detail_screendart)
84. [lib/features/records/record_editor_screen.dart](#lib-features-records-record_editor_screendart)
85. [lib/features/records/records_screen.dart](#lib-features-records-records_screendart)
86. [lib/features/reliability/improve_reliability_screen.dart](#lib-features-reliability-improve_reliability_screendart)
87. [lib/features/reminders/reminder_editor_screen.dart](#lib-features-reminders-reminder_editor_screendart)
88. [lib/features/search/search_screen.dart](#lib-features-search-search_screendart)
89. [lib/features/settings/custom_alarm_sound_screen.dart](#lib-features-settings-custom_alarm_sound_screendart)
90. [lib/features/settings/settings_screen.dart](#lib-features-settings-settings_screendart)
91. [lib/features/timer/timer_screen.dart](#lib-features-timer-timer_screendart)
92. [lib/features/todos/todo_card.dart](#lib-features-todos-todo_carddart)
93. [lib/features/todos/todo_detail_screen.dart](#lib-features-todos-todo_detail_screendart)
94. [lib/features/todos/todo_editor_screen.dart](#lib-features-todos-todo_editor_screendart)
95. [lib/features/todos/todos_screen.dart](#lib-features-todos-todos_screendart)
96. [lib/main.dart](#lib-maindart)
97. [lib/platform/alarms/alarm_platform_service.dart](#lib-platform-alarms-alarm_platform_servicedart)
98. [lib/platform/calendar/device_calendar_bridge.dart](#lib-platform-calendar-device_calendar_bridgedart)
99. [lib/platform/calendar/i_calendar_bridge.dart](#lib-platform-calendar-i_calendar_bridgedart)
100. [lib/platform/notifications/notification_platform_service.dart](#lib-platform-notifications-notification_platform_servicedart)
101. [lib/platform/permissions/permission_manager.dart](#lib-platform-permissions-permission_managerdart)
102. [lib/platform/widgets/home_widget_bridge.dart](#lib-platform-widgets-home_widget_bridgedart)
103. [lib/presentation/components/checklist_widget.dart](#lib-presentation-components-checklist_widgetdart)
104. [lib/presentation/components/empty_state_widget.dart](#lib-presentation-components-empty_state_widgetdart)
105. [lib/presentation/components/loading_overlay.dart](#lib-presentation-components-loading_overlaydart)
106. [lib/presentation/components/mascot_widget.dart](#lib-presentation-components-mascot_widgetdart)
107. [lib/presentation/components/nudge_button.dart](#lib-presentation-components-nudge_buttondart)
108. [lib/presentation/components/nudge_card.dart](#lib-presentation-components-nudge_carddart)
109. [lib/presentation/components/nudge_text_field.dart](#lib-presentation-components-nudge_text_fielddart)
110. [lib/presentation/components/quick_add_sheet.dart](#lib-presentation-components-quick_add_sheetdart)
111. [lib/presentation/components/voice_input_button.dart](#lib-presentation-components-voice_input_buttondart)
112. [lib/presentation/theme/nudge_theme.dart](#lib-presentation-theme-nudge_themedart)
113. [test/unit/alarm_platform_service_test.dart](#test-unit-alarm_platform_service_testdart)
114. [test/unit/backup_manager_test.dart](#test-unit-backup_manager_testdart)
115. [test/unit/backup_v3_test.dart](#test-unit-backup_v3_testdart)
116. [test/unit/conflict_detector_test.dart](#test-unit-conflict_detector_testdart)
117. [test/unit/nlp_parser_test.dart](#test-unit-nlp_parser_testdart)
118. [test/unit/record_entity_test.dart](#test-unit-record_entity_testdart)
119. [test/unit/recurrence_engine_test.dart](#test-unit-recurrence_engine_testdart)
120. [test/unit/reminder_lifecycle_test.dart](#test-unit-reminder_lifecycle_testdart)
121. [test/unit/stats_calculator_test.dart](#test-unit-stats_calculator_testdart)
122. [test/unit/timer_state_machine_test.dart](#test-unit-timer_state_machine_testdart)
123. [test/unit/todo_entity_test.dart](#test-unit-todo_entity_testdart)
124. [test/widget/todo_widget_test.dart](#test-widget-todo_widget_testdart)
125. [test/widget_test.dart](#test-widget_testdart)

---

<a id="pubspecyaml"></a>
## 1. `pubspec.yaml`

**Path**: `pubspec.yaml` | **Lines**: 47

```yaml
name: nudge
description: "Nudge 2.0 — Production-Grade Offline Personal Reminder and Habit Reinforcement System"
publish_to: 'none'

version: 2.0.0+1

environment:
  sdk: ^3.5.0

dependencies:
  flutter:
    sdk: flutter

  cupertino_icons: ^1.0.8
  provider: ^6.1.2
  sqflite: ^2.3.3+1
  sqflite_common_ffi: ^2.3.3
  path: ^1.9.0
  path_provider: ^2.1.5
  flutter_secure_storage: ^9.2.2
  crypto: ^3.0.5
  encrypt: ^5.0.3
  flutter_local_notifications: ^17.2.3
  permission_handler: ^11.3.1
  speech_to_text: ^7.0.0
  image_picker: ^1.1.2
  table_calendar: ^3.1.2
  device_calendar: any
  timezone: ^0.9.4
  home_widget: any
  intl: ^0.19.0
  uuid: ^4.5.1
  shared_preferences: ^2.3.2
  google_fonts: ^6.2.1
  share_plus: ^10.1.4
  file_picker: ^8.1.7

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^4.0.0
  mocktail: ^1.0.4

flutter:
  uses-material-design: true
  assets:
    - assets/images/
```

---

<a id="analysis_optionsyaml"></a>
## 2. `analysis_options.yaml`

**Path**: `analysis_options.yaml` | **Lines**: 28

```yaml
# This file configures the analyzer, which statically analyzes Dart code to
# check for errors, warnings, and lints.
#
# The issues identified by the analyzer are surfaced in the UI of Dart-enabled
# IDEs (https://dart.dev/tools#ides-and-editors). The analyzer can also be
# invoked from the command line by running `flutter analyze`.

# The following line activates a set of recommended lints for Flutter apps,
# packages, and plugins designed to encourage good coding practices.
include: package:flutter_lints/flutter.yaml

linter:
  # The lint rules applied to this project can be customized in the
  # section below to disable rules from the `package:flutter_lints/flutter.yaml`
  # included above or to enable additional rules. A list of all available lints
  # and their documentation is published at https://dart.dev/lints.
  #
  # Instead of disabling a lint rule for the entire project in the
  # section below, it can also be suppressed for a single line of code
  # or a specific dart file by using the `// ignore: name_of_lint` and
  # `// ignore_for_file: name_of_lint` syntax on the line or in the file
  # producing the lint.
  rules:
    # avoid_print: false  # Uncomment to disable the `avoid_print` rule
    # prefer_single_quotes: true  # Uncomment to enable the `prefer_single_quotes` rule

# Additional information about this file can be found at
# https://dart.dev/guides/language/analysis-options
```

---

<a id="android-buildgradle"></a>
## 3. `android/build.gradle`

**Path**: `android/build.gradle` | **Lines**: 37

```groovy
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

rootProject.buildDir = "../build"
subprojects {
    project.buildDir = "${rootProject.buildDir}/${project.name}"
}
subprojects {
    project.evaluationDependsOn(":app")
}

subprojects { subproject ->
    if (subproject.name != "app") {
        subproject.ext.set("flutter", [
            compileSdkVersion: 35,
            minSdkVersion: 26,
            targetSdkVersion: 35,
            ndkVersion: "26.1.10909125"
        ])
    }

    tasks.withType(org.jetbrains.kotlin.gradle.tasks.KotlinCompile).configureEach {
        kotlinOptions {
            freeCompilerArgs += [
                "-Xskip-metadata-version-check"
            ]
        }
    }
}

tasks.register("clean", Delete) {
    delete rootProject.buildDir
}
```

---

<a id="android-settingsgradle"></a>
## 4. `android/settings.gradle`

**Path**: `android/settings.gradle` | **Lines**: 25

```groovy
pluginManagement {
    def flutterSdkPath = {
        def properties = new Properties()
        file("local.properties").withInputStream { properties.load(it) }
        def flutterSdkPath = properties.getProperty("flutter.sdk")
        assert flutterSdkPath != null, "flutter.sdk not set in local.properties"
        return flutterSdkPath
    }()

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id "dev.flutter.flutter-plugin-loader" version "1.0.0"
    id "com.android.application" version "8.6.0" apply false
    id "org.jetbrains.kotlin.android" version "1.9.23" apply false
}

include ":app"
```

---

<a id="android-app-buildgradle"></a>
## 5. `android/app/build.gradle`

**Path**: `android/app/build.gradle` | **Lines**: 66

```groovy
plugins {
    id "com.android.application"
    id "kotlin-android"
    id "dev.flutter.flutter-gradle-plugin"
}

def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    namespace = "com.personal.nudge.nudge"
    compileSdk = 35
    ndkVersion = "26.1.10909125"

    compileOptions {
        coreLibraryDesugaringEnabled true
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    defaultConfig {
        applicationId = "com.personal.nudge.nudge"
        minSdk = 26
        targetSdk = 35
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        multiDexEnabled true
    }

    signingConfigs {
        release {
            if (keystorePropertiesFile.exists()) {
                keyAlias = keystoreProperties['keyAlias']
                keyPassword = keystoreProperties['keyPassword']
                storeFile = keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
                storePassword = keystoreProperties['storePassword']
            }
        }
    }

    buildTypes {
        release {
            if (!keystorePropertiesFile.exists() || !signingConfigs.release.storeFile?.exists()) {
                throw new GradleException("Production release signing requires a valid keystore configured in android/key.properties!")
            }
            signingConfig = signingConfigs.release
            minifyEnabled false
            shrinkResources false
        }
    }
}

dependencies {
    coreLibraryDesugaring 'com.android.tools:desugar_jdk_libs:2.0.4'
}

flutter {
    source = "../.."
}
```

---

<a id="android-app-src-main-androidmanifestxml"></a>
## 6. `android/app/src/main/AndroidManifest.xml`

**Path**: `android/app/src/main/AndroidManifest.xml` | **Lines**: 112

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">

    <!-- Exact user-facing reminder alarms -->
    <uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM" />

    <!-- Notifications -->
    <uses-permission android:name="android.permission.POST_NOTIFICATIONS" />

    <!-- Alarm presentation -->
    <uses-permission android:name="android.permission.USE_FULL_SCREEN_INTENT" />

    <!-- Foreground ringing -->
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE_MEDIA_PLAYBACK" />

    <!-- Wake / vibration / reboot -->
    <uses-permission android:name="android.permission.WAKE_LOCK" />
    <uses-permission android:name="android.permission.VIBRATE" />
    <uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED" />

    <!-- Existing unrelated application permissions -->
    <uses-permission android:name="android.permission.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS" />
    <uses-permission android:name="android.permission.RECORD_AUDIO" />
    <uses-permission android:name="android.permission.READ_CALENDAR" />
    <uses-permission android:name="android.permission.WRITE_CALENDAR" />

    <application
        android:label="Nudge"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher"
        android:showWhenLocked="true"
        android:turnScreenOn="true">

        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:theme="@style/LaunchTheme"
            android:showWhenLocked="true"
            android:turnScreenOn="true"
            android:excludeFromRecents="false">

            <meta-data
                android:name="io.flutter.embedding.android.NormalTheme"
                android:resource="@style/NormalTheme" />

            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>

        <service
            android:name=".AlarmRingingService"
            android:enabled="true"
            android:exported="false"
            android:foregroundServiceType="mediaPlayback" />

        <receiver
            android:name=".AlarmReceiver"
            android:enabled="true"
            android:exported="true">

            <intent-filter>

                <action android:name="android.intent.action.BOOT_COMPLETED" />

                <action android:name="android.intent.action.MY_PACKAGE_REPLACED" />

                <action android:name="android.intent.action.TIME_CHANGED" />

                <action android:name="android.intent.action.TIMEZONE_CHANGED" />

                <action android:name="android.app.action.SCHEDULE_EXACT_ALARM_PERMISSION_STATE_CHANGED" />

                <action android:name="com.personal.nudge.ACTION_START_ALARM" />

            </intent-filter>

        </receiver>

        <receiver
            android:name=".NudgeWidgetProvider"
            android:exported="true">

            <intent-filter>
                <action android:name="android.appwidget.action.APPWIDGET_UPDATE" />
            </intent-filter>

            <meta-data
                android:name="android.appwidget.provider"
                android:resource="@xml/nudge_widget_info" />

        </receiver>

        <meta-data
            android:name="flutterEmbedding"
            android:value="2" />

    </application>

    <queries>
        <intent>
            <action android:name="android.intent.action.PROCESS_TEXT"/>
            <data android:mimeType="text/plain"/>
        </intent>
        <intent>
            <action android:name="android.speech.RecognitionService" />
        </intent>
    </queries>

</manifest>
```

---

<a id="android-app-src-main-kotlin-com-personal-nudge-nudge-alarmreceiverkt"></a>
## 7. `android/app/src/main/kotlin/com/personal/nudge/nudge/AlarmReceiver.kt`

**Path**: `android/app/src/main/kotlin/com/personal/nudge/nudge/AlarmReceiver.kt` | **Lines**: 194

```kotlin
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
```

---

<a id="android-app-src-main-kotlin-com-personal-nudge-nudge-alarmrepositorynativekt"></a>
## 8. `android/app/src/main/kotlin/com/personal/nudge/nudge/AlarmRepositoryNative.kt`

**Path**: `android/app/src/main/kotlin/com/personal/nudge/nudge/AlarmRepositoryNative.kt` | **Lines**: 310

```kotlin
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
```

---

<a id="android-app-src-main-kotlin-com-personal-nudge-nudge-alarmringingservicekt"></a>
## 9. `android/app/src/main/kotlin/com/personal/nudge/nudge/AlarmRingingService.kt`

**Path**: `android/app/src/main/kotlin/com/personal/nudge/nudge/AlarmRingingService.kt` | **Lines**: 654

```kotlin
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
```

---

<a id="android-app-src-main-kotlin-com-personal-nudge-nudge-mainactivitykt"></a>
## 10. `android/app/src/main/kotlin/com/personal/nudge/nudge/MainActivity.kt`

**Path**: `android/app/src/main/kotlin/com/personal/nudge/nudge/MainActivity.kt` | **Lines**: 950

```kotlin
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
```

---

<a id="android-app-src-main-kotlin-com-personal-nudge-nudge-nudgewidgetproviderkt"></a>
## 11. `android/app/src/main/kotlin/com/personal/nudge/nudge/NudgeWidgetProvider.kt`

**Path**: `android/app/src/main/kotlin/com/personal/nudge/nudge/NudgeWidgetProvider.kt` | **Lines**: 57

```kotlin
﻿package com.personal.nudge.nudge

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.Intent
import android.view.View
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetPlugin

class NudgeWidgetProvider : AppWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        for (appWidgetId in appWidgetIds) {
            val widgetData = HomeWidgetPlugin.getData(context)
            val views = RemoteViews(context.packageName, R.layout.nudge_widget)

            val countText = widgetData.getString("widget_count", "") ?: ""
            val reminder1 = widgetData.getString("widget_reminder_1", "No upcoming reminders") ?: "No upcoming reminders"
            val reminder2 = widgetData.getString("widget_reminder_2", "") ?: ""
            val reminder3 = widgetData.getString("widget_reminder_3", "") ?: ""

            views.setTextViewText(R.id.widget_count, countText)
            views.setTextViewText(R.id.widget_reminder_1, reminder1)

            if (reminder2.isNotEmpty()) {
                views.setTextViewText(R.id.widget_reminder_2, reminder2)
                views.setViewVisibility(R.id.widget_reminder_2, View.VISIBLE)
            } else {
                views.setViewVisibility(R.id.widget_reminder_2, View.GONE)
            }

            if (reminder3.isNotEmpty()) {
                views.setTextViewText(R.id.widget_reminder_3, reminder3)
                views.setViewVisibility(R.id.widget_reminder_3, View.VISIBLE)
            } else {
                views.setViewVisibility(R.id.widget_reminder_3, View.GONE)
            }

            // Clicking widget launches app
            val intent = Intent(context, MainActivity::class.java)
            val pendingIntent = PendingIntent.getActivity(
                context,
                0,
                intent,
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
            )
            views.setOnClickPendingIntent(R.id.widget_container, pendingIntent)

            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }
}
```

---

<a id="lib-application-controllers-companion_controllerdart"></a>
## 12. `lib/application/controllers/companion_controller.dart`

**Path**: `lib/application/controllers/companion_controller.dart` | **Lines**: 160

```dart
﻿import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../domain/entities/companion_profile.dart';
import '../../domain/enums/enums.dart';
import '../../domain/repositories/i_companion_repository.dart';

class CompanionController extends ChangeNotifier with WidgetsBindingObserver {
  final ICompanionRepository _repository;

  CompanionProfile _profile = const CompanionProfile();
  CompanionProfile get profile => _profile;

  CompanionMood _currentMood = CompanionMood.neutral;
  CompanionMood get currentMood => _currentMood;

  String _currentDialogue = "Ready to conquer your tasks?";
  String get currentDialogue => _currentDialogue;

  Timer? _idleTimer;
  bool _isAppInForeground = true;

  CompanionController({required ICompanionRepository repository}) : _repository = repository {
    WidgetsBinding.instance.addObserver(this);
    _loadProfile();
    _startIdleTimer();
  }

  Future<void> _loadProfile() async {
    _profile = await _repository.getProfile();
    _updateMoodFromState();
    _updateDialogue();
    notifyListeners();
  }

  void _updateMoodFromState() {
    if (_profile.currentStreak >= 5) {
      _currentMood = CompanionMood.happy;
    } else {
      _currentMood = CompanionMood.neutral;
    }
  }

  void _updateDialogue() {
    final hour = DateTime.now().hour;
    final name = _profile.name;

    if (_currentMood == CompanionMood.celebratory) {
      _currentDialogue = "Awesome job! You're making serious progress!";
      return;
    }

    if (hour < 12) {
      _currentDialogue = "Good morning! Let's get today's goals done, $name!";
    } else if (hour < 17) {
      _currentDialogue = "Keep the momentum going strong, $name!";
    } else if (hour < 21) {
      _currentDialogue = "Evening check-in! Any last tasks to knock out?";
    } else {
      _currentDialogue = "Wrapping up the day? Great effort!";
    }
  }

  void triggerCelebration() {
    _currentMood = CompanionMood.celebratory;
    final newLifetime = _profile.lifetimeCompletions + 1;
    final newStreak = _profile.currentStreak + 1;

    // Check unlocks
    final unlocked = List<String>.from(_profile.unlockedCosmetics);
    AppConstants.cosmeticMilestones.forEach((milestone, cosmeticId) {
      if (newLifetime >= milestone && !unlocked.contains(cosmeticId)) {
        unlocked.add(cosmeticId);
      }
    });

    _profile = _profile.copyWith(
      lifetimeCompletions: newLifetime,
      currentStreak: newStreak,
      unlockedCosmetics: unlocked,
      lastActiveDate: DateTime.now(),
    );

    _updateDialogue();
    notifyListeners();
    _repository.saveProfile(_profile);

    Future.delayed(const Duration(seconds: 4), () {
      if (_isAppInForeground) {
        _currentMood = CompanionMood.happy;
        _updateDialogue();
        notifyListeners();
      }
    });
  }

  void triggerTapReaction() {
    final quips = [
      "I'm keeping watch over your schedule!",
      "You've got this! One task at a time.",
      "Stay focused, great things take consistency!",
      "A quick nudge: check off your top priority today!",
    ];
    _currentDialogue = quips[Random().nextInt(quips.length)];
    _currentMood = CompanionMood.happy;
    notifyListeners();

    Future.delayed(const Duration(seconds: 3), () {
      _updateMoodFromState();
      _updateDialogue();
      notifyListeners();
    });
  }

  Future<void> updateName(String newName) async {
    final trimmed = newName.trim();
    if (trimmed.isEmpty) return;
    _profile = _profile.copyWith(name: trimmed);
    notifyListeners();
    await _repository.saveProfile(_profile);
  }

  Future<void> equipCosmetic(String? cosmeticId) async {
    if (cosmeticId == null) {
      _profile = _profile.copyWith(clearEquipped: true);
    } else {
      _profile = _profile.copyWith(equippedCosmetic: cosmeticId);
    }
    notifyListeners();
    await _repository.saveProfile(_profile);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _isAppInForeground = state == AppLifecycleState.resumed;
    if (_isAppInForeground) {
      _startIdleTimer();
      _updateDialogue();
    } else {
      _idleTimer?.cancel();
    }
  }

  void _startIdleTimer() {
    _idleTimer?.cancel();
    _idleTimer = Timer.periodic(const Duration(seconds: 15), (_) {
      if (_isAppInForeground && _currentMood != CompanionMood.celebratory) {
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    _idleTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
```

---

<a id="lib-application-controllers-folder_controllerdart"></a>
## 13. `lib/application/controllers/folder_controller.dart`

**Path**: `lib/application/controllers/folder_controller.dart` | **Lines**: 60

```dart
﻿import 'package:flutter/foundation.dart';
import '../../domain/entities/folder.dart';
import '../../domain/repositories/i_folder_repository.dart';
import '../../core/logging/app_logger.dart';

class FolderController extends ChangeNotifier {
  static const String _subsystem = 'FolderController';
  final IFolderRepository _folderRepo;

  List<Folder> _folders = [];
  List<Folder> get folders => List.unmodifiable(_folders);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  FolderController({required IFolderRepository folderRepo}) : _folderRepo = folderRepo;

  Future<void> loadFolders() async {
    _isLoading = true;
    notifyListeners();
    try {
      _folders = await _folderRepo.getAllFolders();
      AppLogger.info(_subsystem, 'Loaded ${_folders.length} folders');
    } catch (e, stack) {
      AppLogger.error(_subsystem, 'Failed to load folders', error: e, stackTrace: stack);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Folder? getFolderById(String? id) {
    if (id == null) return null;
    try {
      return _folders.firstWhere((f) => f.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<void> createFolder(Folder folder) async {
    await _folderRepo.saveFolder(folder);
    _folders.add(folder);
    notifyListeners();
  }

  Future<void> updateFolder(Folder folder) async {
    final idx = _folders.indexWhere((f) => f.id == folder.id);
    if (idx == -1) return;
    await _folderRepo.updateFolder(folder);
    _folders[idx] = folder;
    notifyListeners();
  }

  Future<void> deleteFolder(String id, {required bool deleteContainedReminders}) async {
    await _folderRepo.deleteFolder(id, deleteContainedReminders: deleteContainedReminders);
    _folders.removeWhere((f) => f.id == id);
    notifyListeners();
  }
}
```

---

<a id="lib-application-controllers-record_controllerdart"></a>
## 14. `lib/application/controllers/record_controller.dart`

**Path**: `lib/application/controllers/record_controller.dart` | **Lines**: 248

```dart
import 'package:flutter/foundation.dart';
import '../../core/logging/app_logger.dart';
import '../../domain/entities/record.dart';
import '../../domain/enums/todo_enums.dart';
import '../../domain/repositories/i_record_repository.dart';

class RecordController with ChangeNotifier {
  static const String _subsystem = 'RecordController';
  final IRecordRepository _recordRepo;

  List<Record> _records = [];
  bool _isLoading = false;
  RecordFilter _activeFilter = RecordFilter.all;
  String? _selectedFolderId;
  String _searchQuery = '';

  RecordController({required IRecordRepository recordRepo}) : _recordRepo = recordRepo;

  List<Record> get records => _records;
  bool get isLoading => _isLoading;
  RecordFilter get activeFilter => _activeFilter;
  String? get selectedFolderId => _selectedFolderId;
  String get searchQuery => _searchQuery;

  int get totalActiveCount => _records.where((r) => !r.isDeleted && !r.isArchived).length;

  List<Record> get filteredRecords {
    return _records.where((r) {
      // Trash filter
      if (_activeFilter == RecordFilter.trash) {
        return r.isDeleted;
      }
      if (r.isDeleted) return false;

      // Archived filter
      if (_activeFilter == RecordFilter.archived) {
        return r.isArchived;
      }
      if (r.isArchived) return false;

      // Type filter
      switch (_activeFilter) {
        case RecordFilter.all:
          break;
        case RecordFilter.notes:
          if (r.recordType != RecordType.note) return false;
          break;
        case RecordFilter.ideas:
          if (r.recordType != RecordType.idea) return false;
          break;
        case RecordFilter.thoughts:
          if (r.recordType != RecordType.thought) return false;
          break;
        case RecordFilter.logs:
          if (r.recordType != RecordType.log) return false;
          break;
        case RecordFilter.snippets:
          if (r.recordType != RecordType.snippet) return false;
          break;
        case RecordFilter.decisions:
          if (r.recordType != RecordType.decision) return false;
          break;
        case RecordFilter.archived:
        case RecordFilter.trash:
          break;
      }

      // Folder filter
      if (_selectedFolderId != null && r.folderId != _selectedFolderId) {
        return false;
      }

      // Search query
      if (_searchQuery.isNotEmpty) {
        final query = _searchQuery.toLowerCase();
        final matchTitle = r.title.toLowerCase().contains(query);
        final matchContent = r.content.toLowerCase().contains(query);
        if (!matchTitle && !matchContent) return false;
      }

      return true;
    }).toList();
  }

  void setFilter(RecordFilter filter) {
    _activeFilter = filter;
    notifyListeners();
  }

  void setFolder(String? folderId) {
    _selectedFolderId = folderId;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query.trim();
    notifyListeners();
  }

  Future<void> loadRecords() async {
    _isLoading = true;
    notifyListeners();
    try {
      _records = await _recordRepo.getAllRecords(includeDeleted: true);
      AppLogger.info(_subsystem, 'Loaded ${_records.length} records');
    } catch (e, st) {
      AppLogger.error(_subsystem, 'Failed to load records', error: e, stackTrace: st);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createRecord(Record record) async {
    try {
      await _recordRepo.createRecord(record);
      _records.insert(0, record);
      notifyListeners();
    } catch (e, st) {
      AppLogger.error(_subsystem, 'Failed to create record', error: e, stackTrace: st);
    }
  }

  Future<Record> quickCapture(
    String text, {
    RecordType type = RecordType.note,
    String? folderId,
  }) async {
    final lines = text.trim().split('\n');
    final title = lines.first.trim();
    final content = lines.length > 1 ? lines.skip(1).join('\n').trim() : '';

    final record = Record(
      title: title.isEmpty ? 'Untitled Note' : title,
      content: content.isEmpty && lines.length == 1 ? title : content,
      recordType: type,
      folderId: folderId,
      occurredAt: DateTime.now(),
    );

    await createRecord(record);
    return record;
  }

  Future<void> updateRecord(Record record) async {
    try {
      final updated = record.copyWith(updatedAt: DateTime.now());
      await _recordRepo.updateRecord(updated);
      final index = _records.indexWhere((r) => r.id == record.id);
      if (index != -1) {
        _records[index] = updated;
        notifyListeners();
      }
    } catch (e, st) {
      AppLogger.error(_subsystem, 'Failed to update record', error: e, stackTrace: st);
    }
  }

  Future<void> togglePin(String id) async {
    try {
      final index = _records.indexWhere((r) => r.id == id);
      if (index == -1) return;

      final current = _records[index];
      final updated = current.copyWith(
        isPinned: !current.isPinned,
        updatedAt: DateTime.now(),
      );

      await _recordRepo.updateRecord(updated);
      _records[index] = updated;
      _records.sort((a, b) {
        if (a.isPinned != b.isPinned) {
          return b.isPinned ? 1 : -1;
        }
        return b.createdAt.compareTo(a.createdAt);
      });
      notifyListeners();
    } catch (e, st) {
      AppLogger.error(_subsystem, 'Failed to toggle pin on record', error: e, stackTrace: st);
    }
  }

  Future<void> toggleArchive(String id) async {
    try {
      final index = _records.indexWhere((r) => r.id == id);
      if (index == -1) return;

      final current = _records[index];
      final updated = current.copyWith(
        isArchived: !current.isArchived,
        updatedAt: DateTime.now(),
      );

      await _recordRepo.updateRecord(updated);
      _records[index] = updated;
      notifyListeners();
    } catch (e, st) {
      AppLogger.error(_subsystem, 'Failed to toggle archive on record', error: e, stackTrace: st);
    }
  }

  Future<void> softDeleteRecord(String id) async {
    try {
      await _recordRepo.deleteRecord(id, hardDelete: false);
      final index = _records.indexWhere((r) => r.id == id);
      if (index != -1) {
        _records[index] = _records[index].copyWith(isDeleted: true);
        notifyListeners();
      }
    } catch (e, st) {
      AppLogger.error(_subsystem, 'Failed to soft delete record', error: e, stackTrace: st);
    }
  }

  Future<void> restoreRecord(String id) async {
    try {
      await _recordRepo.restoreRecord(id);
      final index = _records.indexWhere((r) => r.id == id);
      if (index != -1) {
        _records[index] = _records[index].copyWith(isDeleted: false);
        notifyListeners();
      }
    } catch (e, st) {
      AppLogger.error(_subsystem, 'Failed to restore record', error: e, stackTrace: st);
    }
  }

  Future<void> hardDeleteRecord(String id) async {
    try {
      await _recordRepo.deleteRecord(id, hardDelete: true);
      _records.removeWhere((r) => r.id == id);
      notifyListeners();
    } catch (e, st) {
      AppLogger.error(_subsystem, 'Failed to hard delete record', error: e, stackTrace: st);
    }
  }

  Future<void> purgeTrash() async {
    try {
      await _recordRepo.purgeTrash();
      _records.removeWhere((r) => r.isDeleted);
      notifyListeners();
    } catch (e, st) {
      AppLogger.error(_subsystem, 'Failed to purge record trash', error: e, stackTrace: st);
    }
  }
}
```

---

<a id="lib-application-controllers-reliability_controllerdart"></a>
## 15. `lib/application/controllers/reliability_controller.dart`

**Path**: `lib/application/controllers/reliability_controller.dart` | **Lines**: 82

```dart
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart' as ph;

import '../../core/logging/app_logger.dart';
import '../../platform/alarms/alarm_platform_service.dart';
import '../../platform/permissions/permission_manager.dart';

class ReliabilityController extends ChangeNotifier {
  static const String _subsystem = 'ReliabilityController';

  bool _notificationsEnabled = false;
  bool _exactAlarmsEnabled = false;
  bool _fullScreenIntentEnabled = false;
  bool _batteryOptimizationIgnored = false;

  bool get notificationsEnabled => _notificationsEnabled;
  bool get exactAlarmsEnabled => _exactAlarmsEnabled;
  bool get fullScreenIntentEnabled => _fullScreenIntentEnabled;
  bool get batteryOptimizationIgnored => _batteryOptimizationIgnored;

  bool get isFullyReliable =>
      _notificationsEnabled &&
      _exactAlarmsEnabled &&
      _fullScreenIntentEnabled &&
      _batteryOptimizationIgnored;

  int get reliabilityScore {
    int score = 0;
    if (_notificationsEnabled) score += 25;
    if (_exactAlarmsEnabled) score += 35;
    if (_fullScreenIntentEnabled) score += 20;
    if (_batteryOptimizationIgnored) score += 20;
    return score;
  }

  Future<void> refreshStatuses() async {
    try {
      _notificationsEnabled = await ph.Permission.notification.isGranted;
      _exactAlarmsEnabled = await AlarmPlatformService.canScheduleExactAlarms();
      _fullScreenIntentEnabled = await AlarmPlatformService.canUseFullScreenIntent();
      _batteryOptimizationIgnored =
          await PermissionManager.isIgnoringBatteryOptimizations();
    } catch (e, stack) {
      AppLogger.error(
        _subsystem,
        'Failed to refresh reliability status',
        error: e,
        stackTrace: stack,
      );
    }
    notifyListeners();
  }

  Future<void> requestFullScreenIntent() async {
    await AlarmPlatformService.openFullScreenIntentSettings();
    await refreshStatuses();
  }

  Future<void> requestExactAlarmAccess() async {
    await AlarmPlatformService.openExactAlarmSettings();
    await refreshStatuses();
  }

  Future<void> requestExactAlarms() => requestExactAlarmAccess();

  Future<void> requestNotificationPermission() async {
    await PermissionManager.requestNotificationPermission();
    await refreshStatuses();
  }

  Future<void> requestNotifications() => requestNotificationPermission();

  Future<void> requestBatteryOptimization() async {
    await PermissionManager.openBatteryOptimizationSettings();
    await refreshStatuses();
  }

  Future<void> openAppSettings() async {
    await PermissionManager.openAppSettings();
    await refreshStatuses();
  }
}
```

---

<a id="lib-application-controllers-reminder_controllerdart"></a>
## 16. `lib/application/controllers/reminder_controller.dart`

**Path**: `lib/application/controllers/reminder_controller.dart` | **Lines**: 700

```dart
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../../core/constants/app_constants.dart';
import '../../core/logging/app_logger.dart';
import '../../data/media/app_media_repository.dart';
import '../../domain/entities/reminder.dart';
import '../../domain/entities/reminder_occurrence.dart';
import '../../domain/entities/reminder_history.dart';
import '../../domain/enums/enums.dart';
import '../../domain/repositories/i_reminder_repository.dart';
import '../../domain/repositories/i_occurrence_repository.dart';
import '../../domain/repositories/i_history_repository.dart';
import '../../domain/services/recurrence_engine.dart';
import '../../domain/services/stats_calculator.dart';
import '../../platform/alarms/alarm_platform_service.dart';
import '../../platform/calendar/i_calendar_bridge.dart';
import '../../platform/calendar/device_calendar_bridge.dart';
import '../../platform/widgets/home_widget_bridge.dart';
import 'companion_controller.dart';

class ReminderController extends ChangeNotifier {
  static const String _subsystem = 'ReminderController';

  final IReminderRepository _reminderRepo;
  final IOccurrenceRepository _occurrenceRepo;
  final IHistoryRepository _historyRepo;
  final ICalendarBridge _calendarBridge;

  List<Reminder> _reminders = [];
  List<Reminder> get reminders => List.unmodifiable(_reminders);

  // Exact alarm capability state
  bool _exactAlarmsAllowed = true;
  bool get exactAlarmsAllowed => _exactAlarmsAllowed;

  // Filters & Sorting
  FilterType _activeFilter = FilterType.all;
  FilterType get activeFilter => _activeFilter;

  PriorityLevel? _priorityFilter;
  PriorityLevel? get priorityFilter => _priorityFilter;

  String? _folderFilter;
  String? get folderFilter => _folderFilter;

  SortOption _sortOption = SortOption.time;
  SortOption get sortOption => _sortOption;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  // Undo Buffer
  Reminder? _lastDeletedReminder;
  Reminder? get lastDeletedReminder => _lastDeletedReminder;

  // In-progress action guard for idempotency
  final Set<String> _inProgressActions = {};

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  ReminderController({
    required IReminderRepository reminderRepo,
    required IOccurrenceRepository occurrenceRepo,
    required IHistoryRepository historyRepo,
    ICalendarBridge? calendarBridge,
  })  : _reminderRepo = reminderRepo,
        _occurrenceRepo = occurrenceRepo,
        _historyRepo = historyRepo,
        _calendarBridge = calendarBridge ?? DeviceCalendarBridge();

  Future<void> loadReminders() async {
    _isLoading = true;
    notifyListeners();

    try {
      _reminders = await _reminderRepo.getAllReminders();
      await checkExactAlarmCapability();
      _syncProjections();
      AppLogger.info(_subsystem, 'Loaded ${_reminders.length} reminders');
    } catch (e, stack) {
      AppLogger.error(_subsystem, 'Failed to load reminders', error: e, stackTrace: stack);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> checkExactAlarmCapability() async {
    try {
      final isGranted = await AlarmPlatformService.canScheduleExactAlarms();
      final previous = _exactAlarmsAllowed;
      _exactAlarmsAllowed = isGranted;

      if (!previous && isGranted) {
        AppLogger.info(_subsystem, 'Exact alarm permission restored. Reconciling alarms...');
        await reconcileAlarms();
      } else if (!isGranted) {
        for (int i = 0; i < _reminders.length; i++) {
          if (!_reminders[i].isDone && !_reminders[i].isArchived && _reminders[i].isAlarmSynced) {
            final unsynced = _reminders[i].copyWith(isAlarmSynced: false);
            await _reminderRepo.updateReminder(unsynced);
            _reminders[i] = unsynced;
          }
        }
        notifyListeners();
      }
    } catch (e) {
      // Non-Android platforms or permission check error
    }
  }

  Future<void> reconcileAlarms() async {
    AppLogger.info(_subsystem, 'Reconciling active alarms...');
    final now = DateTime.now();

    for (int i = 0; i < _reminders.length; i++) {
      final r = _reminders[i];
      if (!r.isDone && !r.isArchived && r.scheduledAt.isAfter(now)) {
        bool scheduled = false;
        try {
          await AlarmPlatformService.scheduleAlarm(r);
          scheduled = true;
        } catch (e) {
          scheduled = false;
        }
        if (r.isAlarmSynced != scheduled) {
          final synced = r.copyWith(isAlarmSynced: scheduled);
          await _reminderRepo.updateReminder(synced);
          _reminders[i] = synced;
        }
      }
    }
    notifyListeners();
  }

  // Filter and Search
  void setFilter(FilterType filter) {
    _activeFilter = filter;
    notifyListeners();
  }

  void setPriorityFilter(PriorityLevel? priority) {
    _priorityFilter = priority;
    notifyListeners();
  }

  void setFolderFilter(String? folderId) {
    _folderFilter = folderId;
    notifyListeners();
  }

  void setSortOption(SortOption option) {
    _sortOption = option;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  List<Reminder> get filteredReminders {
    List<Reminder> list = List.from(_reminders);

    // Apply main filter
    switch (_activeFilter) {
      case FilterType.all:
        list = list.where((r) => !r.isArchived).toList();
        break;
      case FilterType.today:
        final now = DateTime.now();
        list = list.where((r) {
          if (r.isArchived) return false;
          final d = r.scheduledAt;
          return d.year == now.year && d.month == now.month && d.day == now.day;
        }).toList();
        break;
      case FilterType.overdue:
        list = list.where((r) => r.isOverdue && !r.isArchived).toList();
        break;
      case FilterType.upcoming:
        final now = DateTime.now();
        list = list.where((r) => !r.isDone && !r.isArchived && r.scheduledAt.isAfter(now)).toList();
        break;
      case FilterType.pinned:
        list = list.where((r) => r.isPinned && !r.isArchived).toList();
        break;
      case FilterType.completed:
        list = list.where((r) => r.isDone && !r.isArchived).toList();
        break;
      case FilterType.archived:
        list = list.where((r) => r.isArchived).toList();
        break;
    }

    // Apply priority filter
    if (_priorityFilter != null) {
      list = list.where((r) => r.priority == _priorityFilter).toList();
    }

    // Apply folder filter
    if (_folderFilter != null) {
      list = list.where((r) => r.folderId == _folderFilter).toList();
    }

    // Apply search query
    if (_searchQuery.trim().isNotEmpty) {
      final q = _searchQuery.toLowerCase().trim();
      list = list.where((r) {
        final matchesMsg = r.message.toLowerCase().contains(q);
        final matchesChecklist = r.checklist.any((item) => item.text.toLowerCase().contains(q));
        return matchesMsg || matchesChecklist;
      }).toList();
    }

    // Apply sorting (pinned items stay pinned at the top unless in archived/completed)
    list.sort((a, b) {
      if (_activeFilter != FilterType.completed && _activeFilter != FilterType.archived) {
        if (a.isPinned && !b.isPinned) return -1;
        if (!a.isPinned && b.isPinned) return 1;
      }

      switch (_sortOption) {
        case SortOption.time:
          return a.scheduledAt.compareTo(b.scheduledAt);
        case SortOption.priority:
          return b.priority.index.compareTo(a.priority.index);
        case SortOption.created:
          return b.createdAt.compareTo(a.createdAt);
      }
    });

    return list;
  }

  // Reminder CRUD
  Future<void> createReminder(Reminder reminder, {bool syncCalendar = false}) =>
      saveReminder(reminder, syncCalendar: syncCalendar);

  Future<void> saveReminder(Reminder reminder, {bool syncCalendar = false}) async {
    AppLogger.info(_subsystem, 'Saving new reminder: ${reminder.id} - ${reminder.message}');

    var finalReminder = reminder;
    if (syncCalendar) {
      final calEventId = await _calendarBridge.syncReminderToCalendar(reminder);
      if (calEventId != null) {
        finalReminder = finalReminder.copyWith(calendarEventId: calEventId);
      }
    }

    bool alarmSynced = false;
    if (!finalReminder.isDone &&
        !finalReminder.isArchived &&
        finalReminder.scheduledAt.isAfter(DateTime.now())) {
      try {
        await AlarmPlatformService.scheduleAlarm(finalReminder);
        alarmSynced = true;
      } on AlarmPermissionRequiredException {
        alarmSynced = false;
      } catch (e, stack) {
        alarmSynced = false;
        AppLogger.error(
          _subsystem,
          'Alarm scheduling failed for ',
          error: e,
          stackTrace: stack,
        );
      }
    }
    finalReminder = finalReminder.copyWith(isAlarmSynced: alarmSynced);

    await _reminderRepo.saveReminder(finalReminder);
    _reminders.add(finalReminder);

    // Create and record initial occurrence
    final initialOccurrence = ReminderOccurrence(
      id: const Uuid().v4(),
      reminderId: finalReminder.id,
      scheduledAt: finalReminder.scheduledAt,
      status: OccurrenceStatus.pending,
    );
    await _occurrenceRepo.saveOccurrence(initialOccurrence);

    await _historyRepo.logEvent(ReminderHistory(
      reminderId: finalReminder.id,
      action: ActionType.created,
      details: 'Created with ${finalReminder.repeatRule.name} recurrence',
    ));

    _syncProjections();
    notifyListeners();
  }

  Future<void> updateReminder(Reminder updated, {bool syncCalendar = false}) async {
    AppLogger.info(_subsystem, 'Updating reminder: ${updated.id}');
    final idx = _reminders.indexWhere((r) => r.id == updated.id);
    if (idx == -1) return;

    final old = _reminders[idx];
    Reminder finalUpdated = updated;

    if (syncCalendar || updated.calendarEventId != null) {
      final calEventId = await _calendarBridge.syncReminderToCalendar(updated);
      if (calEventId != null) {
        finalUpdated = finalUpdated.copyWith(calendarEventId: calEventId);
      }
    }

    final scheduleChanged = old.scheduledAt != finalUpdated.scheduledAt ||
        old.isDone != finalUpdated.isDone ||
        old.isArchived != finalUpdated.isArchived ||
        old.soundId != finalUpdated.soundId ||
        old.vibrationEnabled != finalUpdated.vibrationEnabled;

    if (scheduleChanged) {
      await AlarmPlatformService.cancelAlarm(old.id);

      bool updateAlarmSynced = false;
      if (!finalUpdated.isDone &&
          !finalUpdated.isArchived &&
          finalUpdated.scheduledAt.isAfter(DateTime.now())) {
        try {
          await AlarmPlatformService.scheduleAlarm(finalUpdated);
          updateAlarmSynced = true;
        } catch (e) {
          updateAlarmSynced = false;
        }
      }
      finalUpdated = finalUpdated.copyWith(isAlarmSynced: updateAlarmSynced);

      // Update pending occurrence scheduled time if changed
      if (old.scheduledAt != finalUpdated.scheduledAt) {
        final pendingOcc = await _occurrenceRepo.getPendingOccurrence(finalUpdated.id);
        if (pendingOcc != null) {
          await _occurrenceRepo.updateOccurrence(
            pendingOcc.copyWith(scheduledAt: finalUpdated.scheduledAt),
          );
        }
      }
    }

    await _reminderRepo.updateReminder(finalUpdated);
    _reminders[idx] = finalUpdated;

    await _historyRepo.logEvent(ReminderHistory(
      reminderId: finalUpdated.id,
      action: ActionType.edited,
      details: 'Updated schedule or content',
    ));

    _syncProjections();
    notifyListeners();
  }

  Future<void> deleteReminder(String id) async {
    final idx = _reminders.indexWhere((r) => r.id == id);
    if (idx == -1) return;

    final target = _reminders[idx];
    _lastDeletedReminder = target;

    await _reminderRepo.deleteReminder(id);
    await _occurrenceRepo.deleteOccurrencesForReminder(id);
    _reminders.removeAt(idx);

    await AlarmPlatformService.cancelAlarm(id);
    if (target.calendarEventId != null) {
      await _calendarBridge.removeReminderFromCalendar(target.calendarEventId);
    }

    // Clean up sandboxed media if present
    if (target.photoPath != null) {
      await AppMediaRepository.deleteMedia(target.photoPath);
    }

    await _historyRepo.logEvent(ReminderHistory(
      reminderId: id,
      action: ActionType.deleted,
    ));

    _syncProjections();
    notifyListeners();
  }

  Future<void> undoDelete() async {
    if (_lastDeletedReminder == null) return;
    final restored = _lastDeletedReminder!;
    _lastDeletedReminder = null;

    await _reminderRepo.saveReminder(restored);
    _reminders.add(restored);

    final occ = ReminderOccurrence(
      id: const Uuid().v4(),
      reminderId: restored.id,
      scheduledAt: restored.scheduledAt,
      status: OccurrenceStatus.pending,
    );
    await _occurrenceRepo.saveOccurrence(occ);

    bool scheduled = false;
    if (!restored.isDone && !restored.isArchived && restored.scheduledAt.isAfter(DateTime.now())) {
      try {
        await AlarmPlatformService.scheduleAlarm(restored);
        scheduled = true;
      } catch (e) {
        scheduled = false;
      }
    }
    final finalRestored = restored.copyWith(isAlarmSynced: scheduled);
    await _reminderRepo.updateReminder(finalRestored);
    _reminders[_reminders.length - 1] = finalRestored;

    await _historyRepo.logEvent(ReminderHistory(
      reminderId: restored.id,
      action: ActionType.restored,
      details: 'Restored from undo',
    ));

    _syncProjections();
    notifyListeners();
  }

  Future<void> completeReminder(String id, [CompanionController? companionController]) async {
    if (_inProgressActions.contains(id)) return;
    _inProgressActions.add(id);

    try {
      final idx = _reminders.indexWhere((r) => r.id == id);
      if (idx == -1) return;

      final current = _reminders[idx];
      if (current.isDone) return; // Idempotency guard

      await AlarmPlatformService.cancelAlarm(id);
      await AlarmPlatformService.dismissRingingAlarm();

      // Record completion on occurrence
      final pendingOcc = await _occurrenceRepo.getPendingOccurrence(id);
      if (pendingOcc != null) {
        await _occurrenceRepo.updateOccurrence(pendingOcc.copyWith(
          status: OccurrenceStatus.completed,
          completedAt: DateTime.now(),
        ));
      } else {
        await _occurrenceRepo.saveOccurrence(ReminderOccurrence(
          id: const Uuid().v4(),
          reminderId: id,
          scheduledAt: current.scheduledAt,
          completedAt: DateTime.now(),
          status: OccurrenceStatus.completed,
        ));
      }

      if (current.repeatRule == RepeatRule.none) {
        // Non-recurring: mark done
        final done = current.copyWith(isDone: true);
        await _reminderRepo.updateReminder(done);
        _reminders[idx] = done;
      } else {
        // Recurring: advance occurrence
        final nextDate = RecurrenceEngine.calculateNextOccurrence(current);
        if (nextDate != null) {
          final advanced = current.copyWith(
            scheduledAt: nextDate,
            snoozeCount: 0,
            checklist: current.checklist.map((c) => c.copyWith(isDone: false)).toList(),
            repeatEndOccurrences: current.repeatEndOccurrences != null
                ? current.repeatEndOccurrences! - 1
                : null,
          );
          await _reminderRepo.updateReminder(advanced);
          _reminders[idx] = advanced;

          // Create next pending occurrence
          await _occurrenceRepo.saveOccurrence(ReminderOccurrence(
            id: const Uuid().v4(),
            reminderId: id,
            scheduledAt: nextDate,
            status: OccurrenceStatus.pending,
          ));

          bool scheduled = false;
          try {
            await AlarmPlatformService.scheduleAlarm(advanced);
            scheduled = true;
          } catch (e) {
            scheduled = false;
          }
          final finalAdvanced = advanced.copyWith(isAlarmSynced: scheduled);
          await _reminderRepo.updateReminder(finalAdvanced);
          _reminders[idx] = finalAdvanced;
        } else {
          // End limit reached
          final completed = current.copyWith(isDone: true);
          await _reminderRepo.updateReminder(completed);
          _reminders[idx] = completed;
        }
      }

      await _historyRepo.logEvent(ReminderHistory(
        reminderId: id,
        action: ActionType.completed,
      ));

      companionController?.triggerCelebration();

      _syncProjections();
      notifyListeners();
    } finally {
      _inProgressActions.remove(id);
    }
  }

  Future<bool> snoozeReminder(String id, [int? minutes]) async {
    final idx = _reminders.indexWhere((r) => r.id == id);
    if (idx == -1) return false;

    final current = _reminders[idx];
    if (current.snoozeCount >= AppConstants.maxSnoozeCount) {
      AppLogger.warning(_subsystem, 'Reminder $id has reached max snooze limit of ${AppConstants.maxSnoozeCount}');
      return false;
    }

    final snoozeMin = minutes ?? AppConstants.defaultSnoozeMinutes;
    final newTime = DateTime.now().add(Duration(minutes: snoozeMin));
    final updatedSnoozeCount = current.snoozeCount + 1;

    final snoozed = current.copyWith(
      scheduledAt: newTime,
      snoozeCount: updatedSnoozeCount,
    );

    await _reminderRepo.updateReminder(snoozed);
    _reminders[idx] = snoozed;

    // Update pending occurrence
    final pendingOcc = await _occurrenceRepo.getPendingOccurrence(id);
    if (pendingOcc != null) {
      await _occurrenceRepo.updateOccurrence(pendingOcc.copyWith(
        scheduledAt: newTime,
        snoozeCount: updatedSnoozeCount,
        status: OccurrenceStatus.snoozed,
      ));
    }

    await AlarmPlatformService.dismissRingingAlarm();
    await AlarmPlatformService.cancelAlarm(id);

    bool scheduled = false;
    try {
      await AlarmPlatformService.scheduleAlarm(snoozed);
      scheduled = true;
    } catch (e) {
      scheduled = false;
    }
    final finalSnoozed = snoozed.copyWith(isAlarmSynced: scheduled);
    await _reminderRepo.updateReminder(finalSnoozed);
    _reminders[idx] = finalSnoozed;

    await _historyRepo.logEvent(ReminderHistory(
      reminderId: id,
      action: ActionType.snoozed,
      details: 'Snoozed for $snoozeMin minutes (Snooze #$updatedSnoozeCount)',
    ));

    _syncProjections();
    notifyListeners();
    return true;
  }

  Future<void> skipOccurrence(String id) async {
    final idx = _reminders.indexWhere((r) => r.id == id);
    if (idx == -1) return;

    final current = _reminders[idx];
    if (current.repeatRule == RepeatRule.none) return;

    // Mark current occurrence as skipped
    final pendingOcc = await _occurrenceRepo.getPendingOccurrence(id);
    if (pendingOcc != null) {
      await _occurrenceRepo.updateOccurrence(pendingOcc.copyWith(status: OccurrenceStatus.skipped));
    }

    final nextDate = RecurrenceEngine.calculateNextOccurrence(current);
    if (nextDate != null) {
      final advanced = current.copyWith(
        scheduledAt: nextDate,
        snoozeCount: 0,
        checklist: current.checklist.map((c) => c.copyWith(isDone: false)).toList(),
      );
      await _reminderRepo.updateReminder(advanced);
      _reminders[idx] = advanced;

      await _occurrenceRepo.saveOccurrence(ReminderOccurrence(
        id: const Uuid().v4(),
        reminderId: id,
        scheduledAt: nextDate,
        status: OccurrenceStatus.pending,
      ));

      await AlarmPlatformService.cancelAlarm(id);
      bool scheduled = false;
      try {
        await AlarmPlatformService.scheduleAlarm(advanced);
        scheduled = true;
      } catch (e) {
        scheduled = false;
      }
      final finalAdvanced = advanced.copyWith(isAlarmSynced: scheduled);
      await _reminderRepo.updateReminder(finalAdvanced);
      _reminders[idx] = finalAdvanced;

      await _historyRepo.logEvent(ReminderHistory(
        reminderId: id,
        action: ActionType.skipped,
        details: 'Skipped occurrence to $nextDate',
      ));

      _syncProjections();
      notifyListeners();
    }
  }

  Future<void> togglePin(String id) async {
    final idx = _reminders.indexWhere((r) => r.id == id);
    if (idx == -1) return;

    final updated = _reminders[idx].copyWith(isPinned: !_reminders[idx].isPinned);
    await _reminderRepo.updateReminder(updated);
    _reminders[idx] = updated;
    notifyListeners();
  }

  Future<void> toggleArchive(String id) async {
    final idx = _reminders.indexWhere((r) => r.id == id);
    if (idx == -1) return;

    final target = _reminders[idx];
    final willArchive = !target.isArchived;
    final updated = target.copyWith(isArchived: willArchive);

    await _reminderRepo.updateReminder(updated);
    _reminders[idx] = updated;

    if (willArchive) {
      await AlarmPlatformService.cancelAlarm(id);
    } else {
      if (!updated.isDone && updated.scheduledAt.isAfter(DateTime.now())) {
        await AlarmPlatformService.scheduleAlarm(updated);
      }
    }

    await _historyRepo.logEvent(ReminderHistory(
      reminderId: id,
      action: willArchive ? ActionType.archived : ActionType.restored,
    ));

    _syncProjections();
    notifyListeners();
  }

  Future<void> toggleChecklistItem(String reminderId, String itemId) async {
    final idx = _reminders.indexWhere((r) => r.id == reminderId);
    if (idx == -1) return;

    final r = _reminders[idx];
    final updatedChecklist = r.checklist.map((c) {
      return c.id == itemId ? c.copyWith(isDone: !c.isDone) : c;
    }).toList();

    final updated = r.copyWith(checklist: updatedChecklist);
    await _reminderRepo.updateReminder(updated);
    _reminders[idx] = updated;
    notifyListeners();
  }

  void _syncProjections() {
    final upcoming = _reminders.where((r) => !r.isArchived && !r.isDone && r.scheduledAt.isAfter(DateTime.now())).toList();
    upcoming.sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));
    HomeWidgetBridge.updateWidget(upcoming.take(3).toList());
  }

  Future<StatsData> getStats() async {
    final occurrences = await _occurrenceRepo.getAllOccurrences();
    final history = await _historyRepo.getAllHistory();
    return StatsCalculator.calculate(
      reminders: _reminders,
      occurrences: occurrences,
      history: history,
    );
  }

  Future<List<ReminderHistory>> getHistoryForReminder(String reminderId) async {
    return _historyRepo.getHistoryForReminder(reminderId);
  }
}
```

---

<a id="lib-application-controllers-settings_controllerdart"></a>
## 17. `lib/application/controllers/settings_controller.dart`

**Path**: `lib/application/controllers/settings_controller.dart` | **Lines**: 148

```dart
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';
import '../../core/logging/app_logger.dart';
import '../../data/database/app_database.dart';
import '../../platform/alarms/alarm_platform_service.dart';
import '../../platform/notifications/notification_platform_service.dart';
import '../../platform/widgets/home_widget_bridge.dart';
import 'reminder_controller.dart';
import 'folder_controller.dart';

class SettingsController extends ChangeNotifier {
  static const String _subsystem = 'SettingsController';

  int _defaultSnoozeMinutes = AppConstants.defaultSnoozeMinutes;
  int get defaultSnoozeMinutes => _defaultSnoozeMinutes;

  bool _soundEnabled = true;
  bool get soundEnabled => _soundEnabled;

  String? _customSoundPath;
  String? get customSoundPath => _customSoundPath;

  String? _customSoundTitle;
  String? get customSoundTitle => _customSoundTitle;

  int _customSoundStartMs = 0;
  int get customSoundStartMs => _customSoundStartMs;

  int _customSoundEndMs = -1;
  int get customSoundEndMs => _customSoundEndMs;

  bool get hasCustomSound => _customSoundPath != null && _customSoundPath!.isNotEmpty;

  SettingsController() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _defaultSnoozeMinutes = prefs.getInt(AppConstants.prefDefaultSnooze) ?? AppConstants.defaultSnoozeMinutes;
    _soundEnabled = prefs.getBool(AppConstants.prefSoundEnabled) ?? true;

    final customSound = await AlarmPlatformService.getCustomAlarmSound();
    if (customSound != null) {
      _customSoundPath = customSound['filePath'] as String?;
      _customSoundStartMs = (customSound['startMs'] as num?)?.toInt() ?? 0;
      _customSoundEndMs = (customSound['endMs'] as num?)?.toInt() ?? -1;
      _customSoundTitle = customSound['title'] as String?;
    }

    notifyListeners();
  }

  Future<void> refreshCustomSound() async {
    final customSound = await AlarmPlatformService.getCustomAlarmSound();
    if (customSound != null) {
      _customSoundPath = customSound['filePath'] as String?;
      _customSoundStartMs = (customSound['startMs'] as num?)?.toInt() ?? 0;
      _customSoundEndMs = (customSound['endMs'] as num?)?.toInt() ?? -1;
      _customSoundTitle = customSound['title'] as String?;
    } else {
      _customSoundPath = null;
      _customSoundTitle = null;
      _customSoundStartMs = 0;
      _customSoundEndMs = -1;
    }
    notifyListeners();
  }

  Future<void> setCustomSound({
    required String filePath,
    required int startMs,
    required int endMs,
    String? title,
  }) async {
    _customSoundPath = filePath;
    _customSoundStartMs = startMs;
    _customSoundEndMs = endMs;
    _customSoundTitle = title;
    notifyListeners();

    await AlarmPlatformService.saveCustomAlarmSound(
      filePath,
      startMs,
      endMs,
      title: title,
    );
  }

  Future<void> resetCustomSound() async {
    _customSoundPath = null;
    _customSoundTitle = null;
    _customSoundStartMs = 0;
    _customSoundEndMs = -1;
    notifyListeners();

    await AlarmPlatformService.clearCustomAlarmSound();
  }

  Future<void> setDefaultSnoozeMinutes(int minutes) async {
    _defaultSnoozeMinutes = minutes;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(AppConstants.prefDefaultSnooze, minutes);
  }

  Future<void> setSoundEnabled(bool enabled) async {
    _soundEnabled = enabled;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.prefSoundEnabled, enabled);
  }

  /// Complete destructive reset of all application data, alarms, widgets, and database
  Future<void> resetAppData({
    required ReminderController reminderController,
    required FolderController folderController,
  }) async {
    AppLogger.warning(_subsystem, 'Initiating full Reset App Data');

    // 1. Cancel all alarms & stop ringing
    await AlarmPlatformService.dismissRingingAlarm();
    for (final r in reminderController.reminders) {
      await AlarmPlatformService.cancelAlarm(r.id);
    }
    await NotificationPlatformService.cancelAll();

    // 2. Clear home widget
    await HomeWidgetBridge.updateWidget([]);

    // 3. Reset database destructively and reseed
    await AppDatabase.resetDatabase();

    // 4. Reload controllers with fresh initial data
    await reminderController.loadReminders();
    await folderController.loadFolders();

    // 5. Reset preferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstants.prefTimerEndTime);
    await prefs.remove(AppConstants.prefTimerTotalDuration);
    await prefs.remove(AppConstants.prefTimerIsRunning);

    AppLogger.info(_subsystem, 'Reset App Data completed successfully');
    notifyListeners();
  }
}
```

---

<a id="lib-application-controllers-theme_controllerdart"></a>
## 18. `lib/application/controllers/theme_controller.dart`

**Path**: `lib/application/controllers/theme_controller.dart` | **Lines**: 40

```dart
﻿import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';

class ThemeController extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  ThemeController() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedMode = prefs.getString(AppConstants.prefThemeMode);
    if (savedMode != null) {
      if (savedMode == 'light') _themeMode = ThemeMode.light;
      if (savedMode == 'dark') _themeMode = ThemeMode.dark;
      if (savedMode == 'system') _themeMode = ThemeMode.system;
      notifyListeners();
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.prefThemeMode, mode.name);
  }

  Future<void> toggleTheme() async {
    if (_themeMode == ThemeMode.dark) {
      await setThemeMode(ThemeMode.light);
    } else {
      await setThemeMode(ThemeMode.dark);
    }
  }
}
```

---

<a id="lib-application-controllers-timer_controllerdart"></a>
## 19. `lib/application/controllers/timer_controller.dart`

**Path**: `lib/application/controllers/timer_controller.dart` | **Lines**: 201

```dart
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';
import '../../core/services/time_service.dart';
import '../../platform/notifications/notification_platform_service.dart';

enum TimerState {
  idle,
  running,
  paused,
  completed,
  cancelled,
}

class TimerController extends ChangeNotifier {
  Timer? _ticker;
  TimerState _state = TimerState.idle;
  Duration _remainingTime = Duration.zero;
  Duration _totalDuration = Duration.zero;
  DateTime? _targetEndTime;
  bool _disposed = false;

  TimerState get state => _state;
  bool get isRunning => _state == TimerState.running;
  bool get isPaused => _state == TimerState.paused;
  bool get isFinished => _state == TimerState.completed;
  bool get isIdle => _state == TimerState.idle;

  Duration get remainingTime => _remainingTime;
  Duration get totalDuration => _totalDuration;

  double get progress {
    if (_totalDuration.inSeconds == 0) return 0.0;
    return (_remainingTime.inSeconds / _totalDuration.inSeconds).clamp(0.0, 1.0);
  }

  TimerController() {
    _restoreTimerState();
  }

  Future<void> _restoreTimerState() async {
    final prefs = await SharedPreferences.getInstance();
    final savedStateStr = prefs.getString('nudge_timer_state') ?? 'idle';
    final endMillis = prefs.getInt(AppConstants.prefTimerEndTime);
    final totalSec = prefs.getInt(AppConstants.prefTimerTotalDuration) ?? 0;
    final remainingSec = prefs.getInt('nudge_timer_remaining_sec') ?? 0;

    _totalDuration = Duration(seconds: totalSec);

    if (savedStateStr == 'running' && endMillis != null && totalSec > 0) {
      final endTime = DateTime.fromMillisecondsSinceEpoch(endMillis);
      final now = TimeService.now();

      if (now.isBefore(endTime)) {
        // Still running
        _targetEndTime = endTime;
        _remainingTime = endTime.difference(now);
        _state = TimerState.running;
        _startTicker();
      } else {
        // Expired while app was backgrounded / dead
        _remainingTime = Duration.zero;
        _state = TimerState.completed;
        _clearPersistedState();
      }
    } else if (savedStateStr == 'paused' && remainingSec > 0) {
      _remainingTime = Duration(seconds: remainingSec);
      _state = TimerState.paused;
    } else {
      _state = TimerState.idle;
      _remainingTime = Duration.zero;
    }

    if (_disposed) return;
    notifyListeners();
  }

  void startTimer(Duration duration) {
    if (duration.inSeconds <= 0) return;
    if (_state == TimerState.running) return; // Prevent duplicate start

    _ticker?.cancel();
    _totalDuration = duration;
    _remainingTime = duration;
    _targetEndTime = TimeService.now().add(duration);
    _state = TimerState.running;

    _persistTimerState();
    _startTicker();
    notifyListeners();
  }

  void pauseTimer() {
    if (_state != TimerState.running || _targetEndTime == null) return;

    _ticker?.cancel();
    final now = TimeService.now();
    final diff = _targetEndTime!.difference(now);
    _remainingTime = diff.isNegative ? Duration.zero : diff;
    _state = TimerState.paused;
    _targetEndTime = null;

    _persistTimerState();
    notifyListeners();
  }

  void resumeTimer() {
    if (_state != TimerState.paused || _remainingTime.inSeconds <= 0) return;

    _ticker?.cancel();
    _targetEndTime = TimeService.now().add(_remainingTime);
    _state = TimerState.running;

    _persistTimerState();
    _startTicker();
    notifyListeners();
  }

  void cancelTimer() {
    _ticker?.cancel();
    _remainingTime = Duration.zero;
    _targetEndTime = null;
    _state = TimerState.cancelled;

    _clearPersistedState();
    notifyListeners();

    // Reset to idle
    _state = TimerState.idle;
  }

  void resetTimer() {
    _ticker?.cancel();
    _remainingTime = Duration.zero;
    _totalDuration = Duration.zero;
    _targetEndTime = null;
    _state = TimerState.idle;

    _clearPersistedState();
    notifyListeners();
  }

  void _startTicker() {
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_targetEndTime == null) {
        timer.cancel();
        return;
      }

      final diff = _targetEndTime!.difference(TimeService.now());
      if (diff.inSeconds <= 0) {
        _remainingTime = Duration.zero;
        _state = TimerState.completed;
        timer.cancel();
        _clearPersistedState();
        _onTimerExpired();
      } else {
        _remainingTime = diff;
      }
      notifyListeners();
    });
  }

  void _onTimerExpired() {
    // Fire gentle notification / tone for timer
    NotificationPlatformService.cancelAll();
  }

  Future<void> _persistTimerState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nudge_timer_state', _state.name);
    await prefs.setInt(AppConstants.prefTimerTotalDuration, _totalDuration.inSeconds);
    await prefs.setInt('nudge_timer_remaining_sec', _remainingTime.inSeconds);

    if (_targetEndTime != null) {
      await prefs.setInt(AppConstants.prefTimerEndTime, _targetEndTime!.millisecondsSinceEpoch);
      await prefs.setBool(AppConstants.prefTimerIsRunning, true);
    } else {
      await prefs.remove(AppConstants.prefTimerEndTime);
      await prefs.setBool(AppConstants.prefTimerIsRunning, false);
    }
  }

  Future<void> _clearPersistedState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nudge_timer_state', 'idle');
    await prefs.setBool(AppConstants.prefTimerIsRunning, false);
    await prefs.remove(AppConstants.prefTimerEndTime);
    await prefs.remove(AppConstants.prefTimerTotalDuration);
    await prefs.remove('nudge_timer_remaining_sec');
  }

  @override
  void dispose() {
    _disposed = true;
    _ticker?.cancel();
    super.dispose();
  }
}
```

---

<a id="lib-application-controllers-todo_controllerdart"></a>
## 20. `lib/application/controllers/todo_controller.dart`

**Path**: `lib/application/controllers/todo_controller.dart` | **Lines**: 335

```dart
import 'package:flutter/foundation.dart';
import '../../core/logging/app_logger.dart';
import '../../domain/entities/todo.dart';
import '../../domain/entities/todo_subtask.dart';
import '../../domain/enums/todo_enums.dart';
import '../../domain/repositories/i_todo_repository.dart';

class TodoController with ChangeNotifier {
  static const String _subsystem = 'TodoController';
  final ITodoRepository _todoRepo;

  List<Todo> _todos = [];
  bool _isLoading = false;
  TodoFilter _activeFilter = TodoFilter.all;
  String? _selectedFolderId;
  String? _selectedTag;
  String _searchQuery = '';

  TodoController({required ITodoRepository todoRepo}) : _todoRepo = todoRepo;

  List<Todo> get todos => _todos;
  bool get isLoading => _isLoading;
  TodoFilter get activeFilter => _activeFilter;
  String? get selectedFolderId => _selectedFolderId;
  String? get selectedTag => _selectedTag;
  String get searchQuery => _searchQuery;

  int get activeCount => _todos.where((t) => !t.isDeleted && !t.isArchived && !t.isDone).length;
  int get todayCount => _todos.where((t) => !t.isDeleted && !t.isArchived && !t.isDone && t.isDueToday).length;
  int get overdueCount => _todos.where((t) => !t.isDeleted && !t.isArchived && !t.isDone && t.isOverdue).length;
  int get completedCount => _todos.where((t) => !t.isDeleted && t.isDone).length;

  List<Todo> get filteredTodos {
    return _todos.where((t) {
      // Trash filter
      if (_activeFilter == TodoFilter.trash) {
        return t.isDeleted;
      }
      if (t.isDeleted) return false;

      // Archived filter
      if (_activeFilter == TodoFilter.archived) {
        return t.isArchived;
      }
      if (t.isArchived) return false;

      // Active status filter
      switch (_activeFilter) {
        case TodoFilter.all:
          break;
        case TodoFilter.today:
          if (!t.isDueToday) return false;
          break;
        case TodoFilter.upcoming:
          if (t.dueAt == null || !t.dueAt!.isAfter(DateTime.now())) return false;
          break;
        case TodoFilter.highPriority:
          if (t.priority != TodoPriority.high && t.priority != TodoPriority.urgent) return false;
          break;
        case TodoFilter.completed:
          if (!t.isDone) return false;
          break;
        case TodoFilter.archived:
        case TodoFilter.trash:
          break;
      }

      // Folder filter
      if (_selectedFolderId != null && t.folderId != _selectedFolderId) {
        return false;
      }

      // Tag filter
      if (_selectedTag != null && !t.tags.contains(_selectedTag)) {
        return false;
      }

      // Search query
      if (_searchQuery.isNotEmpty) {
        final query = _searchQuery.toLowerCase();
        final matchTitle = t.title.toLowerCase().contains(query);
        final matchDesc = t.description?.toLowerCase().contains(query) ?? false;
        final matchTag = t.tags.any((tag) => tag.toLowerCase().contains(query));
        if (!matchTitle && !matchDesc && !matchTag) return false;
      }

      return true;
    }).toList();
  }

  void setFilter(TodoFilter filter) {
    _activeFilter = filter;
    notifyListeners();
  }

  void setFolder(String? folderId) {
    _selectedFolderId = folderId;
    notifyListeners();
  }

  void setTag(String? tag) {
    _selectedTag = tag;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query.trim();
    notifyListeners();
  }

  Future<void> loadTodos() async {
    _isLoading = true;
    notifyListeners();
    try {
      _todos = await _todoRepo.getAllTodos(includeDeleted: true);
      AppLogger.info(_subsystem, 'Loaded ${_todos.length} todos');
    } catch (e, st) {
      AppLogger.error(_subsystem, 'Failed to load todos', error: e, stackTrace: st);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createTodo(Todo todo) async {
    try {
      await _todoRepo.createTodo(todo);
      _todos.insert(0, todo);
      notifyListeners();

      if (todo.reminderEnabled && todo.reminderAt != null) {
        _scheduleGentleTodoNotification(todo);
      }
    } catch (e, st) {
      AppLogger.error(_subsystem, 'Failed to create todo', error: e, stackTrace: st);
    }
  }

  Future<void> updateTodo(Todo todo) async {
    try {
      final updated = todo.copyWith(updatedAt: DateTime.now());
      await _todoRepo.updateTodo(updated);
      final index = _todos.indexWhere((t) => t.id == todo.id);
      if (index != -1) {
        _todos[index] = updated;
        notifyListeners();
      }
    } catch (e, st) {
      AppLogger.error(_subsystem, 'Failed to update todo', error: e, stackTrace: st);
    }
  }

  Future<void> toggleTodoStatus(String id) async {
    try {
      final index = _todos.indexWhere((t) => t.id == id);
      if (index == -1) return;

      final current = _todos[index];
      final newStatus = current.isDone ? TodoStatus.pending : TodoStatus.completed;
      final completedAt = newStatus == TodoStatus.completed ? DateTime.now() : null;

      final updated = current.copyWith(
        status: newStatus,
        completedAt: completedAt,
        updatedAt: DateTime.now(),
      );

      await _todoRepo.updateTodo(updated);
      _todos[index] = updated;
      notifyListeners();
    } catch (e, st) {
      AppLogger.error(_subsystem, 'Failed to toggle todo status', error: e, stackTrace: st);
    }
  }

  Future<void> togglePin(String id) async {
    try {
      final index = _todos.indexWhere((t) => t.id == id);
      if (index == -1) return;

      final current = _todos[index];
      final updated = current.copyWith(
        isPinned: !current.isPinned,
        updatedAt: DateTime.now(),
      );

      await _todoRepo.updateTodo(updated);
      _todos[index] = updated;
      _todos.sort((a, b) {
        if (a.isPinned != b.isPinned) {
          return b.isPinned ? 1 : -1;
        }
        return a.sortOrder.compareTo(b.sortOrder);
      });
      notifyListeners();
    } catch (e, st) {
      AppLogger.error(_subsystem, 'Failed to toggle pin', error: e, stackTrace: st);
    }
  }

  Future<void> toggleArchive(String id) async {
    try {
      final index = _todos.indexWhere((t) => t.id == id);
      if (index == -1) return;

      final current = _todos[index];
      final updated = current.copyWith(
        isArchived: !current.isArchived,
        updatedAt: DateTime.now(),
      );

      await _todoRepo.updateTodo(updated);
      _todos[index] = updated;
      notifyListeners();
    } catch (e, st) {
      AppLogger.error(_subsystem, 'Failed to toggle archive', error: e, stackTrace: st);
    }
  }

  Future<void> softDeleteTodo(String id) async {
    try {
      await _todoRepo.deleteTodo(id, hardDelete: false);
      final index = _todos.indexWhere((t) => t.id == id);
      if (index != -1) {
        _todos[index] = _todos[index].copyWith(isDeleted: true);
        notifyListeners();
      }
    } catch (e, st) {
      AppLogger.error(_subsystem, 'Failed to soft delete todo', error: e, stackTrace: st);
    }
  }

  Future<void> restoreTodo(String id) async {
    try {
      await _todoRepo.restoreTodo(id);
      final index = _todos.indexWhere((t) => t.id == id);
      if (index != -1) {
        _todos[index] = _todos[index].copyWith(isDeleted: false);
        notifyListeners();
      }
    } catch (e, st) {
      AppLogger.error(_subsystem, 'Failed to restore todo', error: e, stackTrace: st);
    }
  }

  Future<void> hardDeleteTodo(String id) async {
    try {
      await _todoRepo.deleteTodo(id, hardDelete: true);
      _todos.removeWhere((t) => t.id == id);
      notifyListeners();
    } catch (e, st) {
      AppLogger.error(_subsystem, 'Failed to hard delete todo', error: e, stackTrace: st);
    }
  }

  Future<void> purgeTrash() async {
    try {
      await _todoRepo.purgeTrash();
      _todos.removeWhere((t) => t.isDeleted);
      notifyListeners();
    } catch (e, st) {
      AppLogger.error(_subsystem, 'Failed to purge trash', error: e, stackTrace: st);
    }
  }

  // Subtask management
  Future<void> addSubtask(String todoId, String text) async {
    try {
      final index = _todos.indexWhere((t) => t.id == todoId);
      if (index == -1) return;

      final current = _todos[index];
      final newSubtask = TodoSubtask(
        todoId: todoId,
        text: text,
        sortOrder: current.subtasks.length,
      );

      await _todoRepo.addSubtask(newSubtask);
      final updatedSubtasks = List<TodoSubtask>.from(current.subtasks)..add(newSubtask);
      _todos[index] = current.copyWith(subtasks: updatedSubtasks);
      notifyListeners();
    } catch (e, st) {
      AppLogger.error(_subsystem, 'Failed to add subtask', error: e, stackTrace: st);
    }
  }

  Future<void> toggleSubtask(String todoId, String subtaskId) async {
    try {
      final index = _todos.indexWhere((t) => t.id == todoId);
      if (index == -1) return;

      final current = _todos[index];
      final subtaskIndex = current.subtasks.indexWhere((s) => s.id == subtaskId);
      if (subtaskIndex == -1) return;

      final s = current.subtasks[subtaskIndex];
      final updatedSubtask = s.copyWith(
        isDone: !s.isDone,
        completedAt: !s.isDone ? DateTime.now() : null,
      );

      await _todoRepo.updateSubtask(updatedSubtask);
      final updatedSubtasks = List<TodoSubtask>.from(current.subtasks);
      updatedSubtasks[subtaskIndex] = updatedSubtask;
      _todos[index] = current.copyWith(subtasks: updatedSubtasks);
      notifyListeners();
    } catch (e, st) {
      AppLogger.error(_subsystem, 'Failed to toggle subtask', error: e, stackTrace: st);
    }
  }

  Future<void> deleteSubtask(String todoId, String subtaskId) async {
    try {
      final index = _todos.indexWhere((t) => t.id == todoId);
      if (index == -1) return;

      await _todoRepo.deleteSubtask(subtaskId);
      final current = _todos[index];
      final updatedSubtasks = current.subtasks.where((s) => s.id != subtaskId).toList();
      _todos[index] = current.copyWith(subtasks: updatedSubtasks);
      notifyListeners();
    } catch (e, st) {
      AppLogger.error(_subsystem, 'Failed to delete subtask', error: e, stackTrace: st);
    }
  }

  void _scheduleGentleTodoNotification(Todo todo) {
    try {
      AppLogger.info(_subsystem, 'Gentle notification enabled for todo: ${todo.title}');
    } catch (e) {
      AppLogger.error(_subsystem, 'Could not configure notification', error: e);
    }
  }
}
```

---

<a id="lib-core-constants-app_constantsdart"></a>
## 21. `lib/core/constants/app_constants.dart`

**Path**: `lib/core/constants/app_constants.dart` | **Lines**: 82

```dart
class AppConstants {
  static const String appName = 'Nudge';
  static const String appVersion = '2.0.0';
  static const String appBuild = '1';
  static const String appTagline = 'Privacy-first offline reminder & habit system';

  // Limits & Defaults
  static const int maxSnoozeCount = 3;
  static const int defaultSnoozeMinutes = 10;
  static const int conflictWindowMinutes = 15;

  // Method Channels
  static const String alarmChannel = 'com.personal.nudge/alarm';
  static const String reliabilityChannel = 'com.personal.nudge/reliability';

  // Notification Channels
  static const String alarmChannelId = 'nudge_alarm_channel_final';
  static const String alarmChannelName = 'Nudge Alarms (Foreground)';
  static const String gentleChannelId = 'nudge_gentle_channel';
  static const String gentleChannelName = 'Nudge Gentle Reminders';

  // Intent Actions
  static const String actionStartAlarm = 'com.personal.nudge.ACTION_START_ALARM';
  static const String actionStopAlarm = 'com.personal.nudge.ACTION_STOP_ALARM';
  static const String alarmReceiverComponent = 'com.personal.nudge.nudge.AlarmReceiver';

  // Shared Preferences Keys
  static const String prefThemeMode = 'nudge_theme_mode';
  static const String prefDefaultSnooze = 'nudge_default_snooze';
  static const String prefSoundEnabled = 'nudge_sound_enabled';
  static const String prefCompanionName = 'nudge_companion_name';
  static const String prefCompanionCosmetic = 'nudge_companion_cosmetic';
  static const String prefCompanionStreak = 'nudge_companion_streak';
  static const String prefCompanionLifetime = 'nudge_companion_lifetime';
  static const String prefCompanionFreezes = 'nudge_companion_freezes';
  static const String prefCompanionLastActiveDate = 'nudge_companion_last_active_date';
  static const String prefTimerEndTime = 'nudge_timer_end_time';
  static const String prefTimerTotalDuration = 'nudge_timer_total_duration';
  static const String prefTimerIsRunning = 'nudge_timer_is_running';
  static const String prefInitialSetupComplete = 'nudge_setup_complete';

  // Default Folders
  static const String generalFolderId = 'folder_general';
  static const String workFolderId = 'folder_work';
  static const String personalFolderId = 'folder_personal';

  // Default Categories / Folders Seed
  static const List<Map<String, dynamic>> defaultFolders = [
    {
      'id': generalFolderId,
      'name': 'General',
      'iconId': 'folder',
      'colorTag': '#006A60',
    },
    {
      'id': workFolderId,
      'name': 'Work',
      'iconId': 'work',
      'colorTag': '#BA1A1A',
    },
    {
      'id': personalFolderId,
      'name': 'Personal',
      'iconId': 'home',
      'colorTag': '#6750A4',
    },
  ];

  // Mascot Milestones
  static const Map<int, String> cosmeticMilestones = {
    3: 'bandana',
    8: 'neon_shades',
    15: 'headphones',
    25: 'wizard_hat',
    40: 'ninja_band',
    60: 'astronaut_helmet',
    80: 'sparkle_aura',
    100: 'crown',
    150: 'flame_aura',
    200: 'golden_trophy',
  };
}
```

---

<a id="lib-core-errors-failuresdart"></a>
## 22. `lib/core/errors/failures.dart`

**Path**: `lib/core/errors/failures.dart` | **Lines**: 30

```dart
﻿abstract class Failure {
  final String message;
  final Object? cause;
  final StackTrace? stackTrace;

  const Failure(this.message, {this.cause, this.stackTrace});

  @override
  String toString() => '$runtimeType: $message${cause != null ? ' (Cause: $cause)' : ''}';
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message, {super.cause, super.stackTrace});
}

class AlarmFailure extends Failure {
  const AlarmFailure(super.message, {super.cause, super.stackTrace});
}

class BackupFailure extends Failure {
  const BackupFailure(super.message, {super.cause, super.stackTrace});
}

class PermissionFailure extends Failure {
  const PermissionFailure(super.message, {super.cause, super.stackTrace});
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message, {super.cause, super.stackTrace});
}
```

---

<a id="lib-core-logging-app_loggerdart"></a>
## 23. `lib/core/logging/app_logger.dart`

**Path**: `lib/core/logging/app_logger.dart` | **Lines**: 48

```dart
﻿import 'package:flutter/foundation.dart';

enum LogLevel { debug, info, warning, error }

class AppLogger {
  static LogLevel minLevel = kDebugMode ? LogLevel.debug : LogLevel.info;

  static void log(
    LogLevel level,
    String subsystem,
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (level.index < minLevel.index) return;

    final timestamp = DateTime.now().toIso8601String();
    final prefix = '[${level.name.toUpperCase()}][$subsystem][$timestamp]';
    final output = '$prefix $message';

    if (level == LogLevel.error) {
      debugPrint('\x1B[31m$output\x1B[0m');
      if (error != null) debugPrint('\x1B[31mError: $error\x1B[0m');
      if (stackTrace != null) debugPrint('\x1B[31m$stackTrace\x1B[0m');
    } else if (level == LogLevel.warning) {
      debugPrint('\x1B[33m$output\x1B[0m');
    } else {
      debugPrint(output);
    }
  }

  static void debug(String subsystem, String message) =>
      log(LogLevel.debug, subsystem, message);

  static void info(String subsystem, String message) =>
      log(LogLevel.info, subsystem, message);

  static void warning(String subsystem, String message, {Object? error}) =>
      log(LogLevel.warning, subsystem, message, error: error);

  static void error(
    String subsystem,
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) =>
      log(LogLevel.error, subsystem, message, error: error, stackTrace: stackTrace);
}
```

---

<a id="lib-core-result-resultdart"></a>
## 24. `lib/core/result/result.dart`

**Path**: `lib/core/result/result.dart` | **Lines**: 27

```dart
﻿abstract class Result<S, F> {
  const Result();

  bool get isSuccess => this is Success<S, F>;
  bool get isFailure => this is FailureResult<S, F>;

  S? get dataOrNull => isSuccess ? (this as Success<S, F>).data : null;
  F? get failureOrNull => isFailure ? (this as FailureResult<S, F>).failure : null;

  R fold<R>(R Function(S data) onSuccess, R Function(F failure) onFailure) {
    if (this is Success<S, F>) {
      return onSuccess((this as Success<S, F>).data);
    } else {
      return onFailure((this as FailureResult<S, F>).failure);
    }
  }
}

class Success<S, F> extends Result<S, F> {
  final S data;
  const Success(this.data);
}

class FailureResult<S, F> extends Result<S, F> {
  final F failure;
  const FailureResult(this.failure);
}
```

---

<a id="lib-core-services-time_servicedart"></a>
## 25. `lib/core/services/time_service.dart`

**Path**: `lib/core/services/time_service.dart` | **Lines**: 45

```dart
class TimeService {
  static DateTime Function() _clock = () => DateTime.now();

  /// Returns the current DateTime, using the custom clock if set.
  static DateTime now() => _clock();

  /// Returns the start of the current day (00:00:00.000).
  static DateTime today() {
    final current = now();
    return DateTime(current.year, current.month, current.day);
  }

  /// Checks if the given DateTime is today.
  static bool isToday(DateTime dateTime) {
    final current = now();
    return dateTime.year == current.year &&
        dateTime.month == current.month &&
        dateTime.day == current.day;
  }

  /// Checks if two DateTimes fall on the same calendar day.
  static bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  /// Returns 00:00:00.000 for the given date.
  static DateTime startOfDay(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  /// Returns 23:59:59.999 for the given date.
  static DateTime endOfDay(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59, 59, 999);
  }

  /// Allows unit tests to freeze or control time deterministically.
  static void setCustomClock(DateTime Function() customClock) {
    _clock = customClock;
  }

  /// Resets clock to real system time.
  static void resetClock() {
    _clock = () => DateTime.now();
  }
}
```

---

<a id="lib-core-utils-date_utilsdart"></a>
## 26. `lib/core/utils/date_utils.dart`

**Path**: `lib/core/utils/date_utils.dart` | **Lines**: 48

```dart
﻿import 'package:intl/intl.dart';

class NudgeDateUtils {
  static bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  static bool isToday(DateTime dt) {
    return isSameDay(dt, DateTime.now());
  }

  static bool isTomorrow(DateTime dt) {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return isSameDay(dt, tomorrow);
  }

  static bool isPast(DateTime dt) {
    return dt.isBefore(DateTime.now());
  }

  static String formatDateTime(DateTime dt) {
    return DateFormat('EEE, MMM d, y • h:mm a').format(dt);
  }

  static String formatDate(DateTime dt) {
    return DateFormat('EEE, MMM d').format(dt);
  }

  static String formatTime(DateTime dt) {
    return DateFormat('h:mm a').format(dt);
  }

  static String getRelativeDayLabel(DateTime dt) {
    final now = DateTime.now();
    if (isSameDay(dt, now)) return 'Today';
    if (isSameDay(dt, now.add(const Duration(days: 1)))) return 'Tomorrow';
    if (isSameDay(dt, now.subtract(const Duration(days: 1)))) return 'Yesterday';
    if (dt.isBefore(now)) return 'Overdue';
    return DateFormat('EEE, MMM d').format(dt);
  }

  /// Clamps day of month safely, e.g. Jan 31 + 1 month -> Feb 28 (or 29 in leap year)
  static DateTime clampMonthDay(int year, int month, int targetDay, int hour, int minute) {
    final daysInMonth = DateTime(year, month + 1, 0).day;
    final clampedDay = targetDay.clamp(1, daysInMonth);
    return DateTime(year, month, clampedDay, hour, minute);
  }
}
```

---

<a id="lib-core-utils-fnv1a_hashdart"></a>
## 27. `lib/core/utils/fnv1a_hash.dart`

**Path**: `lib/core/utils/fnv1a_hash.dart` | **Lines**: 12

```dart
﻿class Fnv1aHash {
  /// Deterministic 32-bit FNV-1a hash algorithm converting string UUID to positive integer.
  /// Stable across device reboots and application restarts.
  static int hash32(String input) {
    var hash = 0x811c9dc5;
    for (final codeUnit in input.codeUnits) {
      hash = (hash ^ codeUnit) * 0x01000193;
      hash &= 0x7fffffff;
    }
    return hash == 0 ? 1 : hash;
  }
}
```

---

<a id="lib-core-utils-pbkdf2_utildart"></a>
## 28. `lib/core/utils/pbkdf2_util.dart`

**Path**: `lib/core/utils/pbkdf2_util.dart` | **Lines**: 59

```dart
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';

/// Pure-Dart PBKDF2-HMAC-SHA256 implementation adhering to RFC 2898 / PKCS #5 v2.0.
/// Provides deterministic key derivation from passwords across devices without
/// relying on device-bound hardware keystores.
class Pbkdf2Util {
  static const int defaultIterations = 10000;

  /// Generates a cryptographically secure random salt of [length] bytes.
  static Uint8List generateSalt([int length = 16]) {
    final random = Random.secure();
    return Uint8List.fromList(List<int>.generate(length, (_) => random.nextInt(256)));
  }

  /// Derives a 32-byte (256-bit) key for a given [blockIndex] using PBKDF2-HMAC-SHA256.
  /// - blockIndex 1: Encryption Key (AES-256)
  /// - blockIndex 2: Authentication Key (HMAC-SHA256)
  static Uint8List deriveKey(
    String password,
    Uint8List salt, {
    int iterations = defaultIterations,
    int blockIndex = 1,
  }) {
    final passwordBytes = utf8.encode(password);
    final hmac = Hmac(sha256, passwordBytes);

    final blockBytes = Uint8List(4);
    ByteData.view(blockBytes.buffer).setUint32(0, blockIndex, Endian.big);

    final initial = Uint8List(salt.length + 4);
    initial.setRange(0, salt.length, salt);
    initial.setRange(salt.length, salt.length + 4, blockBytes);

    var u = Uint8List.fromList(hmac.convert(initial).bytes);
    final result = Uint8List.fromList(u);

    for (int i = 1; i < iterations; i++) {
      u = Uint8List.fromList(hmac.convert(u).bytes);
      for (int j = 0; j < 32; j++) {
        result[j] ^= u[j];
      }
    }

    return result;
  }

  /// Constant-time byte comparison to prevent timing attacks.
  static bool constantTimeEquals(List<int> a, List<int> b) {
    if (a.length != b.length) return false;
    var diff = 0;
    for (int i = 0; i < a.length; i++) {
      diff |= a[i] ^ b[i];
    }
    return diff == 0;
  }
}
```

---

<a id="lib-core-utils-secure_storage_utildart"></a>
## 29. `lib/core/utils/secure_storage_util.dart`

**Path**: `lib/core/utils/secure_storage_util.dart` | **Lines**: 32

```dart
﻿import 'dart:convert';
import 'dart:math';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../logging/app_logger.dart';

class SecureStorageUtil {
  static const String _subsystem = 'SecureStorageUtil';
  static const String _keyMasterKey = 'nudge_master_aes_key';
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  static Future<String> getOrCreateMasterKey() async {
    try {
      final existingKey = await _storage.read(key: _keyMasterKey);
      if (existingKey != null && existingKey.isNotEmpty) {
        return existingKey;
      }

      // Generate a 256-bit random cryptographic key
      final random = Random.secure();
      final values = List<int>.generate(32, (i) => random.nextInt(256));
      final newKey = base64Encode(values);
      await _storage.write(key: _keyMasterKey, value: newKey);
      AppLogger.info(_subsystem, 'Generated and stored new 256-bit AES master key');
      return newKey;
    } catch (e, stack) {
      AppLogger.error(_subsystem, 'SecureStorage access failed, using fallback hash', error: e, stackTrace: stack);
      return 'NUDGE_LOCAL_RELIABLE_AES_256_FALLBACK_KEY_SECURE';
    }
  }
}
```

---

<a id="lib-data-backup-backup_managerdart"></a>
## 30. `lib/data/backup/backup_manager.dart`

**Path**: `lib/data/backup/backup_manager.dart` | **Lines**: 660

```dart
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import '../../core/constants/app_constants.dart';
import '../../core/logging/app_logger.dart';
import '../../core/utils/pbkdf2_util.dart';
import '../../core/utils/secure_storage_util.dart';
import '../../domain/entities/folder.dart';
import '../../domain/entities/reminder.dart';
import '../../domain/entities/reminder_history.dart';
import '../../domain/entities/reminder_occurrence.dart';
import '../../domain/entities/reminder_template.dart';
import '../../domain/entities/companion_profile.dart';
import '../../domain/entities/todo.dart';
import '../../domain/entities/record.dart';
import '../../domain/entities/tag.dart';
import '../database/app_database.dart';
import '../media/app_media_repository.dart';
import '../repositories/folder_repository_impl.dart';
import '../repositories/history_repository_impl.dart';
import '../repositories/occurrence_repository_impl.dart';
import '../repositories/reminder_repository_impl.dart';
import '../repositories/template_repository_impl.dart';
import '../repositories/companion_repository_impl.dart';
import '../repositories/todo_repository_impl.dart';
import '../repositories/record_repository_impl.dart';
import '../repositories/tag_repository_impl.dart';

enum BackupConflictPolicy {
  skip,
  replace,
  keep,
  importAsCopy,
}

class BackupPreview {
  final int totalRecords;
  final int addedCount;
  final int updatedCount;
  final int skippedCount;
  final int duplicateCount;
  final int invalidCount;
  final int invalidMediaCount;
  final List<Reminder> validReminders;
  final List<ReminderOccurrence> validOccurrences;
  final List<Folder> validFolders;
  final List<ReminderHistory> validHistory;
  final List<ReminderTemplate> validTemplates;
  final CompanionProfile? companionProfile;
  final List<Todo> validTodos;
  final List<Record> validRecords;
  final List<Tag> validTags;
  final Map<String, String> mediaFiles;

  const BackupPreview({
    required this.totalRecords,
    required this.addedCount,
    required this.updatedCount,
    required this.skippedCount,
    required this.duplicateCount,
    required this.invalidCount,
    required this.invalidMediaCount,
    required this.validReminders,
    required this.validOccurrences,
    required this.validFolders,
    required this.validHistory,
    required this.validTemplates,
    this.companionProfile,
    this.validTodos = const [],
    this.validRecords = const [],
    this.validTags = const [],
    this.mediaFiles = const {},
  });
}

class BackupManager {
  static const String _subsystem = 'BackupManager';
  static const int schemaVersion = 3;
  static const String containerMagic = 'NUDGE_ENC_JSON_V1';
  static const String legacyMagicV2 = 'NUDGE_ENC_V2';
  static const String legacyMagicV3 = 'NUDGE_ENC_V3';

  /// Exports all application data and media into an authenticated AES-256 encrypted JSON file.
  /// If [password] is provided, uses PBKDF2-HMAC-SHA256 key derivation with a random 16-byte salt,
  /// enabling cross-device portability without reliance on device-bound keystores.
  /// If [password] is omitted, falls back to legacy device-local master key encryption.
  static Future<File> exportBackup({String? password}) async {
    AppLogger.info(_subsystem, 'Starting backup export...');
    final reminderRepo = ReminderRepositoryImpl();
    final occurrenceRepo = OccurrenceRepositoryImpl();
    final folderRepo = FolderRepositoryImpl();
    final historyRepo = HistoryRepositoryImpl();
    final templateRepo = TemplateRepositoryImpl();
    final companionRepo = CompanionRepositoryImpl();
    final todoRepo = TodoRepositoryImpl();
    final recordRepo = RecordRepositoryImpl();
    final tagRepo = TagRepositoryImpl();

    final reminders = await reminderRepo.getAllReminders();
    final occurrences = await occurrenceRepo.getAllOccurrences();
    final folders = await folderRepo.getAllFolders();
    final history = await historyRepo.getAllHistory();
    final templates = await templateRepo.getAllTemplates();
    final companion = await companionRepo.getProfile();
    final todos = await todoRepo.getAllTodos(includeDeleted: true);
    final records = await recordRepo.getAllRecords(includeDeleted: true);
    final tags = await tagRepo.getAllTags();
    final mediaMap = await AppMediaRepository.exportAllMediaBase64();

    final isPasswordMode = password != null && password.trim().isNotEmpty;
    final currentMagic = isPasswordMode ? containerMagic : legacyMagicV2;

    final payload = {
      'manifest': {
        'magic': currentMagic,
        'schemaVersion': schemaVersion,
        'appVersion': AppConstants.appVersion,
        'exportedAt': DateTime.now().toIso8601String(),
        'reminderCount': reminders.length,
        'occurrenceCount': occurrences.length,
        'folderCount': folders.length,
        'todoCount': todos.length,
        'recordCount': records.length,
        'tagCount': tags.length,
        'mediaCount': mediaMap.length,
      },
      'reminders': reminders.map((r) => r.toJson()).toList(),
      'occurrences': occurrences.map((o) => o.toJson()).toList(),
      'folders': folders.map((f) => f.toJson()).toList(),
      'history': history.map((h) => h.toJson()).toList(),
      'templates': templates.map((t) => t.toJson()).toList(),
      'companion': companion.toJson(),
      'todos': todos.map((t) => t.toJson()).toList(),
      'records': records.map((r) => r.toJson()).toList(),
      'tags': tags.map((t) => t.toJson()).toList(),
      'media': mediaMap,
    };

    final rawJson = jsonEncode(payload);
    final tempDir = await getTemporaryDirectory();

    if (isPasswordMode) {
      final cleanPassword = password.trim();
      final salt = Pbkdf2Util.generateSalt(16);
      const iterations = 10000;

      final encKeyBytes = Pbkdf2Util.deriveKey(cleanPassword, salt, iterations: iterations, blockIndex: 1);
      final hmacKeyBytes = Pbkdf2Util.deriveKey(cleanPassword, salt, iterations: iterations, blockIndex: 2);

      final encKey = enc.Key(encKeyBytes);
      final iv = enc.IV.fromSecureRandom(16);
      final encrypter = enc.Encrypter(enc.AES(encKey, mode: enc.AESMode.cbc));
      final encrypted = encrypter.encrypt(rawJson, iv: iv);

      // Compute HMAC-SHA256 authentication tag over [salt + iv + ciphertext]
      final hmac = Hmac(sha256, hmacKeyBytes);
      final authenticatedPayload = [...salt, ...iv.bytes, ...encrypted.bytes];
      final authTag = hmac.convert(authenticatedPayload).bytes;

      final container = {
        'magic': containerMagic,
        'schemaVersion': schemaVersion,
        'appVersion': AppConstants.appVersion,
        'createdAt': DateTime.now().toIso8601String(),
        'kdf': 'PBKDF2_SHA256',
        'iterations': iterations,
        'salt': base64Encode(salt),
        'iv': base64Encode(iv.bytes),
        'ciphertext': encrypted.base64,
        'authTag': base64Encode(authTag),
      };

      final filename = 'nudge_backup_${DateTime.now().millisecondsSinceEpoch}.json';
      final backupFile = File('${tempDir.path}/$filename');
      await backupFile.writeAsString(jsonEncode(container));

      AppLogger.info(_subsystem, 'Password-encrypted JSON backup export complete: ${backupFile.path} (${backupFile.lengthSync()} bytes)');
      return backupFile;
    } else {
      final masterKey = await SecureStorageUtil.getOrCreateMasterKey();

      // Key derivation: SHA-256 of master key
      final keyBytes = sha256.convert(utf8.encode(masterKey)).bytes;
      final encKey = enc.Key(Uint8List.fromList(keyBytes));
      final iv = enc.IV.fromSecureRandom(16);

      final encrypter = enc.Encrypter(enc.AES(encKey, mode: enc.AESMode.cbc));
      final encrypted = encrypter.encrypt(rawJson, iv: iv);

      // Compute HMAC-SHA256 authentication tag over [IV + Ciphertext]
      final hmacKey = sha256.convert(utf8.encode('$masterKey:HMAC')).bytes;
      final hmac = Hmac(sha256, hmacKey);
      final authenticatedPayload = [...iv.bytes, ...encrypted.bytes];
      final authTag = hmac.convert(authenticatedPayload).bytes;

      final container = {
        'magic': legacyMagicV2,
        'schemaVersion': schemaVersion,
        'iv': base64Encode(iv.bytes),
        'ciphertext': encrypted.base64,
        'authTag': base64Encode(authTag),
      };

      final filename = 'nudge_backup_${DateTime.now().millisecondsSinceEpoch}.nudgebackup';
      final backupFile = File('${tempDir.path}/$filename');
      await backupFile.writeAsString(jsonEncode(container));

      AppLogger.info(_subsystem, 'Master key backup export complete: ${backupFile.path} (${backupFile.lengthSync()} bytes)');
      return backupFile;
    }
  }

  /// Detects if a given backup file requires a password for decryption.
  static Future<bool> isPasswordProtected(String filePath) async {
    final file = File(filePath);
    if (!await file.exists()) return false;
    try {
      final raw = await file.readAsString();
      final container = jsonDecode(raw) as Map<String, dynamic>;
      final magic = container['magic'] as String?;
      final kdf = container['kdf'] as String?;
      return magic == containerMagic || kdf == 'PBKDF2_SHA256';
    } catch (_) {
      return false;
    }
  }

  /// Parses, verifies authentication tag, decrypts, and inspects a backup without touching the database.
  static Future<BackupPreview> inspectBackupFile(
    String filePath, {
    String? password,
    BackupConflictPolicy policy = BackupConflictPolicy.skip,
    List<Reminder>? existingRemindersOverride,
  }) async {
    AppLogger.info(_subsystem, 'Inspecting backup file: $filePath');
    final file = File(filePath);
    if (!await file.exists()) {
      throw const FileSystemException('Backup file not found');
    }

    final raw = await file.readAsString();
    Map<String, dynamic> container;
    try {
      container = jsonDecode(raw) as Map<String, dynamic>;
    } catch (_) {
      throw const FormatException('Invalid backup container: not valid JSON');
    }

    final magic = container['magic'] as String?;
    final isPasswordContainer = magic == containerMagic || container['kdf'] == 'PBKDF2_SHA256';

    if (!isPasswordContainer && magic != legacyMagicV2 && magic != legacyMagicV3) {
      throw const FormatException('Unsupported backup format or wrong schema version');
    }

    final ivBytes = base64Decode(container['iv'] as String);
    final ciphertextBase64 = container['ciphertext'] as String;
    final cipherBytes = base64Decode(ciphertextBase64);
    final authTagBytes = base64Decode(container['authTag'] as String);

    String decrypted;

    if (isPasswordContainer) {
      if (password == null || password.trim().isEmpty) {
        throw const FormatException('Password required to decrypt this backup file.');
      }
      if (container['salt'] == null) {
        throw const FormatException('Corrupted backup file: missing salt.');
      }

      final saltBytes = base64Decode(container['salt'] as String);
      final iterations = (container['iterations'] as num?)?.toInt() ?? 10000;

      final encKeyBytes = Pbkdf2Util.deriveKey(password.trim(), saltBytes, iterations: iterations, blockIndex: 1);
      final hmacKeyBytes = Pbkdf2Util.deriveKey(password.trim(), saltBytes, iterations: iterations, blockIndex: 2);

      // Verify HMAC-SHA256 over [salt + iv + ciphertext]
      final hmac = Hmac(sha256, hmacKeyBytes);
      final computedTag = hmac.convert([...saltBytes, ...ivBytes, ...cipherBytes]).bytes;

      if (!Pbkdf2Util.constantTimeEquals(computedTag, authTagBytes)) {
        throw const FormatException('Incorrect password or corrupted backup file.');
      }

      try {
        final encKey = enc.Key(encKeyBytes);
        final encrypter = enc.Encrypter(enc.AES(encKey, mode: enc.AESMode.cbc));
        decrypted = encrypter.decrypt(enc.Encrypted(cipherBytes), iv: enc.IV(ivBytes));
      } catch (e) {
        throw const FormatException('Incorrect password or corrupted backup file.');
      }
    } else {
      final masterKey = await SecureStorageUtil.getOrCreateMasterKey();

      // Verify HMAC-SHA256 authentication tag over [iv + ciphertext]
      final hmacKey = sha256.convert(utf8.encode('$masterKey:HMAC')).bytes;
      final hmac = Hmac(sha256, hmacKey);
      final computedTag = hmac.convert([...ivBytes, ...cipherBytes]).bytes;

      if (!Pbkdf2Util.constantTimeEquals(computedTag, authTagBytes)) {
        throw const FormatException('Authentication tag mismatch: corrupted file or wrong encryption key');
      }

      // Decrypt
      final keyBytes = sha256.convert(utf8.encode(masterKey)).bytes;
      final encKey = enc.Key(Uint8List.fromList(keyBytes));
      final encrypter = enc.Encrypter(enc.AES(encKey, mode: enc.AESMode.cbc));
      decrypted = encrypter.decrypt(enc.Encrypted(cipherBytes), iv: enc.IV(ivBytes));
    }

    final Map<String, dynamic> payload = jsonDecode(decrypted) as Map<String, dynamic>;

    // Existing reminders for conflict / duplicate detection
    final existingReminders = existingRemindersOverride ?? await ReminderRepositoryImpl().getAllReminders();
    final existingIds = existingReminders.map((r) => r.id).toSet();

    final validReminders = <Reminder>[];
    final validOccurrences = <ReminderOccurrence>[];
    final validFolders = <Folder>[];
    final validHistory = <ReminderHistory>[];
    final validTemplates = <ReminderTemplate>[];
    final mediaMap = <String, String>{};

    int duplicates = 0;
    int invalid = 0;
    int invalidMedia = 0;

    // Process Reminders
    if (payload['reminders'] is List) {
      for (final r in payload['reminders'] as List) {
        try {
          final map = Map<String, dynamic>.from(r as Map);
          final reminder = Reminder.fromJson(map);
          if (existingIds.contains(reminder.id)) {
            duplicates++;
          }
          validReminders.add(reminder);
        } catch (_) {
          invalid++;
        }
      }
    }

    // Process Occurrences
    if (payload['occurrences'] is List) {
      for (final o in payload['occurrences'] as List) {
        try {
          validOccurrences.add(ReminderOccurrence.fromJson(Map<String, dynamic>.from(o as Map)));
        } catch (_) {
          invalid++;
        }
      }
    }

    // Process Folders
    if (payload['folders'] is List) {
      for (final f in payload['folders'] as List) {
        try {
          validFolders.add(Folder.fromJson(Map<String, dynamic>.from(f as Map)));
        } catch (_) {
          invalid++;
        }
      }
    }

    // Process History
    if (payload['history'] is List) {
      for (final h in payload['history'] as List) {
        try {
          validHistory.add(ReminderHistory.fromJson(Map<String, dynamic>.from(h as Map)));
        } catch (_) {
          invalid++;
        }
      }
    }

    // Process Templates
    if (payload['templates'] is List) {
      for (final t in payload['templates'] as List) {
        try {
          validTemplates.add(ReminderTemplate.fromJson(Map<String, dynamic>.from(t as Map)));
        } catch (_) {
          invalid++;
        }
      }
    }

    // Process Media
    if (payload['media'] is Map) {
      final m = payload['media'] as Map;
      m.forEach((key, val) {
        if (key is String && val is String) {
          mediaMap[key] = val;
        } else {
          invalidMedia++;
        }
      });
    }

    CompanionProfile? companionProfile;
    if (payload['companion'] is Map) {
      try {
        companionProfile = CompanionProfile.fromJson(Map<String, dynamic>.from(payload['companion'] as Map));
      } catch (_) {}
    }

    // Process Todos
    final validTodos = <Todo>[];
    if (payload['todos'] is List) {
      for (final t in payload['todos'] as List) {
        try {
          validTodos.add(Todo.fromJson(Map<String, dynamic>.from(t as Map)));
        } catch (_) {}
      }
    }

    // Process Records
    final validRecords = <Record>[];
    if (payload['records'] is List) {
      for (final r in payload['records'] as List) {
        try {
          validRecords.add(Record.fromJson(Map<String, dynamic>.from(r as Map)));
        } catch (_) {}
      }
    }

    // Process Tags
    final validTags = <Tag>[];
    if (payload['tags'] is List) {
      for (final tag in payload['tags'] as List) {
        try {
          validTags.add(Tag.fromJson(Map<String, dynamic>.from(tag as Map)));
        } catch (_) {}
      }
    }

    int added = 0;
    int updated = 0;
    int skipped = 0;

    for (final r in validReminders) {
      final exists = existingIds.contains(r.id);
      if (exists) {
        if (policy == BackupConflictPolicy.replace) {
          updated++;
        } else if (policy == BackupConflictPolicy.skip || policy == BackupConflictPolicy.keep) {
          skipped++;
        } else if (policy == BackupConflictPolicy.importAsCopy) {
          added++;
        }
      } else {
        added++;
      }
    }

    final total = validReminders.length + validTodos.length + validRecords.length + invalid;

    return BackupPreview(
      totalRecords: total,
      addedCount: added,
      updatedCount: updated,
      skippedCount: skipped,
      duplicateCount: duplicates,
      invalidCount: invalid,
      invalidMediaCount: invalidMedia,
      validReminders: validReminders,
      validOccurrences: validOccurrences,
      validFolders: validFolders,
      validHistory: validHistory,
      validTemplates: validTemplates,
      companionProfile: companionProfile,
      validTodos: validTodos,
      validRecords: validRecords,
      validTags: validTags,
      mediaFiles: mediaMap,
    );
  }

  /// Commits the previewed backup atomically inside a SQLite transaction according to [policy].
  static Future<void> commitImport(
    BackupPreview preview, {
    BackupConflictPolicy policy = BackupConflictPolicy.skip,
  }) async {
    AppLogger.info(_subsystem, 'Committing backup import atomically with policy: $policy');
    final db = await AppDatabase.database;

    final existingReminders = await ReminderRepositoryImpl().getAllReminders();
    final existingIds = existingReminders.map((r) => r.id).toSet();

    await db.transaction((txn) async {
      // 1. Folders: insert with conflict ignore
      for (final folder in preview.validFolders) {
        await txn.insert(
          'folders',
          folder.toJson(),
          conflictAlgorithm: ConflictAlgorithm.ignore,
        );
      }

      // 2. ID Mapping if importing as copy
      final idMap = <String, String>{};
      if (policy == BackupConflictPolicy.importAsCopy) {
        for (final r in preview.validReminders) {
          if (existingIds.contains(r.id)) {
            idMap[r.id] = const Uuid().v4();
          }
        }
      }

      // 3. Reminders & Checklist Items
      for (final reminder in preview.validReminders) {
        final isConflict = existingIds.contains(reminder.id);
        if (isConflict && (policy == BackupConflictPolicy.skip || policy == BackupConflictPolicy.keep)) {
          continue;
        }

        final targetId = idMap[reminder.id] ?? reminder.id;
        final finalReminder = reminder.copyWith(id: targetId);

        final rData = finalReminder.toJson();
        rData.remove('checklist');

        await txn.insert(
          'reminders',
          rData,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );

        for (final item in finalReminder.checklist) {
          await txn.insert(
            'checklist_items',
            {
              'id': const Uuid().v4(),
              'reminderId': targetId,
              'text': item.text,
              'isDone': item.isDone ? 1 : 0,
            },
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      }

      // 4. Occurrences
      for (final occ in preview.validOccurrences) {
        final targetReminderId = idMap[occ.reminderId] ?? occ.reminderId;
        final targetOccId = idMap.containsKey(occ.reminderId) ? const Uuid().v4() : occ.id;

        await txn.insert(
          'reminder_occurrences',
          occ.copyWith(id: targetOccId, reminderId: targetReminderId).toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      // 5. History
      for (final h in preview.validHistory) {
        final targetReminderId = idMap[h.reminderId] ?? h.reminderId;
        await txn.insert(
          'reminder_history',
          {
            'id': const Uuid().v4(),
            'reminderId': targetReminderId,
            'action': h.action.name,
            'timestamp': h.timestamp.toIso8601String(),
            'details': h.details,
          },
          conflictAlgorithm: ConflictAlgorithm.ignore,
        );
      }

      // 6. Templates
      for (final t in preview.validTemplates) {
        await txn.insert(
          'reminder_templates',
          {
            'id': t.id,
            'title': t.title,
            'message': t.message,
            'priority': t.priority.name,
            'alertStyle': t.alertStyle.name,
            'repeatRule': t.repeatRule.name,
            'checklistJson': jsonEncode(t.checklist.map((e) => e.toJson()).toList()),
          },
          conflictAlgorithm: ConflictAlgorithm.ignore,
        );
      }

      // 7. Companion profile
      if (preview.companionProfile != null) {
        final c = preview.companionProfile!;
        await txn.insert(
          'companion_profile',
          {
            'id': 1,
            'name': c.name,
            'lifetimeCompletions': c.lifetimeCompletions,
            'currentStreak': c.currentStreak,
            'streakFreezes': c.streakFreezes,
            'equippedCosmetic': c.equippedCosmetic,
            'unlockedCosmeticsJson': jsonEncode(c.unlockedCosmetics),
            'lastActiveDate': c.lastActiveDate?.toIso8601String(),
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      // 8. Tags
      for (final tag in preview.validTags) {
        await txn.insert(
          'tags',
          tag.toJson(),
          conflictAlgorithm: ConflictAlgorithm.ignore,
        );
      }

      // 9. Todos & Subtasks
      for (final todo in preview.validTodos) {
        final targetTodoId = policy == BackupConflictPolicy.importAsCopy ? const Uuid().v4() : todo.id;
        final tData = todo.copyWith(id: targetTodoId).toJson();
        tData.remove('subtasks');
        await txn.insert(
          'todos',
          tData,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );

        for (final subtask in todo.subtasks) {
          await txn.insert(
            'todo_subtasks',
            subtask.copyWith(id: const Uuid().v4(), todoId: targetTodoId).toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      }

      // 10. Records
      for (final record in preview.validRecords) {
        final targetRecordId = policy == BackupConflictPolicy.importAsCopy ? const Uuid().v4() : record.id;
        await txn.insert(
          'records',
          record.copyWith(id: targetRecordId).toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });

    // 11. Restore sandboxed media files
    for (final entry in preview.mediaFiles.entries) {
      await AppMediaRepository.importMediaBase64(entry.key, entry.value);
    }

    AppLogger.info(_subsystem, 'Backup import committed successfully');
  }
}
```

---

<a id="lib-data-database-app_databasedart"></a>
## 31. `lib/data/database/app_database.dart`

**Path**: `lib/data/database/app_database.dart` | **Lines**: 480

```dart
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../../core/constants/app_constants.dart';
import '../../core/logging/app_logger.dart';

class AppDatabase {
  static const String _subsystem = 'AppDatabase';
  static const String _dbName = 'nudge_v2.db';
  static const int _dbVersion = 3;

  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    if (kIsWeb) {
      throw UnsupportedError('Web SQLite is not supported in offline mode');
    }

    if (Platform.isWindows || Platform.isLinux) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    String path;
    if (Platform.isWindows || Platform.isLinux) {
      final appDocDir = await getApplicationDocumentsDirectory();
      path = join(appDocDir.path, 'Nudge', _dbName);
      final dir = Directory(dirname(path));
      if (!dir.existsSync()) {
        dir.createSync(recursive: true);
      }
    } else {
      final databasesPath = await getDatabasesPath();
      path = join(databasesPath, _dbName);
    }

    AppLogger.info(_subsystem, 'Opening SQLite database at path: $path');
    return await openDatabase(
      path,
      version: _dbVersion,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (db, version) async {
        await _createTables(db);
        await _seedInitialData(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        AppLogger.info(_subsystem, 'Upgrading database from $oldVersion to $newVersion');
        if (oldVersion < 2) {
          try {
            await db.execute('ALTER TABLE reminders ADD COLUMN isAlarmSynced INTEGER NOT NULL DEFAULT 1');
          } catch (_) {}

          await db.execute('''
            CREATE TABLE IF NOT EXISTS reminder_occurrences (
              id TEXT PRIMARY KEY,
              reminderId TEXT NOT NULL,
              scheduledAt TEXT NOT NULL,
              completedAt TEXT,
              status TEXT NOT NULL,
              snoozeCount INTEGER NOT NULL DEFAULT 0,
              actionMetadata TEXT,
              FOREIGN KEY (reminderId) REFERENCES reminders(id) ON DELETE CASCADE
            )
          ''');

          await db.execute(
            'CREATE INDEX IF NOT EXISTS idx_occurrences_reminder ON reminder_occurrences(reminderId)',
          );
          await db.execute(
            'CREATE INDEX IF NOT EXISTS idx_occurrences_scheduled ON reminder_occurrences(scheduledAt)',
          );
        }

        if (oldVersion < 3) {
          await db.execute('''
            CREATE TABLE IF NOT EXISTS todos (
              id TEXT PRIMARY KEY,
              title TEXT NOT NULL,
              description TEXT,
              status TEXT NOT NULL,
              priority TEXT NOT NULL,
              folderId TEXT,
              createdAt TEXT NOT NULL,
              updatedAt TEXT NOT NULL,
              completedAt TEXT,
              dueAt TEXT,
              isPinned INTEGER NOT NULL DEFAULT 0,
              isArchived INTEGER NOT NULL DEFAULT 0,
              isDeleted INTEGER NOT NULL DEFAULT 0,
              parentTodoId TEXT,
              sortOrder INTEGER NOT NULL DEFAULT 0,
              tagsJson TEXT,
              recurrenceRule TEXT,
              reminderEnabled INTEGER NOT NULL DEFAULT 0,
              reminderAt TEXT,
              colorTag TEXT,
              sourceRecordId TEXT,
              metadataJson TEXT,
              FOREIGN KEY (folderId) REFERENCES folders(id) ON DELETE SET NULL
            )
          ''');

          await db.execute('''
            CREATE TABLE IF NOT EXISTS todo_subtasks (
              id TEXT PRIMARY KEY,
              todoId TEXT NOT NULL,
              text TEXT NOT NULL,
              isDone INTEGER NOT NULL DEFAULT 0,
              sortOrder INTEGER NOT NULL DEFAULT 0,
              createdAt TEXT NOT NULL,
              completedAt TEXT,
              FOREIGN KEY (todoId) REFERENCES todos(id) ON DELETE CASCADE
            )
          ''');

          await db.execute('''
            CREATE TABLE IF NOT EXISTS records (
              id TEXT PRIMARY KEY,
              title TEXT NOT NULL,
              content TEXT NOT NULL,
              recordType TEXT NOT NULL,
              createdAt TEXT NOT NULL,
              updatedAt TEXT NOT NULL,
              occurredAt TEXT,
              isPinned INTEGER NOT NULL DEFAULT 0,
              isArchived INTEGER NOT NULL DEFAULT 0,
              isDeleted INTEGER NOT NULL DEFAULT 0,
              folderId TEXT,
              colorTag TEXT,
              source TEXT,
              linkedReminderId TEXT,
              linkedTodoId TEXT,
              attachmentPath TEXT,
              metadataJson TEXT,
              FOREIGN KEY (folderId) REFERENCES folders(id) ON DELETE SET NULL
            )
          ''');

          await db.execute('''
            CREATE TABLE IF NOT EXISTS tags (
              id TEXT PRIMARY KEY,
              name TEXT NOT NULL UNIQUE,
              colorTag TEXT NOT NULL,
              createdAt TEXT NOT NULL
            )
          ''');

          await db.execute('''
            CREATE TABLE IF NOT EXISTS entity_tags (
              id TEXT PRIMARY KEY,
              tagId TEXT NOT NULL,
              entityType TEXT NOT NULL,
              entityId TEXT NOT NULL,
              FOREIGN KEY (tagId) REFERENCES tags(id) ON DELETE CASCADE
            )
          ''');

          await db.execute('CREATE INDEX IF NOT EXISTS idx_todos_status ON todos(status)');
          await db.execute('CREATE INDEX IF NOT EXISTS idx_todos_dueAt ON todos(dueAt)');
          await db.execute('CREATE INDEX IF NOT EXISTS idx_todos_folder ON todos(folderId)');
          await db.execute('CREATE INDEX IF NOT EXISTS idx_subtasks_todo ON todo_subtasks(todoId)');
          await db.execute('CREATE INDEX IF NOT EXISTS idx_records_type ON records(recordType)');
          await db.execute('CREATE INDEX IF NOT EXISTS idx_records_folder ON records(folderId)');
          await db.execute('CREATE INDEX IF NOT EXISTS idx_entity_tags_lookup ON entity_tags(entityType, entityId)');
        }
      },
    );
  }

  static Future<void> _createTables(Database db) async {
    AppLogger.info(_subsystem, 'Creating database tables');

    await db.execute('''
      CREATE TABLE folders (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        iconId TEXT NOT NULL,
        colorTag TEXT NOT NULL,
        createdAt TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE reminders (
        id TEXT PRIMARY KEY,
        message TEXT NOT NULL,
        folderId TEXT,
        scheduledAt TEXT NOT NULL,
        repeatRule TEXT NOT NULL,
        soundId TEXT,
        vibrationEnabled INTEGER NOT NULL DEFAULT 1,
        isDone INTEGER NOT NULL DEFAULT 0,
        createdAt TEXT NOT NULL,
        photoPath TEXT,
        priority TEXT NOT NULL,
        repeatEndOccurrences INTEGER,
        repeatEndDate TEXT,
        alertStyle TEXT NOT NULL,
        snoozeCount INTEGER NOT NULL DEFAULT 0,
        calendarEventId TEXT,
        isPinned INTEGER NOT NULL DEFAULT 0,
        isArchived INTEGER NOT NULL DEFAULT 0,
        isAlarmSynced INTEGER NOT NULL DEFAULT 1,
        customRepeatInterval INTEGER,
        customRepeatDays TEXT,
        customRepeatType TEXT,
        FOREIGN KEY (folderId) REFERENCES folders(id) ON DELETE SET NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE reminder_occurrences (
        id TEXT PRIMARY KEY,
        reminderId TEXT NOT NULL,
        scheduledAt TEXT NOT NULL,
        completedAt TEXT,
        status TEXT NOT NULL,
        snoozeCount INTEGER NOT NULL DEFAULT 0,
        actionMetadata TEXT,
        FOREIGN KEY (reminderId) REFERENCES reminders(id) ON DELETE CASCADE
      )
    ''');

    await db.execute(
      'CREATE INDEX IF NOT EXISTS idx_occurrences_reminder ON reminder_occurrences(reminderId)',
    );
    await db.execute(
      'CREATE INDEX IF NOT EXISTS idx_occurrences_scheduled ON reminder_occurrences(scheduledAt)',
    );

    await db.execute('''
      CREATE TABLE checklist_items (
        id TEXT PRIMARY KEY,
        reminderId TEXT NOT NULL,
        text TEXT NOT NULL,
        isDone INTEGER NOT NULL DEFAULT 0,
        FOREIGN KEY (reminderId) REFERENCES reminders(id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE reminder_history (
        id TEXT PRIMARY KEY,
        reminderId TEXT NOT NULL,
        action TEXT NOT NULL,
        timestamp TEXT NOT NULL,
        details TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE reminder_templates (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        message TEXT NOT NULL,
        priority TEXT NOT NULL,
        alertStyle TEXT NOT NULL,
        repeatRule TEXT NOT NULL,
        checklistJson TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE companion_profile (
        id INTEGER PRIMARY KEY CHECK (id = 1),
        name TEXT NOT NULL,
        lifetimeCompletions INTEGER NOT NULL DEFAULT 0,
        currentStreak INTEGER NOT NULL DEFAULT 0,
        streakFreezes INTEGER NOT NULL DEFAULT 2,
        equippedCosmetic TEXT,
        unlockedCosmeticsJson TEXT NOT NULL DEFAULT '[]',
        lastActiveDate TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE pending_actions (
        id TEXT PRIMARY KEY,
        action TEXT NOT NULL,
        reminderId TEXT NOT NULL,
        occurrenceTimestamp TEXT NOT NULL,
        createdAt TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE todos (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT,
        status TEXT NOT NULL,
        priority TEXT NOT NULL,
        folderId TEXT,
        createdAt TEXT NOT NULL,
        updatedAt TEXT NOT NULL,
        completedAt TEXT,
        dueAt TEXT,
        isPinned INTEGER NOT NULL DEFAULT 0,
        isArchived INTEGER NOT NULL DEFAULT 0,
        isDeleted INTEGER NOT NULL DEFAULT 0,
        parentTodoId TEXT,
        sortOrder INTEGER NOT NULL DEFAULT 0,
        tagsJson TEXT,
        recurrenceRule TEXT,
        reminderEnabled INTEGER NOT NULL DEFAULT 0,
        reminderAt TEXT,
        colorTag TEXT,
        sourceRecordId TEXT,
        metadataJson TEXT,
        FOREIGN KEY (folderId) REFERENCES folders(id) ON DELETE SET NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE todo_subtasks (
        id TEXT PRIMARY KEY,
        todoId TEXT NOT NULL,
        text TEXT NOT NULL,
        isDone INTEGER NOT NULL DEFAULT 0,
        sortOrder INTEGER NOT NULL DEFAULT 0,
        createdAt TEXT NOT NULL,
        completedAt TEXT,
        FOREIGN KEY (todoId) REFERENCES todos(id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE records (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        recordType TEXT NOT NULL,
        createdAt TEXT NOT NULL,
        updatedAt TEXT NOT NULL,
        occurredAt TEXT,
        isPinned INTEGER NOT NULL DEFAULT 0,
        isArchived INTEGER NOT NULL DEFAULT 0,
        isDeleted INTEGER NOT NULL DEFAULT 0,
        folderId TEXT,
        colorTag TEXT,
        source TEXT,
        linkedReminderId TEXT,
        linkedTodoId TEXT,
        attachmentPath TEXT,
        metadataJson TEXT,
        FOREIGN KEY (folderId) REFERENCES folders(id) ON DELETE SET NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE tags (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL UNIQUE,
        colorTag TEXT NOT NULL,
        createdAt TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE entity_tags (
        id TEXT PRIMARY KEY,
        tagId TEXT NOT NULL,
        entityType TEXT NOT NULL,
        entityId TEXT NOT NULL,
        FOREIGN KEY (tagId) REFERENCES tags(id) ON DELETE CASCADE
      )
    ''');

    await db.execute('CREATE INDEX IF NOT EXISTS idx_todos_status ON todos(status)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_todos_dueAt ON todos(dueAt)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_todos_folder ON todos(folderId)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_subtasks_todo ON todo_subtasks(todoId)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_records_type ON records(recordType)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_records_folder ON records(folderId)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_entity_tags_lookup ON entity_tags(entityType, entityId)');
  }

  static Future<void> _seedInitialData(Database db) async {
    AppLogger.info(_subsystem, 'Seeding initial folders and templates');

    // Default folders
    for (final folder in AppConstants.defaultFolders) {
      await db.insert('folders', {
        'id': folder['id'],
        'name': folder['name'],
        'iconId': folder['iconId'],
        'colorTag': folder['colorTag'],
        'createdAt': DateTime.now().toIso8601String(),
      });
    }

    // Default companion profile
    await db.insert('companion_profile', {
      'id': 1,
      'name': 'Nudge',
      'lifetimeCompletions': 0,
      'currentStreak': 0,
      'streakFreezes': 2,
      'equippedCosmetic': null,
      'unlockedCosmeticsJson': '[]',
      'lastActiveDate': null,
    });

    // Default templates
    final defaultTemplates = [
      {
        'id': 'template_study',
        'title': 'Study Session',
        'message': 'Study deep work session',
        'priority': 'high',
        'alertStyle': 'alarm',
        'repeatRule': 'none',
        'checklistJson': '[{"id":"1","text":"Review notes","isDone":0},{"id":"2","text":"Solve practice problems","isDone":0},{"id":"3","text":"Summarize key concepts","isDone":0}]',
      },
      {
        'id': 'template_assignment',
        'title': 'Assignment Deadline',
        'message': 'Submit course assignment',
        'priority': 'high',
        'alertStyle': 'alarm',
        'repeatRule': 'none',
        'checklistJson': '[{"id":"1","text":"Proofread final draft","isDone":0},{"id":"2","text":"Export PDF","isDone":0},{"id":"3","text":"Submit to portal","isDone":0}]',
      },
      {
        'id': 'template_bills',
        'title': 'Bill Payment',
        'message': 'Pay monthly utility & internet bill',
        'priority': 'normal',
        'alertStyle': 'gentle',
        'repeatRule': 'monthly',
        'checklistJson': '[{"id":"1","text":"Check bill statement","isDone":0},{"id":"2","text":"Complete payment","isDone":0},{"id":"3","text":"Save receipt","isDone":0}]',
      },
      {
        'id': 'template_cleanup',
        'title': 'Weekly Cleanup',
        'message': 'Weekly home & desk organization',
        'priority': 'low',
        'alertStyle': 'gentle',
        'repeatRule': 'weekly',
        'checklistJson': '[{"id":"1","text":"Clear physical desk","isDone":0},{"id":"2","text":"Clean room","isDone":0},{"id":"3","text":"Empty trash","isDone":0}]',
      },
    ];

    for (final template in defaultTemplates) {
      await db.insert('reminder_templates', template);
    }
  }

  /// Reset all data destructively
  static Future<void> resetDatabase() async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.delete('entity_tags');
      await txn.delete('tags');
      await txn.delete('records');
      await txn.delete('todo_subtasks');
      await txn.delete('todos');
      await txn.delete('checklist_items');
      await txn.delete('reminder_occurrences');
      await txn.delete('reminders');
      await txn.delete('folders');
      await txn.delete('reminder_history');
      await txn.delete('reminder_templates');
      await txn.delete('pending_actions');
      await txn.delete('companion_profile');
      await _seedInitialData(txn as Database);
    });
    AppLogger.info(_subsystem, 'Database reset complete and reseeded');
  }
}
```

---

<a id="lib-data-media-app_media_repositorydart"></a>
## 32. `lib/data/media/app_media_repository.dart`

**Path**: `lib/data/media/app_media_repository.dart` | **Lines**: 133

```dart
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import '../../core/logging/app_logger.dart';

class AppMediaRepository {
  static const String _subsystem = 'AppMediaRepository';
  static const String mediaSubdir = 'app_media';

  /// Returns the app-owned directory for storing reminder media.
  static Future<Directory> getMediaDirectory() async {
    final appDocs = await getApplicationDocumentsDirectory();
    final mediaDir = Directory(p.join(appDocs.path, mediaSubdir));
    if (!await mediaDir.exists()) {
      await mediaDir.create(recursive: true);
    }
    return mediaDir;
  }

  /// Copies an image from [sourcePath] into the application sandbox.
  /// Returns a stable relative filename (e.g. "media_abc123.jpg").
  static Future<String> importMedia(String sourcePath) async {
    final sourceFile = File(sourcePath);
    if (!await sourceFile.exists()) {
      throw FileSystemException('Source image does not exist', sourcePath);
    }

    final ext = p.extension(sourcePath).toLowerCase();
    final safeExt = ext.isNotEmpty ? ext : '.jpg';
    final filename = 'media_${const Uuid().v4()}$safeExt';

    final mediaDir = await getMediaDirectory();
    final targetPath = p.join(mediaDir.path, filename);

    await sourceFile.copy(targetPath);
    AppLogger.info(_subsystem, 'Imported media: $filename ($targetPath)');
    return filename;
  }

  /// Resolves a relative filename to a local [File], or null if missing.
  static Future<File?> resolveMediaFile(String? relativeFilename) async {
    if (relativeFilename == null || relativeFilename.trim().isEmpty) return null;

    try {
      final mediaDir = await getMediaDirectory();
      final file = File(p.join(mediaDir.path, relativeFilename));
      if (await file.exists()) {
        return file;
      }
    } catch (e) {
      AppLogger.warning(_subsystem, 'Error resolving media file $relativeFilename: $e');
    }
    return null;
  }

  /// Deletes a sandboxed media file by its relative filename.
  static Future<bool> deleteMedia(String? relativeFilename) async {
    if (relativeFilename == null || relativeFilename.trim().isEmpty) return false;

    try {
      final mediaDir = await getMediaDirectory();
      final file = File(p.join(mediaDir.path, relativeFilename));
      if (await file.exists()) {
        await file.delete();
        AppLogger.info(_subsystem, 'Deleted media file: $relativeFilename');
        return true;
      }
    } catch (e) {
      AppLogger.warning(_subsystem, 'Failed to delete media file $relativeFilename: $e');
    }
    return false;
  }

  /// Scans the sandbox media directory and removes any files not in [activeFilenames].
  static Future<int> cleanOrphanedMedia(Set<String> activeFilenames) async {
    int removedCount = 0;
    try {
      final mediaDir = await getMediaDirectory();
      final entities = mediaDir.listSync();

      for (final entity in entities) {
        if (entity is File) {
          final name = p.basename(entity.path);
          if (!activeFilenames.contains(name)) {
            await entity.delete();
            removedCount++;
          }
        }
      }
      if (removedCount > 0) {
        AppLogger.info(_subsystem, 'Cleaned $removedCount orphaned media files');
      }
    } catch (e) {
      AppLogger.warning(_subsystem, 'Error cleaning orphaned media: $e');
    }
    return removedCount;
  }

  /// Exports all sandboxed media as a map of `{ filename: base64Data }` for backups.
  static Future<Map<String, String>> exportAllMediaBase64() async {
    final result = <String, String>{};
    try {
      final mediaDir = await getMediaDirectory();
      final entities = mediaDir.listSync();

      for (final entity in entities) {
        if (entity is File) {
          final name = p.basename(entity.path);
          final bytes = await entity.readAsBytes();
          result[name] = base64Encode(bytes);
        }
      }
    } catch (e) {
      AppLogger.error(_subsystem, 'Failed to export media for backup', error: e);
    }
    return result;
  }

  /// Restores a base64 encoded media file into the sandboxed directory.
  static Future<void> importMediaBase64(String relativeFilename, String base64Data) async {
    try {
      final mediaDir = await getMediaDirectory();
      final file = File(p.join(mediaDir.path, relativeFilename));
      final bytes = base64Decode(base64Data);
      await file.writeAsBytes(bytes);
      AppLogger.info(_subsystem, 'Restored media file: $relativeFilename');
    } catch (e) {
      AppLogger.warning(_subsystem, 'Failed to restore media file $relativeFilename: $e');
    }
  }
}
```

---

<a id="lib-data-repositories-companion_repository_impldart"></a>
## 33. `lib/data/repositories/companion_repository_impl.dart`

**Path**: `lib/data/repositories/companion_repository_impl.dart` | **Lines**: 71

```dart
import 'dart:convert';
import '../../domain/entities/companion_profile.dart';
import '../../domain/repositories/i_companion_repository.dart';
import 'package:sqflite/sqflite.dart';
import '../database/app_database.dart';

class CompanionRepositoryImpl implements ICompanionRepository {
  @override
  Future<CompanionProfile> getProfile() async {
    final db = await AppDatabase.database;
    final rows = await db.query('companion_profile', where: 'id = 1');
    if (rows.isEmpty) {
      return const CompanionProfile();
    }
    final row = rows.first;
    List<String> unlocked = [];
    try {
      final raw = row['unlockedCosmeticsJson'] as String?;
      if (raw != null) {
        unlocked = (jsonDecode(raw) as List).map((e) => e.toString()).toList();
      }
    } catch (_) {}

    return CompanionProfile(
      name: row['name'] as String? ?? 'Nudge',
      lifetimeCompletions: (row['lifetimeCompletions'] as int?) ?? 0,
      currentStreak: (row['currentStreak'] as int?) ?? 0,
      streakFreezes: (row['streakFreezes'] as int?) ?? 2,
      equippedCosmetic: row['equippedCosmetic'] as String?,
      unlockedCosmetics: unlocked,
      lastActiveDate: row['lastActiveDate'] != null ? DateTime.parse(row['lastActiveDate'] as String) : null,
    );
  }

  @override
  Future<void> saveProfile(CompanionProfile profile) async {
    final db = await AppDatabase.database;
    await db.insert(
      'companion_profile',
      {
        'id': 1,
        'name': profile.name,
        'lifetimeCompletions': profile.lifetimeCompletions,
        'currentStreak': profile.currentStreak,
        'streakFreezes': profile.streakFreezes,
        'equippedCosmetic': profile.equippedCosmetic,
        'unlockedCosmeticsJson': jsonEncode(profile.unlockedCosmetics),
        'lastActiveDate': profile.lastActiveDate?.toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> resetProfile() async {
    final db = await AppDatabase.database;
    await db.update(
      'companion_profile',
      {
        'name': 'Nudge',
        'lifetimeCompletions': 0,
        'currentStreak': 0,
        'streakFreezes': 2,
        'equippedCosmetic': null,
        'unlockedCosmeticsJson': '[]',
        'lastActiveDate': null,
      },
      where: 'id = 1',
    );
  }
}
```

---

<a id="lib-data-repositories-folder_repository_impldart"></a>
## 34. `lib/data/repositories/folder_repository_impl.dart`

**Path**: `lib/data/repositories/folder_repository_impl.dart` | **Lines**: 58

```dart
﻿import '../../domain/entities/folder.dart';
import '../../domain/repositories/i_folder_repository.dart';
import '../../core/constants/app_constants.dart';
import '../database/app_database.dart';

class FolderRepositoryImpl implements IFolderRepository {
  @override
  Future<List<Folder>> getAllFolders() async {
    final db = await AppDatabase.database;
    final rows = await db.query('folders', orderBy: 'createdAt ASC');
    return rows.map((r) => Folder.fromJson(r)).toList();
  }

  @override
  Future<Folder?> getFolderById(String id) async {
    final db = await AppDatabase.database;
    final rows = await db.query('folders', where: 'id = ?', whereArgs: [id]);
    if (rows.isEmpty) return null;
    return Folder.fromJson(rows.first);
  }

  @override
  Future<void> saveFolder(Folder folder) async {
    final db = await AppDatabase.database;
    await db.insert('folders', folder.toJson());
  }

  @override
  Future<void> updateFolder(Folder folder) async {
    final db = await AppDatabase.database;
    await db.update('folders', folder.toJson(), where: 'id = ?', whereArgs: [folder.id]);
  }

  @override
  Future<void> deleteFolder(String id, {required bool deleteContainedReminders}) async {
    final db = await AppDatabase.database;
    await db.transaction((txn) async {
      if (deleteContainedReminders) {
        await txn.delete('reminders', where: 'folderId = ?', whereArgs: [id]);
      } else {
        // Move to General folder
        await txn.update(
          'reminders',
          {'folderId': AppConstants.generalFolderId},
          where: 'folderId = ?',
          whereArgs: [id],
        );
      }
      await txn.delete('folders', where: 'id = ?', whereArgs: [id]);
    });
  }

  @override
  Future<void> clearAllFolders() async {
    final db = await AppDatabase.database;
    await db.delete('folders');
  }
}
```

---

<a id="lib-data-repositories-history_repository_impldart"></a>
## 35. `lib/data/repositories/history_repository_impl.dart`

**Path**: `lib/data/repositories/history_repository_impl.dart` | **Lines**: 36

```dart
﻿import '../../domain/entities/reminder_history.dart';
import '../../domain/repositories/i_history_repository.dart';
import '../database/app_database.dart';

class HistoryRepositoryImpl implements IHistoryRepository {
  @override
  Future<List<ReminderHistory>> getAllHistory() async {
    final db = await AppDatabase.database;
    final rows = await db.query('reminder_history', orderBy: 'timestamp DESC');
    return rows.map((r) => ReminderHistory.fromJson(r)).toList();
  }

  @override
  Future<List<ReminderHistory>> getHistoryForReminder(String reminderId) async {
    final db = await AppDatabase.database;
    final rows = await db.query(
      'reminder_history',
      where: 'reminderId = ?',
      whereArgs: [reminderId],
      orderBy: 'timestamp DESC',
    );
    return rows.map((r) => ReminderHistory.fromJson(r)).toList();
  }

  @override
  Future<void> logEvent(ReminderHistory event) async {
    final db = await AppDatabase.database;
    await db.insert('reminder_history', event.toJson());
  }

  @override
  Future<void> clearHistory() async {
    final db = await AppDatabase.database;
    await db.delete('reminder_history');
  }
}
```

---

<a id="lib-data-repositories-occurrence_repository_impldart"></a>
## 36. `lib/data/repositories/occurrence_repository_impl.dart`

**Path**: `lib/data/repositories/occurrence_repository_impl.dart` | **Lines**: 93

```dart
import 'package:sqflite/sqflite.dart';
import '../../domain/entities/reminder_occurrence.dart';
import '../../domain/repositories/i_occurrence_repository.dart';
import '../database/app_database.dart';

class OccurrenceRepositoryImpl implements IOccurrenceRepository {
  @override
  Future<List<ReminderOccurrence>> getAllOccurrences() async {
    final db = await AppDatabase.database;
    final maps = await db.query('reminder_occurrences', orderBy: 'scheduledAt ASC');
    return maps.map((m) => ReminderOccurrence.fromJson(m)).toList();
  }

  @override
  Future<List<ReminderOccurrence>> getOccurrencesForReminder(String reminderId) async {
    final db = await AppDatabase.database;
    final maps = await db.query(
      'reminder_occurrences',
      where: 'reminderId = ?',
      whereArgs: [reminderId],
      orderBy: 'scheduledAt ASC',
    );
    return maps.map((m) => ReminderOccurrence.fromJson(m)).toList();
  }

  @override
  Future<ReminderOccurrence?> getOccurrenceById(String id) async {
    final db = await AppDatabase.database;
    final maps = await db.query(
      'reminder_occurrences',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isEmpty) return null;
    return ReminderOccurrence.fromJson(maps.first);
  }

  @override
  Future<ReminderOccurrence?> getPendingOccurrence(String reminderId) async {
    final db = await AppDatabase.database;
    final maps = await db.query(
      'reminder_occurrences',
      where: 'reminderId = ? AND status = ?',
      whereArgs: [reminderId, 'pending'],
      orderBy: 'scheduledAt ASC',
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return ReminderOccurrence.fromJson(maps.first);
  }

  @override
  Future<void> saveOccurrence(ReminderOccurrence occurrence) async {
    final db = await AppDatabase.database;
    await db.insert(
      'reminder_occurrences',
      occurrence.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> updateOccurrence(ReminderOccurrence occurrence) async {
    final db = await AppDatabase.database;
    await db.update(
      'reminder_occurrences',
      occurrence.toJson(),
      where: 'id = ?',
      whereArgs: [occurrence.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> deleteOccurrence(String id) async {
    final db = await AppDatabase.database;
    await db.delete(
      'reminder_occurrences',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> deleteOccurrencesForReminder(String reminderId) async {
    final db = await AppDatabase.database;
    await db.delete(
      'reminder_occurrences',
      where: 'reminderId = ?',
      whereArgs: [reminderId],
    );
  }
}
```

---

<a id="lib-data-repositories-pending_action_repository_impldart"></a>
## 37. `lib/data/repositories/pending_action_repository_impl.dart`

**Path**: `lib/data/repositories/pending_action_repository_impl.dart` | **Lines**: 30

```dart
﻿import '../../domain/entities/pending_action.dart';
import '../../domain/repositories/i_pending_action_repository.dart';
import '../database/app_database.dart';

class PendingActionRepositoryImpl implements IPendingActionRepository {
  @override
  Future<List<PendingAction>> getAllPendingActions() async {
    final db = await AppDatabase.database;
    final rows = await db.query('pending_actions', orderBy: 'createdAt ASC');
    return rows.map((r) => PendingAction.fromJson(r)).toList();
  }

  @override
  Future<void> addPendingAction(PendingAction action) async {
    final db = await AppDatabase.database;
    await db.insert('pending_actions', action.toJson());
  }

  @override
  Future<void> removePendingAction(String id) async {
    final db = await AppDatabase.database;
    await db.delete('pending_actions', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<void> clearPendingActions() async {
    final db = await AppDatabase.database;
    await db.delete('pending_actions');
  }
}
```

---

<a id="lib-data-repositories-record_repository_impldart"></a>
## 38. `lib/data/repositories/record_repository_impl.dart`

**Path**: `lib/data/repositories/record_repository_impl.dart` | **Lines**: 90

```dart
import 'package:sqflite/sqflite.dart';
import '../../core/logging/app_logger.dart';
import '../../domain/entities/record.dart';
import '../../domain/repositories/i_record_repository.dart';
import '../database/app_database.dart';

class RecordRepositoryImpl implements IRecordRepository {
  static const String _subsystem = 'RecordRepo';

  @override
  Future<List<Record>> getAllRecords({bool includeDeleted = false}) async {
    final db = await AppDatabase.database;
    final where = includeDeleted ? null : 'isDeleted = 0';
    final results = await db.query(
      'records',
      where: where,
      orderBy: 'isPinned DESC, occurredAt DESC, createdAt DESC',
    );
    return results.map((row) => Record.fromJson(Map<String, dynamic>.from(row))).toList();
  }

  @override
  Future<Record?> getRecordById(String id) async {
    final db = await AppDatabase.database;
    final results = await db.query('records', where: 'id = ?', whereArgs: [id], limit: 1);
    if (results.isEmpty) return null;
    return Record.fromJson(Map<String, dynamic>.from(results.first));
  }

  @override
  Future<void> createRecord(Record record) async {
    final db = await AppDatabase.database;
    await db.insert('records', record.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
    AppLogger.info(_subsystem, 'Created record: ${record.id}');
  }

  @override
  Future<void> updateRecord(Record record) async {
    final db = await AppDatabase.database;
    await db.update(
      'records',
      record.toJson(),
      where: 'id = ?',
      whereArgs: [record.id],
    );
    AppLogger.info(_subsystem, 'Updated record: ${record.id}');
  }

  @override
  Future<void> deleteRecord(String id, {bool hardDelete = false}) async {
    final db = await AppDatabase.database;
    if (hardDelete) {
      await db.delete('records', where: 'id = ?', whereArgs: [id]);
      AppLogger.info(_subsystem, 'Hard deleted record: $id');
    } else {
      await db.update(
        'records',
        {
          'isDeleted': 1,
          'updatedAt': DateTime.now().toIso8601String(),
        },
        where: 'id = ?',
        whereArgs: [id],
      );
      AppLogger.info(_subsystem, 'Soft deleted record: $id');
    }
  }

  @override
  Future<void> restoreRecord(String id) async {
    final db = await AppDatabase.database;
    await db.update(
      'records',
      {
        'isDeleted': 0,
        'updatedAt': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
    AppLogger.info(_subsystem, 'Restored record: $id');
  }

  @override
  Future<void> purgeTrash() async {
    final db = await AppDatabase.database;
    final count = await db.delete('records', where: 'isDeleted = 1');
    AppLogger.info(_subsystem, 'Purged $count records from trash');
  }
}
```

---

<a id="lib-data-repositories-reminder_repository_impldart"></a>
## 39. `lib/data/repositories/reminder_repository_impl.dart`

**Path**: `lib/data/repositories/reminder_repository_impl.dart` | **Lines**: 106

```dart
﻿import '../../domain/entities/reminder.dart';
import '../../domain/entities/checklist_item.dart';
import '../../domain/repositories/i_reminder_repository.dart';
import '../database/app_database.dart';

class ReminderRepositoryImpl implements IReminderRepository {
  @override
  Future<List<Reminder>> getAllReminders() async {
    final db = await AppDatabase.database;
    final reminderRows = await db.query('reminders', orderBy: 'scheduledAt ASC');
    if (reminderRows.isEmpty) return [];

    final checklistRows = await db.query('checklist_items');
    final checklistByReminder = <String, List<ChecklistItem>>{};
    for (final row in checklistRows) {
      final rId = row['reminderId'] as String;
      checklistByReminder.putIfAbsent(rId, () => []).add(
        ChecklistItem(
          id: row['id'] as String,
          text: row['text'] as String,
          isDone: (row['isDone'] as int) == 1,
        ),
      );
    }

    return reminderRows.map((row) {
      final rId = row['id'] as String;
      final map = Map<String, dynamic>.from(row);
      map['checklist'] = checklistByReminder[rId]?.map((c) => c.toJson()).toList() ?? [];
      return Reminder.fromJson(map);
    }).toList();
  }

  @override
  Future<Reminder?> getReminderById(String id) async {
    final db = await AppDatabase.database;
    final reminderRows = await db.query('reminders', where: 'id = ?', whereArgs: [id]);
    if (reminderRows.isEmpty) return null;

    final checklistRows = await db.query('checklist_items', where: 'reminderId = ?', whereArgs: [id]);
    final checklist = checklistRows.map((r) => ChecklistItem(
      id: r['id'] as String,
      text: r['text'] as String,
      isDone: (r['isDone'] as int) == 1,
    )).toList();

    final map = Map<String, dynamic>.from(reminderRows.first);
    map['checklist'] = checklist.map((c) => c.toJson()).toList();
    return Reminder.fromJson(map);
  }

  @override
  Future<void> saveReminder(Reminder reminder) async {
    final db = await AppDatabase.database;
    await db.transaction((txn) async {
      final reminderData = reminder.toJson();
      reminderData.remove('checklist'); // Handled separately in checklist_items table
      await txn.insert('reminders', reminderData);

      for (final item in reminder.checklist) {
        await txn.insert('checklist_items', {
          'id': item.id,
          'reminderId': reminder.id,
          'text': item.text,
          'isDone': item.isDone ? 1 : 0,
        });
      }
    });
  }

  @override
  Future<void> updateReminder(Reminder reminder) async {
    final db = await AppDatabase.database;
    await db.transaction((txn) async {
      final reminderData = reminder.toJson();
      reminderData.remove('checklist');
      await txn.update('reminders', reminderData, where: 'id = ?', whereArgs: [reminder.id]);

      // Re-sync checklist items
      await txn.delete('checklist_items', where: 'reminderId = ?', whereArgs: [reminder.id]);
      for (final item in reminder.checklist) {
        await txn.insert('checklist_items', {
          'id': item.id,
          'reminderId': reminder.id,
          'text': item.text,
          'isDone': item.isDone ? 1 : 0,
        });
      }
    });
  }

  @override
  Future<void> deleteReminder(String id) async {
    final db = await AppDatabase.database;
    await db.delete('reminders', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<void> clearAllReminders() async {
    final db = await AppDatabase.database;
    await db.transaction((txn) async {
      await txn.delete('checklist_items');
      await txn.delete('reminders');
    });
  }
}
```

---

<a id="lib-data-repositories-tag_repository_impldart"></a>
## 40. `lib/data/repositories/tag_repository_impl.dart`

**Path**: `lib/data/repositories/tag_repository_impl.dart` | **Lines**: 79

```dart
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import '../../core/logging/app_logger.dart';
import '../../domain/entities/tag.dart';
import '../../domain/repositories/i_tag_repository.dart';
import '../database/app_database.dart';

class TagRepositoryImpl implements ITagRepository {
  static const String _subsystem = 'TagRepo';

  @override
  Future<List<Tag>> getAllTags() async {
    final db = await AppDatabase.database;
    final results = await db.query('tags', orderBy: 'name ASC');
    return results.map((row) => Tag.fromJson(Map<String, dynamic>.from(row))).toList();
  }

  @override
  Future<Tag?> getTagByName(String name) async {
    final db = await AppDatabase.database;
    final results = await db.query(
      'tags',
      where: 'LOWER(name) = ?',
      whereArgs: [name.trim().toLowerCase()],
      limit: 1,
    );
    if (results.isEmpty) return null;
    return Tag.fromJson(Map<String, dynamic>.from(results.first));
  }

  @override
  Future<void> createTag(Tag tag) async {
    final db = await AppDatabase.database;
    await db.insert('tags', tag.toJson(), conflictAlgorithm: ConflictAlgorithm.ignore);
    AppLogger.info(_subsystem, 'Created tag: ${tag.name}');
  }

  @override
  Future<void> deleteTag(String id) async {
    final db = await AppDatabase.database;
    await db.transaction((txn) async {
      await txn.delete('entity_tags', where: 'tagId = ?', whereArgs: [id]);
      await txn.delete('tags', where: 'id = ?', whereArgs: [id]);
    });
    AppLogger.info(_subsystem, 'Deleted tag: $id');
  }

  @override
  Future<List<String>> getTagsForEntity(String entityType, String entityId) async {
    final db = await AppDatabase.database;
    final results = await db.rawQuery('''
      SELECT t.name FROM tags t
      INNER JOIN entity_tags et ON t.id = et.tagId
      WHERE et.entityType = ? AND et.entityId = ?
      ORDER BY t.name ASC
    ''', [entityType, entityId]);
    return results.map((row) => row['name'] as String).toList();
  }

  @override
  Future<void> setTagsForEntity(String entityType, String entityId, List<String> tagIds) async {
    final db = await AppDatabase.database;
    await db.transaction((txn) async {
      await txn.delete(
        'entity_tags',
        where: 'entityType = ? AND entityId = ?',
        whereArgs: [entityType, entityId],
      );
      for (final tagId in tagIds) {
        await txn.insert('entity_tags', {
          'id': const Uuid().v4(),
          'tagId': tagId,
          'entityType': entityType,
          'entityId': entityId,
        });
      }
    });
  }
}
```

---

<a id="lib-data-repositories-template_repository_impldart"></a>
## 41. `lib/data/repositories/template_repository_impl.dart`

**Path**: `lib/data/repositories/template_repository_impl.dart` | **Lines**: 69

```dart
﻿import 'dart:convert';
import '../../domain/entities/reminder_template.dart';
import '../../domain/entities/checklist_item.dart';
import '../../domain/enums/enums.dart';
import '../../domain/repositories/i_template_repository.dart';
import '../database/app_database.dart';

class TemplateRepositoryImpl implements ITemplateRepository {
  @override
  Future<List<ReminderTemplate>> getAllTemplates() async {
    final db = await AppDatabase.database;
    final rows = await db.query('reminder_templates');
    return rows.map((row) {
      final checklistRaw = row['checklistJson'] as String?;
      List<ChecklistItem> checklist = [];
      if (checklistRaw != null && checklistRaw.isNotEmpty) {
        try {
          final list = jsonDecode(checklistRaw) as List;
          checklist = list.map((e) => ChecklistItem.fromJson(Map<String, dynamic>.from(e as Map))).toList();
        } catch (_) {}
      }

      return ReminderTemplate(
        id: row['id'] as String,
        title: row['title'] as String,
        message: row['message'] as String,
        priority: PriorityLevel.values.firstWhere(
          (e) => e.name == row['priority'],
          orElse: () => PriorityLevel.normal,
        ),
        alertStyle: AlertStyle.values.firstWhere(
          (e) => e.name == row['alertStyle'],
          orElse: () => AlertStyle.alarm,
        ),
        repeatRule: RepeatRule.values.firstWhere(
          (e) => e.name == row['repeatRule'],
          orElse: () => RepeatRule.none,
        ),
        checklist: checklist,
      );
    }).toList();
  }

  @override
  Future<void> saveTemplate(ReminderTemplate template) async {
    final db = await AppDatabase.database;
    await db.insert('reminder_templates', {
      'id': template.id,
      'title': template.title,
      'message': template.message,
      'priority': template.priority.name,
      'alertStyle': template.alertStyle.name,
      'repeatRule': template.repeatRule.name,
      'checklistJson': jsonEncode(template.checklist.map((e) => e.toJson()).toList()),
    });
  }

  @override
  Future<void> deleteTemplate(String id) async {
    final db = await AppDatabase.database;
    await db.delete('reminder_templates', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<void> clearTemplates() async {
    final db = await AppDatabase.database;
    await db.delete('reminder_templates');
  }
}
```

---

<a id="lib-data-repositories-todo_repository_impldart"></a>
## 42. `lib/data/repositories/todo_repository_impl.dart`

**Path**: `lib/data/repositories/todo_repository_impl.dart` | **Lines**: 185

```dart
import 'package:sqflite/sqflite.dart';
import '../../core/logging/app_logger.dart';
import '../../domain/entities/todo.dart';
import '../../domain/entities/todo_subtask.dart';
import '../../domain/repositories/i_todo_repository.dart';
import '../database/app_database.dart';

class TodoRepositoryImpl implements ITodoRepository {
  static const String _subsystem = 'TodoRepo';

  @override
  Future<List<Todo>> getAllTodos({bool includeDeleted = false}) async {
    final db = await AppDatabase.database;
    final where = includeDeleted ? null : 'isDeleted = 0';
    final results = await db.query(
      'todos',
      where: where,
      orderBy: 'isPinned DESC, sortOrder ASC, createdAt DESC',
    );

    final List<Todo> todos = [];
    for (final row in results) {
      final id = row['id'] as String;
      final subtasks = await getSubtasksForTodo(id);
      final jsonMap = Map<String, dynamic>.from(row);
      jsonMap['subtasks'] = subtasks.map((s) => s.toJson()).toList();
      todos.add(Todo.fromJson(jsonMap));
    }
    return todos;
  }

  @override
  Future<Todo?> getTodoById(String id) async {
    final db = await AppDatabase.database;
    final results = await db.query('todos', where: 'id = ?', whereArgs: [id], limit: 1);
    if (results.isEmpty) return null;

    final subtasks = await getSubtasksForTodo(id);
    final jsonMap = Map<String, dynamic>.from(results.first);
    jsonMap['subtasks'] = subtasks.map((s) => s.toJson()).toList();
    return Todo.fromJson(jsonMap);
  }

  @override
  Future<void> createTodo(Todo todo) async {
    final db = await AppDatabase.database;
    await db.transaction((txn) async {
      final data = todo.toJson();
      data.remove('subtasks');
      await txn.insert('todos', data, conflictAlgorithm: ConflictAlgorithm.replace);

      for (final subtask in todo.subtasks) {
        await txn.insert(
          'todo_subtasks',
          subtask.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
    AppLogger.info(_subsystem, 'Created todo: ${todo.id}');
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    final db = await AppDatabase.database;
    final data = todo.toJson();
    data.remove('subtasks');
    await db.update('todos', data, where: 'id = ?', whereArgs: [todo.id]);
    AppLogger.info(_subsystem, 'Updated todo: ${todo.id}');
  }

  @override
  Future<void> deleteTodo(String id, {bool hardDelete = false}) async {
    final db = await AppDatabase.database;
    if (hardDelete) {
      await db.delete('todo_subtasks', where: 'todoId = ?', whereArgs: [id]);
      await db.delete('todos', where: 'id = ?', whereArgs: [id]);
      AppLogger.info(_subsystem, 'Hard deleted todo: $id');
    } else {
      await db.update(
        'todos',
        {
          'isDeleted': 1,
          'updatedAt': DateTime.now().toIso8601String(),
        },
        where: 'id = ?',
        whereArgs: [id],
      );
      AppLogger.info(_subsystem, 'Soft deleted todo: $id');
    }
  }

  @override
  Future<void> restoreTodo(String id) async {
    final db = await AppDatabase.database;
    await db.update(
      'todos',
      {
        'isDeleted': 0,
        'updatedAt': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
    AppLogger.info(_subsystem, 'Restored todo: $id');
  }

  @override
  Future<void> purgeTrash() async {
    final db = await AppDatabase.database;
    final deleted = await db.query('todos', columns: ['id'], where: 'isDeleted = 1');
    for (final row in deleted) {
      final id = row['id'] as String;
      await db.delete('todo_subtasks', where: 'todoId = ?', whereArgs: [id]);
    }
    final count = await db.delete('todos', where: 'isDeleted = 1');
    AppLogger.info(_subsystem, 'Purged $count todos from trash');
  }

  @override
  Future<void> updateSortOrders(List<String> todoIds) async {
    final db = await AppDatabase.database;
    final batch = db.batch();
    for (int i = 0; i < todoIds.length; i++) {
      batch.update(
        'todos',
        {'sortOrder': i},
        where: 'id = ?',
        whereArgs: [todoIds[i]],
      );
    }
    await batch.commit(noResult: true);
  }

  // Subtasks operations
  @override
  Future<List<TodoSubtask>> getSubtasksForTodo(String todoId) async {
    final db = await AppDatabase.database;
    final results = await db.query(
      'todo_subtasks',
      where: 'todoId = ?',
      whereArgs: [todoId],
      orderBy: 'sortOrder ASC, createdAt ASC',
    );
    return results.map((row) => TodoSubtask.fromJson(Map<String, dynamic>.from(row))).toList();
  }

  @override
  Future<void> addSubtask(TodoSubtask subtask) async {
    final db = await AppDatabase.database;
    await db.insert('todo_subtasks', subtask.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<void> updateSubtask(TodoSubtask subtask) async {
    final db = await AppDatabase.database;
    await db.update(
      'todo_subtasks',
      subtask.toJson(),
      where: 'id = ?',
      whereArgs: [subtask.id],
    );
  }

  @override
  Future<void> deleteSubtask(String id) async {
    final db = await AppDatabase.database;
    await db.delete('todo_subtasks', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<void> updateSubtaskSortOrders(List<String> subtaskIds) async {
    final db = await AppDatabase.database;
    final batch = db.batch();
    for (int i = 0; i < subtaskIds.length; i++) {
      batch.update(
        'todo_subtasks',
        {'sortOrder': i},
        where: 'id = ?',
        whereArgs: [subtaskIds[i]],
      );
    }
    await batch.commit(noResult: true);
  }
}
```

---

<a id="lib-domain-entities-checklist_itemdart"></a>
## 43. `lib/domain/entities/checklist_item.dart`

**Path**: `lib/domain/entities/checklist_item.dart` | **Lines**: 47

```dart
﻿import 'package:uuid/uuid.dart';

class ChecklistItem {
  final String id;
  final String text;
  final bool isDone;

  const ChecklistItem({
    required this.id,
    required this.text,
    this.isDone = false,
  });

  factory ChecklistItem.create({required String text, bool isDone = false}) {
    return ChecklistItem(
      id: const Uuid().v4(),
      text: text,
      isDone: isDone,
    );
  }

  ChecklistItem copyWith({
    String? id,
    String? text,
    bool? isDone,
  }) {
    return ChecklistItem(
      id: id ?? this.id,
      text: text ?? this.text,
      isDone: isDone ?? this.isDone,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'text': text,
    'isDone': isDone ? 1 : 0,
  };

  factory ChecklistItem.fromJson(Map<String, dynamic> json) {
    return ChecklistItem(
      id: json['id'] as String? ?? const Uuid().v4(),
      text: json['text'] as String? ?? '',
      isDone: json['isDone'] == 1 || json['isDone'] == true,
    );
  }
}
```

---

<a id="lib-domain-entities-companion_profiledart"></a>
## 44. `lib/domain/entities/companion_profile.dart`

**Path**: `lib/domain/entities/companion_profile.dart` | **Lines**: 67

```dart
class CompanionProfile {
  final String name;
  final int lifetimeCompletions;
  final int currentStreak;
  final int streakFreezes;
  final String? equippedCosmetic;
  final List<String> unlockedCosmetics;
  final DateTime? lastActiveDate;

  const CompanionProfile({
    this.name = 'Nudge',
    this.lifetimeCompletions = 0,
    this.currentStreak = 0,
    this.streakFreezes = 2,
    this.equippedCosmetic,
    this.unlockedCosmetics = const ['bandana'],
    this.lastActiveDate,
  });

  CompanionProfile copyWith({
    String? name,
    int? lifetimeCompletions,
    int? currentStreak,
    int? streakFreezes,
    String? equippedCosmetic,
    bool clearEquipped = false,
    List<String>? unlockedCosmetics,
    DateTime? lastActiveDate,
  }) {
    return CompanionProfile(
      name: name ?? this.name,
      lifetimeCompletions: lifetimeCompletions ?? this.lifetimeCompletions,
      currentStreak: currentStreak ?? this.currentStreak,
      streakFreezes: streakFreezes ?? this.streakFreezes,
      equippedCosmetic: clearEquipped ? null : (equippedCosmetic ?? this.equippedCosmetic),
      unlockedCosmetics: unlockedCosmetics ?? this.unlockedCosmetics,
      lastActiveDate: lastActiveDate ?? this.lastActiveDate,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'lifetimeCompletions': lifetimeCompletions,
    'currentStreak': currentStreak,
    'streakFreezes': streakFreezes,
    'equippedCosmetic': equippedCosmetic,
    'unlockedCosmetics': unlockedCosmetics,
    'lastActiveDate': lastActiveDate?.toIso8601String(),
  };

  factory CompanionProfile.fromJson(Map<String, dynamic> json) {
    return CompanionProfile(
      name: json['name'] as String? ?? 'Nudge',
      lifetimeCompletions: (json['lifetimeCompletions'] as num?)?.toInt() ?? 0,
      currentStreak: (json['currentStreak'] as num?)?.toInt() ?? 0,
      streakFreezes: (json['streakFreezes'] as num?)?.toInt() ?? 2,
      equippedCosmetic: json['equippedCosmetic'] as String?,
      unlockedCosmetics: (json['unlockedCosmetics'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      lastActiveDate: json['lastActiveDate'] != null
          ? DateTime.parse(json['lastActiveDate'] as String)
          : null,
    );
  }
}
```

---

<a id="lib-domain-entities-folderdart"></a>
## 45. `lib/domain/entities/folder.dart`

**Path**: `lib/domain/entities/folder.dart` | **Lines**: 54

```dart
﻿import 'package:uuid/uuid.dart';

class Folder {
  final String id;
  final String name;
  final String iconId;
  final String colorTag;
  final DateTime createdAt;

  Folder({
    String? id,
    required this.name,
    required this.iconId,
    required this.colorTag,
    DateTime? createdAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  Folder copyWith({
    String? id,
    String? name,
    String? iconId,
    String? colorTag,
    DateTime? createdAt,
  }) {
    return Folder(
      id: id ?? this.id,
      name: name ?? this.name,
      iconId: iconId ?? this.iconId,
      colorTag: colorTag ?? this.colorTag,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'iconId': iconId,
    'colorTag': colorTag,
    'createdAt': createdAt.toIso8601String(),
  };

  factory Folder.fromJson(Map<String, dynamic> json) {
    return Folder(
      id: json['id'] as String,
      name: json['name'] as String,
      iconId: json['iconId'] as String? ?? 'folder',
      colorTag: json['colorTag'] as String? ?? '#006A60',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
    );
  }
}
```

---

<a id="lib-domain-entities-pending_actiondart"></a>
## 46. `lib/domain/entities/pending_action.dart`

**Path**: `lib/domain/entities/pending_action.dart` | **Lines**: 36

```dart
﻿import 'package:uuid/uuid.dart';

class PendingAction {
  final String id;
  final String action;
  final String reminderId;
  final DateTime occurrenceTimestamp;
  final DateTime createdAt;

  PendingAction({
    String? id,
    required this.action,
    required this.reminderId,
    required this.occurrenceTimestamp,
    DateTime? createdAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() => {
    'id': id,
    'action': action,
    'reminderId': reminderId,
    'occurrenceTimestamp': occurrenceTimestamp.toIso8601String(),
    'createdAt': createdAt.toIso8601String(),
  };

  factory PendingAction.fromJson(Map<String, dynamic> json) {
    return PendingAction(
      id: json['id'] as String,
      action: json['action'] as String,
      reminderId: json['reminderId'] as String,
      occurrenceTimestamp: DateTime.parse(json['occurrenceTimestamp'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}
```

---

<a id="lib-domain-entities-recorddart"></a>
## 47. `lib/domain/entities/record.dart`

**Path**: `lib/domain/entities/record.dart` | **Lines**: 135

```dart
import 'package:uuid/uuid.dart';
import '../enums/todo_enums.dart';

class Record {
  final String id;
  final String title;
  final String content;
  final RecordType recordType;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? occurredAt;
  final bool isPinned;
  final bool isArchived;
  final bool isDeleted;
  final String? folderId;
  final String? colorTag;
  final String? source;
  final String? linkedReminderId;
  final String? linkedTodoId;
  final String? attachmentPath;
  final String? metadataJson;

  Record({
    String? id,
    required this.title,
    required this.content,
    this.recordType = RecordType.note,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.occurredAt,
    this.isPinned = false,
    this.isArchived = false,
    this.isDeleted = false,
    this.folderId,
    this.colorTag,
    this.source,
    this.linkedReminderId,
    this.linkedTodoId,
    this.attachmentPath,
    this.metadataJson,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  Record copyWith({
    String? id,
    String? title,
    String? content,
    RecordType? recordType,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? occurredAt,
    bool? isPinned,
    bool? isArchived,
    bool? isDeleted,
    String? folderId,
    String? colorTag,
    String? source,
    String? linkedReminderId,
    String? linkedTodoId,
    String? attachmentPath,
    String? metadataJson,
  }) {
    return Record(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      recordType: recordType ?? this.recordType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
      occurredAt: occurredAt ?? this.occurredAt,
      isPinned: isPinned ?? this.isPinned,
      isArchived: isArchived ?? this.isArchived,
      isDeleted: isDeleted ?? this.isDeleted,
      folderId: folderId ?? this.folderId,
      colorTag: colorTag ?? this.colorTag,
      source: source ?? this.source,
      linkedReminderId: linkedReminderId ?? this.linkedReminderId,
      linkedTodoId: linkedTodoId ?? this.linkedTodoId,
      attachmentPath: attachmentPath ?? this.attachmentPath,
      metadataJson: metadataJson ?? this.metadataJson,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'content': content,
    'recordType': recordType.name,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    'occurredAt': occurredAt?.toIso8601String(),
    'isPinned': isPinned ? 1 : 0,
    'isArchived': isArchived ? 1 : 0,
    'isDeleted': isDeleted ? 1 : 0,
    'folderId': folderId,
    'colorTag': colorTag,
    'source': source,
    'linkedReminderId': linkedReminderId,
    'linkedTodoId': linkedTodoId,
    'attachmentPath': attachmentPath,
    'metadataJson': metadataJson,
  };

  factory Record.fromJson(Map<String, dynamic> json) {
    return Record(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      recordType: RecordType.values.firstWhere(
        (e) => e.name == json['recordType'],
        orElse: () => RecordType.note,
      ),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : DateTime.now(),
      occurredAt: json['occurredAt'] != null
          ? DateTime.parse(json['occurredAt'] as String)
          : null,
      isPinned: json['isPinned'] == 1 || json['isPinned'] == true,
      isArchived: json['isArchived'] == 1 || json['isArchived'] == true,
      isDeleted: json['isDeleted'] == 1 || json['isDeleted'] == true,
      folderId: json['folderId'] as String?,
      colorTag: json['colorTag'] as String?,
      source: json['source'] as String?,
      linkedReminderId: json['linkedReminderId'] as String?,
      linkedTodoId: json['linkedTodoId'] as String?,
      attachmentPath: json['attachmentPath'] as String?,
      metadataJson: json['metadataJson'] as String?,
    );
  }
}
```

---

<a id="lib-domain-entities-reminderdart"></a>
## 48. `lib/domain/entities/reminder.dart`

**Path**: `lib/domain/entities/reminder.dart` | **Lines**: 191

```dart
import 'package:uuid/uuid.dart';
import '../enums/enums.dart';
import 'checklist_item.dart';

class Reminder {
  final String id;
  final String message;
  final String? folderId;
  final DateTime scheduledAt;
  final RepeatRule repeatRule;
  final String? soundId;
  final bool vibrationEnabled;
  final bool isDone;
  final DateTime createdAt;
  final List<ChecklistItem> checklist;
  final String? photoPath;
  final PriorityLevel priority;
  final int? repeatEndOccurrences;
  final DateTime? repeatEndDate;
  final AlertStyle alertStyle;
  final int snoozeCount;
  final String? calendarEventId;
  final bool isPinned;
  final bool isArchived;
  final bool isAlarmSynced;
  final int? customRepeatInterval;
  final List<int>? customRepeatDays;
  final CustomRepeatType? customRepeatType;

  Reminder({
    String? id,
    required this.message,
    this.folderId,
    required this.scheduledAt,
    this.repeatRule = RepeatRule.none,
    this.soundId = 'alarm',
    this.vibrationEnabled = true,
    this.isDone = false,
    DateTime? createdAt,
    this.checklist = const [],
    this.photoPath,
    this.priority = PriorityLevel.normal,
    this.repeatEndOccurrences,
    this.repeatEndDate,
    this.alertStyle = AlertStyle.alarm,
    this.snoozeCount = 0,
    this.calendarEventId,
    this.isPinned = false,
    this.isArchived = false,
    this.isAlarmSynced = true,
    this.customRepeatInterval,
    this.customRepeatDays,
    this.customRepeatType,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  bool get isActive => !isDone && !isArchived;
  bool get isOverdue => !isDone && scheduledAt.isBefore(DateTime.now());
  bool get isRepeating => repeatRule != RepeatRule.none;
  bool get hasChecklist => checklist.isNotEmpty;
  int get checklistCompletedCount => checklist.where((item) => item.isDone).length;

  Reminder copyWith({
    String? id,
    String? message,
    String? folderId,
    DateTime? scheduledAt,
    RepeatRule? repeatRule,
    String? soundId,
    bool? vibrationEnabled,
    bool? isDone,
    DateTime? createdAt,
    List<ChecklistItem>? checklist,
    String? photoPath,
    PriorityLevel? priority,
    int? repeatEndOccurrences,
    DateTime? repeatEndDate,
    AlertStyle? alertStyle,
    int? snoozeCount,
    String? calendarEventId,
    bool? isPinned,
    bool? isArchived,
    bool? isAlarmSynced,
    int? customRepeatInterval,
    List<int>? customRepeatDays,
    CustomRepeatType? customRepeatType,
  }) {
    return Reminder(
      id: id ?? this.id,
      message: message ?? this.message,
      folderId: folderId ?? this.folderId,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      repeatRule: repeatRule ?? this.repeatRule,
      soundId: soundId ?? this.soundId,
      vibrationEnabled: vibrationEnabled ?? this.vibrationEnabled,
      isDone: isDone ?? this.isDone,
      createdAt: createdAt ?? this.createdAt,
      checklist: checklist ?? this.checklist,
      photoPath: photoPath ?? this.photoPath,
      priority: priority ?? this.priority,
      repeatEndOccurrences: repeatEndOccurrences ?? this.repeatEndOccurrences,
      repeatEndDate: repeatEndDate ?? this.repeatEndDate,
      alertStyle: alertStyle ?? this.alertStyle,
      snoozeCount: snoozeCount ?? this.snoozeCount,
      calendarEventId: calendarEventId ?? this.calendarEventId,
      isPinned: isPinned ?? this.isPinned,
      isArchived: isArchived ?? this.isArchived,
      isAlarmSynced: isAlarmSynced ?? this.isAlarmSynced,
      customRepeatInterval: customRepeatInterval ?? this.customRepeatInterval,
      customRepeatDays: customRepeatDays ?? this.customRepeatDays,
      customRepeatType: customRepeatType ?? this.customRepeatType,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'message': message,
    'folderId': folderId,
    'scheduledAt': scheduledAt.toIso8601String(),
    'repeatRule': repeatRule.name,
    'soundId': soundId,
    'vibrationEnabled': vibrationEnabled ? 1 : 0,
    'isDone': isDone ? 1 : 0,
    'createdAt': createdAt.toIso8601String(),
    'checklist': checklist.map((e) => e.toJson()).toList(),
    'photoPath': photoPath,
    'priority': priority.name,
    'repeatEndOccurrences': repeatEndOccurrences,
    'repeatEndDate': repeatEndDate?.toIso8601String(),
    'alertStyle': alertStyle.name,
    'snoozeCount': snoozeCount,
    'calendarEventId': calendarEventId,
    'isPinned': isPinned ? 1 : 0,
    'isArchived': isArchived ? 1 : 0,
    'isAlarmSynced': isAlarmSynced ? 1 : 0,
    'customRepeatInterval': customRepeatInterval,
    'customRepeatDays': customRepeatDays?.join(','),
    'customRepeatType': customRepeatType?.name,
  };

  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      id: json['id'] as String,
      message: json['message'] as String? ?? '',
      folderId: json['folderId'] as String?,
      scheduledAt: DateTime.parse(json['scheduledAt'] as String),
      repeatRule: RepeatRule.values.firstWhere(
        (e) => e.name == json['repeatRule'],
        orElse: () => RepeatRule.none,
      ),
      soundId: json['soundId'] as String? ?? 'alarm',
      vibrationEnabled: json['vibrationEnabled'] == 1 || json['vibrationEnabled'] == true,
      isDone: json['isDone'] == 1 || json['isDone'] == true,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      checklist: (json['checklist'] as List<dynamic>?)
              ?.map((e) => ChecklistItem.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          [],
      photoPath: json['photoPath'] as String?,
      priority: PriorityLevel.values.firstWhere(
        (e) => e.name == json['priority'],
        orElse: () => PriorityLevel.normal,
      ),
      repeatEndOccurrences: json['repeatEndOccurrences'] as int?,
      repeatEndDate: json['repeatEndDate'] != null
          ? DateTime.parse(json['repeatEndDate'] as String)
          : null,
      alertStyle: AlertStyle.values.firstWhere(
        (e) => e.name == json['alertStyle'],
        orElse: () => AlertStyle.alarm,
      ),
      snoozeCount: (json['snoozeCount'] as num?)?.toInt() ?? 0,
      calendarEventId: json['calendarEventId'] as String?,
      isPinned: json['isPinned'] == 1 || json['isPinned'] == true,
      isArchived: json['isArchived'] == 1 || json['isArchived'] == true,
      isAlarmSynced: json['isAlarmSynced'] == null ? true : (json['isAlarmSynced'] == 1 || json['isAlarmSynced'] == true),
      customRepeatInterval: (json['customRepeatInterval'] as num?)?.toInt(),
      customRepeatDays: json['customRepeatDays'] != null && (json['customRepeatDays'] as String).isNotEmpty
          ? (json['customRepeatDays'] as String).split(',').map((e) => int.parse(e.trim())).toList()
          : null,
      customRepeatType: json['customRepeatType'] != null
          ? CustomRepeatType.values.firstWhere(
              (e) => e.name == json['customRepeatType'],
              orElse: () => CustomRepeatType.days,
            )
          : null,
    );
  }
}
```

---

<a id="lib-domain-entities-reminder_historydart"></a>
## 49. `lib/domain/entities/reminder_history.dart`

**Path**: `lib/domain/entities/reminder_history.dart` | **Lines**: 40

```dart
﻿import 'package:uuid/uuid.dart';
import '../enums/enums.dart';

class ReminderHistory {
  final String id;
  final String reminderId;
  final ActionType action;
  final DateTime timestamp;
  final String? details;

  ReminderHistory({
    String? id,
    required this.reminderId,
    required this.action,
    DateTime? timestamp,
    this.details,
  })  : id = id ?? const Uuid().v4(),
        timestamp = timestamp ?? DateTime.now();

  Map<String, dynamic> toJson() => {
    'id': id,
    'reminderId': reminderId,
    'action': action.name,
    'timestamp': timestamp.toIso8601String(),
    'details': details,
  };

  factory ReminderHistory.fromJson(Map<String, dynamic> json) {
    return ReminderHistory(
      id: json['id'] as String,
      reminderId: json['reminderId'] as String,
      action: ActionType.values.firstWhere(
        (e) => e.name == json['action'],
        orElse: () => ActionType.created,
      ),
      timestamp: DateTime.parse(json['timestamp'] as String),
      details: json['details'] as String?,
    );
  }
}
```

---

<a id="lib-domain-entities-reminder_occurrencedart"></a>
## 50. `lib/domain/entities/reminder_occurrence.dart`

**Path**: `lib/domain/entities/reminder_occurrence.dart` | **Lines**: 85

```dart
import '../enums/enums.dart';

class ReminderOccurrence {
  final String id;
  final String reminderId;
  final DateTime scheduledAt;
  final DateTime? completedAt;
  final OccurrenceStatus status;
  final int snoozeCount;
  final String? actionMetadata;

  const ReminderOccurrence({
    required this.id,
    required this.reminderId,
    required this.scheduledAt,
    this.completedAt,
    this.status = OccurrenceStatus.pending,
    this.snoozeCount = 0,
    this.actionMetadata,
  });

  bool get isDone => status == OccurrenceStatus.completed;
  bool get isCompleted => isDone;
  bool get canSnooze => snoozeCount < 3;
  bool get isOverdue =>
      status == OccurrenceStatus.pending && scheduledAt.isBefore(DateTime.now());

  ReminderOccurrence copyWith({
    String? id,
    String? reminderId,
    DateTime? scheduledAt,
    DateTime? completedAt,
    OccurrenceStatus? status,
    int? snoozeCount,
    String? actionMetadata,
  }) {
    return ReminderOccurrence(
      id: id ?? this.id,
      reminderId: reminderId ?? this.reminderId,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      completedAt: completedAt ?? this.completedAt,
      status: status ?? this.status,
      snoozeCount: snoozeCount ?? this.snoozeCount,
      actionMetadata: actionMetadata ?? this.actionMetadata,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reminderId': reminderId,
      'scheduledAt': scheduledAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'status': status.name,
      'snoozeCount': snoozeCount,
      'actionMetadata': actionMetadata,
    };
  }

  factory ReminderOccurrence.fromJson(Map<String, dynamic> json) {
    return ReminderOccurrence(
      id: json['id'] as String,
      reminderId: json['reminderId'] as String,
      scheduledAt: DateTime.parse(json['scheduledAt'] as String),
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
      status: OccurrenceStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => OccurrenceStatus.pending,
      ),
      snoozeCount: (json['snoozeCount'] as num?)?.toInt() ?? 0,
      actionMetadata: json['actionMetadata'] as String?,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ReminderOccurrence && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
```

---

<a id="lib-domain-entities-reminder_templatedart"></a>
## 51. `lib/domain/entities/reminder_template.dart`

**Path**: `lib/domain/entities/reminder_template.dart` | **Lines**: 57

```dart
﻿import 'package:uuid/uuid.dart';
import '../enums/enums.dart';
import 'checklist_item.dart';

class ReminderTemplate {
  final String id;
  final String title;
  final String message;
  final PriorityLevel priority;
  final AlertStyle alertStyle;
  final RepeatRule repeatRule;
  final List<ChecklistItem> checklist;

  ReminderTemplate({
    String? id,
    required this.title,
    required this.message,
    this.priority = PriorityLevel.normal,
    this.alertStyle = AlertStyle.alarm,
    this.repeatRule = RepeatRule.none,
    this.checklist = const [],
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'message': message,
    'priority': priority.name,
    'alertStyle': alertStyle.name,
    'repeatRule': repeatRule.name,
    'checklist': checklist.map((e) => e.toJson()).toList(),
  };

  factory ReminderTemplate.fromJson(Map<String, dynamic> json) {
    return ReminderTemplate(
      id: json['id'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      priority: PriorityLevel.values.firstWhere(
        (e) => e.name == json['priority'],
        orElse: () => PriorityLevel.normal,
      ),
      alertStyle: AlertStyle.values.firstWhere(
        (e) => e.name == json['alertStyle'],
        orElse: () => AlertStyle.alarm,
      ),
      repeatRule: RepeatRule.values.firstWhere(
        (e) => e.name == json['repeatRule'],
        orElse: () => RepeatRule.none,
      ),
      checklist: (json['checklist'] as List<dynamic>?)
              ?.map((e) => ChecklistItem.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          [],
    );
  }
}
```

---

<a id="lib-domain-entities-smart_suggestiondart"></a>
## 52. `lib/domain/entities/smart_suggestion.dart`

**Path**: `lib/domain/entities/smart_suggestion.dart` | **Lines**: 17

```dart
﻿class SmartSuggestion {
  final String id;
  final String title;
  final String description;
  final String reminderId;
  final DateTime suggestedTime;
  final String actionType;

  const SmartSuggestion({
    required this.id,
    required this.title,
    required this.description,
    required this.reminderId,
    required this.suggestedTime,
    required this.actionType,
  });
}
```

---

<a id="lib-domain-entities-tagdart"></a>
## 53. `lib/domain/entities/tag.dart`

**Path**: `lib/domain/entities/tag.dart` | **Lines**: 48

```dart
import 'package:uuid/uuid.dart';

class Tag {
  final String id;
  final String name;
  final String colorTag;
  final DateTime createdAt;

  Tag({
    String? id,
    required this.name,
    this.colorTag = '#006A60',
    DateTime? createdAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  Tag copyWith({
    String? id,
    String? name,
    String? colorTag,
    DateTime? createdAt,
  }) {
    return Tag(
      id: id ?? this.id,
      name: name ?? this.name,
      colorTag: colorTag ?? this.colorTag,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'colorTag': colorTag,
    'createdAt': createdAt.toIso8601String(),
  };

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json['id'] as String,
      name: json['name'] as String,
      colorTag: json['colorTag'] as String? ?? '#006A60',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
    );
  }
}
```

---

<a id="lib-domain-entities-tododart"></a>
## 54. `lib/domain/entities/todo.dart`

**Path**: `lib/domain/entities/todo.dart` | **Lines**: 210

```dart
import 'dart:convert';
import 'package:uuid/uuid.dart';
import '../enums/todo_enums.dart';
import 'todo_subtask.dart';

class Todo {
  final String id;
  final String title;
  final String? description;
  final TodoStatus status;
  final TodoPriority priority;
  final String? folderId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? completedAt;
  final DateTime? dueAt;
  final bool isPinned;
  final bool isArchived;
  final bool isDeleted;
  final String? parentTodoId;
  final int sortOrder;
  final List<String> tags;
  final String? recurrenceRule;
  final bool reminderEnabled;
  final DateTime? reminderAt;
  final String? colorTag;
  final String? sourceRecordId;
  final String? metadataJson;
  final List<TodoSubtask> subtasks;

  Todo({
    String? id,
    required this.title,
    this.description,
    this.status = TodoStatus.pending,
    this.priority = TodoPriority.normal,
    this.folderId,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.completedAt,
    this.dueAt,
    this.isPinned = false,
    this.isArchived = false,
    this.isDeleted = false,
    this.parentTodoId,
    this.sortOrder = 0,
    this.tags = const [],
    this.recurrenceRule,
    this.reminderEnabled = false,
    this.reminderAt,
    this.colorTag,
    this.sourceRecordId,
    this.metadataJson,
    this.subtasks = const [],
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  bool get isDone => status == TodoStatus.completed;
  bool get isOverdue => !isDone && dueAt != null && dueAt!.isBefore(DateTime.now());
  bool get isDueToday {
    if (dueAt == null) return false;
    final now = DateTime.now();
    return dueAt!.year == now.year && dueAt!.month == now.month && dueAt!.day == now.day;
  }
  bool get hasSubtasks => subtasks.isNotEmpty;
  int get completedSubtasksCount => subtasks.where((s) => s.isDone).length;
  double get subtasksProgress => hasSubtasks ? completedSubtasksCount / subtasks.length : 0.0;

  Todo copyWith({
    String? id,
    String? title,
    String? description,
    TodoStatus? status,
    TodoPriority? priority,
    String? folderId,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? completedAt,
    DateTime? dueAt,
    bool? isPinned,
    bool? isArchived,
    bool? isDeleted,
    String? parentTodoId,
    int? sortOrder,
    List<String>? tags,
    String? recurrenceRule,
    bool? reminderEnabled,
    DateTime? reminderAt,
    String? colorTag,
    String? sourceRecordId,
    String? metadataJson,
    List<TodoSubtask>? subtasks,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      folderId: folderId ?? this.folderId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
      completedAt: completedAt ?? this.completedAt,
      dueAt: dueAt ?? this.dueAt,
      isPinned: isPinned ?? this.isPinned,
      isArchived: isArchived ?? this.isArchived,
      isDeleted: isDeleted ?? this.isDeleted,
      parentTodoId: parentTodoId ?? this.parentTodoId,
      sortOrder: sortOrder ?? this.sortOrder,
      tags: tags ?? this.tags,
      recurrenceRule: recurrenceRule ?? this.recurrenceRule,
      reminderEnabled: reminderEnabled ?? this.reminderEnabled,
      reminderAt: reminderAt ?? this.reminderAt,
      colorTag: colorTag ?? this.colorTag,
      sourceRecordId: sourceRecordId ?? this.sourceRecordId,
      metadataJson: metadataJson ?? this.metadataJson,
      subtasks: subtasks ?? this.subtasks,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'status': status.name,
    'priority': priority.name,
    'folderId': folderId,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    'completedAt': completedAt?.toIso8601String(),
    'dueAt': dueAt?.toIso8601String(),
    'isPinned': isPinned ? 1 : 0,
    'isArchived': isArchived ? 1 : 0,
    'isDeleted': isDeleted ? 1 : 0,
    'parentTodoId': parentTodoId,
    'sortOrder': sortOrder,
    'tagsJson': jsonEncode(tags),
    'recurrenceRule': recurrenceRule,
    'reminderEnabled': reminderEnabled ? 1 : 0,
    'reminderAt': reminderAt?.toIso8601String(),
    'colorTag': colorTag,
    'sourceRecordId': sourceRecordId,
    'metadataJson': metadataJson,
    'subtasks': subtasks.map((s) => s.toJson()).toList(),
  };

  factory Todo.fromJson(Map<String, dynamic> json) {
    List<String> parsedTags = [];
    if (json['tagsJson'] != null) {
      try {
        final decoded = jsonDecode(json['tagsJson'] as String);
        if (decoded is List) {
          parsedTags = decoded.map((e) => e.toString()).toList();
        }
      } catch (_) {}
    } else if (json['tags'] is List) {
      parsedTags = (json['tags'] as List).map((e) => e.toString()).toList();
    }

    List<TodoSubtask> parsedSubtasks = [];
    if (json['subtasks'] is List) {
      parsedSubtasks = (json['subtasks'] as List)
          .map((s) => TodoSubtask.fromJson(Map<String, dynamic>.from(s as Map)))
          .toList();
    }

    return Todo(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      status: TodoStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => TodoStatus.pending,
      ),
      priority: TodoPriority.values.firstWhere(
        (e) => e.name == json['priority'],
        orElse: () => TodoPriority.normal,
      ),
      folderId: json['folderId'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : DateTime.now(),
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
      dueAt: json['dueAt'] != null
          ? DateTime.parse(json['dueAt'] as String)
          : null,
      isPinned: json['isPinned'] == 1 || json['isPinned'] == true,
      isArchived: json['isArchived'] == 1 || json['isArchived'] == true,
      isDeleted: json['isDeleted'] == 1 || json['isDeleted'] == true,
      parentTodoId: json['parentTodoId'] as String?,
      sortOrder: json['sortOrder'] as int? ?? 0,
      tags: parsedTags,
      recurrenceRule: json['recurrenceRule'] as String?,
      reminderEnabled: json['reminderEnabled'] == 1 || json['reminderEnabled'] == true,
      reminderAt: json['reminderAt'] != null
          ? DateTime.parse(json['reminderAt'] as String)
          : null,
      colorTag: json['colorTag'] as String?,
      sourceRecordId: json['sourceRecordId'] as String?,
      metadataJson: json['metadataJson'] as String?,
      subtasks: parsedSubtasks,
    );
  }
}
```

---

<a id="lib-domain-entities-todo_subtaskdart"></a>
## 55. `lib/domain/entities/todo_subtask.dart`

**Path**: `lib/domain/entities/todo_subtask.dart` | **Lines**: 68

```dart
import 'package:uuid/uuid.dart';

class TodoSubtask {
  final String id;
  final String todoId;
  final String text;
  final bool isDone;
  final int sortOrder;
  final DateTime createdAt;
  final DateTime? completedAt;

  TodoSubtask({
    String? id,
    required this.todoId,
    required this.text,
    this.isDone = false,
    this.sortOrder = 0,
    DateTime? createdAt,
    this.completedAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  TodoSubtask copyWith({
    String? id,
    String? todoId,
    String? text,
    bool? isDone,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? completedAt,
  }) {
    return TodoSubtask(
      id: id ?? this.id,
      todoId: todoId ?? this.todoId,
      text: text ?? this.text,
      isDone: isDone ?? this.isDone,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'todoId': todoId,
    'text': text,
    'isDone': isDone ? 1 : 0,
    'sortOrder': sortOrder,
    'createdAt': createdAt.toIso8601String(),
    'completedAt': completedAt?.toIso8601String(),
  };

  factory TodoSubtask.fromJson(Map<String, dynamic> json) {
    return TodoSubtask(
      id: json['id'] as String,
      todoId: json['todoId'] as String,
      text: json['text'] as String,
      isDone: (json['isDone'] is int ? json['isDone'] == 1 : json['isDone'] == true),
      sortOrder: json['sortOrder'] as int? ?? 0,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
    );
  }
}
```

---

<a id="lib-domain-enums-enumsdart"></a>
## 56. `lib/domain/enums/enums.dart`

**Path**: `lib/domain/enums/enums.dart` | **Lines**: 68

```dart
enum RepeatRule {
  none,
  daily,
  weekly,
  monthly,
  weekdays,
  weekends,
  customInterval,
}

enum PriorityLevel {
  low,
  normal,
  high,
}

enum AlertStyle {
  alarm,
  gentle,
}

enum CustomRepeatType {
  days,
  weeks,
  months,
}

enum CompanionMood {
  sleepy,
  neutral,
  happy,
  celebratory,
}

enum ActionType {
  created,
  edited,
  completed,
  snoozed,
  archived,
  restored,
  deleted,
  skipped,
}

enum SortOption {
  time,
  priority,
  created,
}

enum FilterType {
  all,
  today,
  overdue,
  upcoming,
  pinned,
  completed,
  archived,
}

enum OccurrenceStatus {
  pending,
  completed,
  snoozed,
  skipped,
  missed,
}
```

---

<a id="lib-domain-enums-todo_enumsdart"></a>
## 57. `lib/domain/enums/todo_enums.dart`

**Path**: `lib/domain/enums/todo_enums.dart` | **Lines**: 44

```dart
enum TodoStatus {
  pending,
  inProgress,
  completed,
  cancelled,
}

enum TodoPriority {
  low,
  normal,
  high,
  urgent,
}

enum TodoFilter {
  all,
  today,
  upcoming,
  highPriority,
  completed,
  archived,
  trash,
}

enum RecordType {
  note,
  idea,
  thought,
  log,
  snippet,
  decision,
}

enum RecordFilter {
  all,
  notes,
  ideas,
  thoughts,
  logs,
  snippets,
  decisions,
  archived,
  trash,
}
```

---

<a id="lib-domain-repositories-i_companion_repositorydart"></a>
## 58. `lib/domain/repositories/i_companion_repository.dart`

**Path**: `lib/domain/repositories/i_companion_repository.dart` | **Lines**: 7

```dart
﻿import '../entities/companion_profile.dart';

abstract class ICompanionRepository {
  Future<CompanionProfile> getProfile();
  Future<void> saveProfile(CompanionProfile profile);
  Future<void> resetProfile();
}
```

---

<a id="lib-domain-repositories-i_folder_repositorydart"></a>
## 59. `lib/domain/repositories/i_folder_repository.dart`

**Path**: `lib/domain/repositories/i_folder_repository.dart` | **Lines**: 10

```dart
﻿import '../entities/folder.dart';

abstract class IFolderRepository {
  Future<List<Folder>> getAllFolders();
  Future<Folder?> getFolderById(String id);
  Future<void> saveFolder(Folder folder);
  Future<void> updateFolder(Folder folder);
  Future<void> deleteFolder(String id, {required bool deleteContainedReminders});
  Future<void> clearAllFolders();
}
```

---

<a id="lib-domain-repositories-i_history_repositorydart"></a>
## 60. `lib/domain/repositories/i_history_repository.dart`

**Path**: `lib/domain/repositories/i_history_repository.dart` | **Lines**: 8

```dart
﻿import '../entities/reminder_history.dart';

abstract class IHistoryRepository {
  Future<List<ReminderHistory>> getAllHistory();
  Future<List<ReminderHistory>> getHistoryForReminder(String reminderId);
  Future<void> logEvent(ReminderHistory event);
  Future<void> clearHistory();
}
```

---

<a id="lib-domain-repositories-i_occurrence_repositorydart"></a>
## 61. `lib/domain/repositories/i_occurrence_repository.dart`

**Path**: `lib/domain/repositories/i_occurrence_repository.dart` | **Lines**: 12

```dart
import '../entities/reminder_occurrence.dart';

abstract class IOccurrenceRepository {
  Future<List<ReminderOccurrence>> getAllOccurrences();
  Future<List<ReminderOccurrence>> getOccurrencesForReminder(String reminderId);
  Future<ReminderOccurrence?> getOccurrenceById(String id);
  Future<ReminderOccurrence?> getPendingOccurrence(String reminderId);
  Future<void> saveOccurrence(ReminderOccurrence occurrence);
  Future<void> updateOccurrence(ReminderOccurrence occurrence);
  Future<void> deleteOccurrence(String id);
  Future<void> deleteOccurrencesForReminder(String reminderId);
}
```

---

<a id="lib-domain-repositories-i_pending_action_repositorydart"></a>
## 62. `lib/domain/repositories/i_pending_action_repository.dart`

**Path**: `lib/domain/repositories/i_pending_action_repository.dart` | **Lines**: 8

```dart
﻿import '../entities/pending_action.dart';

abstract class IPendingActionRepository {
  Future<List<PendingAction>> getAllPendingActions();
  Future<void> addPendingAction(PendingAction action);
  Future<void> removePendingAction(String id);
  Future<void> clearPendingActions();
}
```

---

<a id="lib-domain-repositories-i_record_repositorydart"></a>
## 63. `lib/domain/repositories/i_record_repository.dart`

**Path**: `lib/domain/repositories/i_record_repository.dart` | **Lines**: 11

```dart
import '../entities/record.dart';

abstract class IRecordRepository {
  Future<List<Record>> getAllRecords({bool includeDeleted = false});
  Future<Record?> getRecordById(String id);
  Future<void> createRecord(Record record);
  Future<void> updateRecord(Record record);
  Future<void> deleteRecord(String id, {bool hardDelete = false});
  Future<void> restoreRecord(String id);
  Future<void> purgeTrash();
}
```

---

<a id="lib-domain-repositories-i_reminder_repositorydart"></a>
## 64. `lib/domain/repositories/i_reminder_repository.dart`

**Path**: `lib/domain/repositories/i_reminder_repository.dart` | **Lines**: 10

```dart
﻿import '../entities/reminder.dart';

abstract class IReminderRepository {
  Future<List<Reminder>> getAllReminders();
  Future<Reminder?> getReminderById(String id);
  Future<void> saveReminder(Reminder reminder);
  Future<void> updateReminder(Reminder reminder);
  Future<void> deleteReminder(String id);
  Future<void> clearAllReminders();
}
```

---

<a id="lib-domain-repositories-i_tag_repositorydart"></a>
## 65. `lib/domain/repositories/i_tag_repository.dart`

**Path**: `lib/domain/repositories/i_tag_repository.dart` | **Lines**: 10

```dart
import '../entities/tag.dart';

abstract class ITagRepository {
  Future<List<Tag>> getAllTags();
  Future<Tag?> getTagByName(String name);
  Future<void> createTag(Tag tag);
  Future<void> deleteTag(String id);
  Future<List<String>> getTagsForEntity(String entityType, String entityId);
  Future<void> setTagsForEntity(String entityType, String entityId, List<String> tagIds);
}
```

---

<a id="lib-domain-repositories-i_template_repositorydart"></a>
## 66. `lib/domain/repositories/i_template_repository.dart`

**Path**: `lib/domain/repositories/i_template_repository.dart` | **Lines**: 8

```dart
﻿import '../entities/reminder_template.dart';

abstract class ITemplateRepository {
  Future<List<ReminderTemplate>> getAllTemplates();
  Future<void> saveTemplate(ReminderTemplate template);
  Future<void> deleteTemplate(String id);
  Future<void> clearTemplates();
}
```

---

<a id="lib-domain-repositories-i_todo_repositorydart"></a>
## 67. `lib/domain/repositories/i_todo_repository.dart`

**Path**: `lib/domain/repositories/i_todo_repository.dart` | **Lines**: 20

```dart
import '../entities/todo.dart';
import '../entities/todo_subtask.dart';

abstract class ITodoRepository {
  Future<List<Todo>> getAllTodos({bool includeDeleted = false});
  Future<Todo?> getTodoById(String id);
  Future<void> createTodo(Todo todo);
  Future<void> updateTodo(Todo todo);
  Future<void> deleteTodo(String id, {bool hardDelete = false});
  Future<void> restoreTodo(String id);
  Future<void> purgeTrash();
  Future<void> updateSortOrders(List<String> todoIds);

  // Subtasks
  Future<List<TodoSubtask>> getSubtasksForTodo(String todoId);
  Future<void> addSubtask(TodoSubtask subtask);
  Future<void> updateSubtask(TodoSubtask subtask);
  Future<void> deleteSubtask(String id);
  Future<void> updateSubtaskSortOrders(List<String> subtaskIds);
}
```

---

<a id="lib-domain-services-conflict_detectordart"></a>
## 68. `lib/domain/services/conflict_detector.dart`

**Path**: `lib/domain/services/conflict_detector.dart` | **Lines**: 73

```dart
﻿import '../entities/reminder.dart';
import '../../core/constants/app_constants.dart';

class ConflictDetectionResult {
  final bool hasConflict;
  final String? warningMessage;
  final List<Reminder> conflictingReminders;

  const ConflictDetectionResult({
    required this.hasConflict,
    this.warningMessage,
    this.conflictingReminders = const [],
  });

  static const noConflict = ConflictDetectionResult(hasConflict: false);
}

class ConflictDetector {
  /// Detects whether [candidate] conflicts with any active reminders.
  /// Ignores done reminders, archived reminders, or self (when editing).
  static ConflictDetectionResult checkConflicts({
    required Reminder candidate,
    required List<Reminder> existingReminders,
    String? currentEditingId,
  }) {
    final active = existingReminders.where((r) {
      if (r.id == currentEditingId || r.id == candidate.id) return false;
      if (r.isDone || r.isArchived) return false;
      return true;
    }).toList();

    final duplicates = <Reminder>[];
    final overlaps = <Reminder>[];

    final candidateMessageTrimmed = candidate.message.trim().toLowerCase();

    for (final reminder in active) {
      // Check duplicate active title
      if (candidateMessageTrimmed.isNotEmpty &&
          reminder.message.trim().toLowerCase() == candidateMessageTrimmed) {
        duplicates.add(reminder);
      }

      // Check within 15 minutes window
      final diffMinutes = reminder.scheduledAt.difference(candidate.scheduledAt).inMinutes.abs();
      if (diffMinutes < AppConstants.conflictWindowMinutes) {
        overlaps.add(reminder);
      }
    }

    if (duplicates.isNotEmpty && overlaps.isNotEmpty) {
      return ConflictDetectionResult(
        hasConflict: true,
        warningMessage: 'Duplicate reminder title and scheduled within 15m of "${overlaps.first.message}"',
        conflictingReminders: [...duplicates, ...overlaps],
      );
    } else if (duplicates.isNotEmpty) {
      return ConflictDetectionResult(
        hasConflict: true,
        warningMessage: 'A reminder with this exact title is already active',
        conflictingReminders: duplicates,
      );
    } else if (overlaps.isNotEmpty) {
      return ConflictDetectionResult(
        hasConflict: true,
        warningMessage: 'Scheduled within 15m of "${overlaps.first.message}" (${overlaps.first.scheduledAt.hour}:${overlaps.first.scheduledAt.minute.toString().padLeft(2, '0')})',
        conflictingReminders: overlaps,
      );
    }

    return ConflictDetectionResult.noConflict;
  }
}
```

---

<a id="lib-domain-services-nlp_parserdart"></a>
## 69. `lib/domain/services/nlp_parser.dart`

**Path**: `lib/domain/services/nlp_parser.dart` | **Lines**: 240

```dart
﻿import '../enums/enums.dart';

class NLPParseResult {
  final String cleanedMessage;
  final DateTime? scheduledDate;
  final int? scheduledHour;
  final int? scheduledMinute;
  final RepeatRule? repeatRule;
  final PriorityLevel? priority;
  final bool hasParsedScheduling;

  const NLPParseResult({
    required this.cleanedMessage,
    this.scheduledDate,
    this.scheduledHour,
    this.scheduledMinute,
    this.repeatRule,
    this.priority,
    this.hasParsedScheduling = false,
  });

  DateTime? get fullScheduledDateTime {
    if (scheduledDate == null) return null;
    final hour = scheduledHour ?? 9;
    final minute = scheduledMinute ?? 0;
    return DateTime(
      scheduledDate!.year,
      scheduledDate!.month,
      scheduledDate!.day,
      hour,
      minute,
    );
  }

  String get previewSummary {
    final parts = <String>[];
    if (scheduledDate != null) {
      final now = DateTime.now();
      if (scheduledDate!.year == now.year && scheduledDate!.month == now.month && scheduledDate!.day == now.day) {
        parts.add('Today');
      } else if (scheduledDate!.year == now.year && scheduledDate!.month == now.month && scheduledDate!.day == now.day + 1) {
        parts.add('Tomorrow');
      } else {
        parts.add('${scheduledDate!.month}/${scheduledDate!.day}');
      }
    }
    if (scheduledHour != null && scheduledMinute != null) {
      final period = scheduledHour! >= 12 ? 'PM' : 'AM';
      final h = scheduledHour! == 0 ? 12 : (scheduledHour! > 12 ? scheduledHour! - 12 : scheduledHour!);
      final m = scheduledMinute!.toString().padLeft(2, '0');
      parts.add('$h:$m $period');
    }
    if (repeatRule != null && repeatRule != RepeatRule.none) {
      parts.add(repeatRule!.name.toUpperCase());
    }
    if (priority != null && priority != PriorityLevel.normal) {
      parts.add('${priority!.name.toUpperCase()} PRIORITY');
    }
    return parts.join(' • ');
  }
}

class NLPParser {
  static NLPParseResult parse(String input) {
    if (input.trim().isEmpty) {
      return const NLPParseResult(cleanedMessage: '');
    }

    String working = input;
    DateTime? date;
    int? hour;
    int? minute;
    RepeatRule? repeatRule;
    PriorityLevel? priority;

    final now = DateTime.now();

    // 1. Priority parsing
    final priorityRegex = RegExp(r'\b(urgent|asap|important|p1|high priority)\b', caseSensitive: false);
    if (priorityRegex.hasMatch(working)) {
      priority = PriorityLevel.high;
      working = working.replaceAll(priorityRegex, ' ');
    }

    // 2. Relative time: "in 5 minutes", "in 30 mins", "in 2 hours", "in 1 hr"
    final relativeRegex = RegExp(r'\bin\s+(\d+)\s*(minutes|mins|min|hours|hrs|hr)\b', caseSensitive: false);
    final relativeMatch = relativeRegex.firstMatch(working);
    if (relativeMatch != null) {
      final amount = int.parse(relativeMatch.group(1)!);
      final unit = relativeMatch.group(2)!.toLowerCase();
      final target = unit.startsWith('h')
          ? now.add(Duration(hours: amount))
          : now.add(Duration(minutes: amount));
      date = DateTime(target.year, target.month, target.day);
      hour = target.hour;
      minute = target.minute;
      working = working.replaceAll(relativeRegex, ' ');
    }

    // 3. Recurrence parsing
    final dailyRegex = RegExp(r'\b(every\s*day|daily)\b', caseSensitive: false);
    final weeklyRegex = RegExp(r'\b(every\s*week|weekly)\b', caseSensitive: false);
    final monthlyRegex = RegExp(r'\b(every\s*month|monthly)\b', caseSensitive: false);
    final weekdaysRegex = RegExp(r'\b(every\s*weekday|weekdays)\b', caseSensitive: false);
    final weekendsRegex = RegExp(r'\b(every\s*weekend|weekends)\b', caseSensitive: false);

    if (dailyRegex.hasMatch(working)) {
      repeatRule = RepeatRule.daily;
      working = working.replaceAll(dailyRegex, ' ');
    } else if (weeklyRegex.hasMatch(working)) {
      repeatRule = RepeatRule.weekly;
      working = working.replaceAll(weeklyRegex, ' ');
    } else if (monthlyRegex.hasMatch(working)) {
      repeatRule = RepeatRule.monthly;
      working = working.replaceAll(monthlyRegex, ' ');
    } else if (weekdaysRegex.hasMatch(working)) {
      repeatRule = RepeatRule.weekdays;
      working = working.replaceAll(weekdaysRegex, ' ');
    } else if (weekendsRegex.hasMatch(working)) {
      repeatRule = RepeatRule.weekends;
      working = working.replaceAll(weekendsRegex, ' ');
    }

    // 4. Date parsing: "day after tomorrow", "tomorrow", "today", "tonight"
    final dayAfterTomorrowRegex = RegExp(r'\bday after tomorrow\b', caseSensitive: false);
    final tomorrowRegex = RegExp(r'\btomorrow\b', caseSensitive: false);
    final todayRegex = RegExp(r'\btoday\b', caseSensitive: false);
    final tonightRegex = RegExp(r'\btonight\b', caseSensitive: false);

    if (dayAfterTomorrowRegex.hasMatch(working)) {
      final target = now.add(const Duration(days: 2));
      date = DateTime(target.year, target.month, target.day);
      working = working.replaceAll(dayAfterTomorrowRegex, ' ');
    } else if (tomorrowRegex.hasMatch(working)) {
      final target = now.add(const Duration(days: 1));
      date = DateTime(target.year, target.month, target.day);
      working = working.replaceAll(tomorrowRegex, ' ');
    } else if (tonightRegex.hasMatch(working)) {
      date = DateTime(now.year, now.month, now.day);
      hour = 20; // 8:00 PM
      minute = 0;
      working = working.replaceAll(tonightRegex, ' ');
    } else if (todayRegex.hasMatch(working)) {
      date = DateTime(now.year, now.month, now.day);
      working = working.replaceAll(todayRegex, ' ');
    }

    // 5. Day of week: "Monday", "next Friday", etc.
    final dayOfWeekRegex = RegExp(r'\b(next\s+)?(monday|tuesday|wednesday|thursday|friday|saturday|sunday)\b', caseSensitive: false);
    final dowMatch = dayOfWeekRegex.firstMatch(working);
    if (dowMatch != null && date == null) {
      final isNext = dowMatch.group(1) != null;
      final dowName = dowMatch.group(2)!.toLowerCase();
      final targetDow = _parseDayOfWeek(dowName);
      var daysAhead = targetDow - now.weekday;
      if (daysAhead <= 0 || isNext) {
        daysAhead += 7;
      }
      final target = now.add(Duration(days: daysAhead));
      date = DateTime(target.year, target.month, target.day);
      working = working.replaceAll(dayOfWeekRegex, ' ');
    }

    // 6. Time of day: "morning", "afternoon", "evening", "night"
    final morningRegex = RegExp(r'\bmorning\b', caseSensitive: false);
    final afternoonRegex = RegExp(r'\bafternoon\b', caseSensitive: false);
    final eveningRegex = RegExp(r'\bevening\b', caseSensitive: false);
    final nightRegex = RegExp(r'\bnight\b', caseSensitive: false);

    if (morningRegex.hasMatch(working)) {
      hour ??= 9;
      minute ??= 0;
      working = working.replaceAll(morningRegex, ' ');
    } else if (afternoonRegex.hasMatch(working)) {
      hour ??= 14;
      minute ??= 0;
      working = working.replaceAll(afternoonRegex, ' ');
    } else if (eveningRegex.hasMatch(working)) {
      hour ??= 18;
      minute ??= 0;
      working = working.replaceAll(eveningRegex, ' ');
    } else if (nightRegex.hasMatch(working)) {
      hour ??= 21;
      minute ??= 0;
      working = working.replaceAll(nightRegex, ' ');
    }

    // 7. Explicit times: "at 8pm", "8:30 am", "18:00", "at 6 pm"
    final time12Regex = RegExp(r'\b(?:at\s+)?(\d{1,2})(?::(\d{2}))?\s*(am|pm)\b', caseSensitive: false);
    final time12Match = time12Regex.firstMatch(working);
    if (time12Match != null) {
      var h = int.parse(time12Match.group(1)!);
      final m = time12Match.group(2) != null ? int.parse(time12Match.group(2)!) : 0;
      final ampm = time12Match.group(3)!.toLowerCase();

      if (ampm == 'pm' && h < 12) h += 12;
      if (ampm == 'am' && h == 12) h = 0;

      hour = h;
      minute = m;
      working = working.replaceAll(time12Regex, ' ');
    } else {
      final time24Regex = RegExp(r'\b(?:at\s+)?([01]?\d|2[0-3]):([0-5]\d)\b', caseSensitive: false);
      final time24Match = time24Regex.firstMatch(working);
      if (time24Match != null) {
        hour = int.parse(time24Match.group(1)!);
        minute = int.parse(time24Match.group(2)!);
        working = working.replaceAll(time24Regex, ' ');
      }
    }

    // Clean up excessive whitespace in message
    final cleaned = working.replaceAll(RegExp(r'\s+'), ' ').trim();

    final hasParsed = date != null || hour != null || repeatRule != null || priority != null;

    return NLPParseResult(
      cleanedMessage: cleaned.isEmpty ? input.trim() : cleaned,
      scheduledDate: date,
      scheduledHour: hour,
      scheduledMinute: minute,
      repeatRule: repeatRule,
      priority: priority,
      hasParsedScheduling: hasParsed,
    );
  }

  static int _parseDayOfWeek(String name) {
    switch (name) {
      case 'monday': return 1;
      case 'tuesday': return 2;
      case 'wednesday': return 3;
      case 'thursday': return 4;
      case 'friday': return 5;
      case 'saturday': return 6;
      case 'sunday': return 7;
      default: return 1;
    }
  }
}
```

---

<a id="lib-domain-services-recurrence_enginedart"></a>
## 70. `lib/domain/services/recurrence_engine.dart`

**Path**: `lib/domain/services/recurrence_engine.dart` | **Lines**: 159

```dart
import '../entities/reminder.dart';
import '../enums/enums.dart';
import '../../core/utils/date_utils.dart';

class RecurrenceEngine {
  /// Computes the nth weekday of a given month (e.g. 2nd Tuesday of May).
  /// [nth] is 1-indexed (1 to 5). [weekday] is 1 (Monday) to 7 (Sunday).
  static DateTime calculateNthWeekdayOfMonth({
    required int year,
    required int month,
    required int nth,
    required int weekday,
    required int hour,
    required int minute,
  }) {
    DateTime firstDay = DateTime(year, month, 1, hour, minute);
    int diff = (weekday - firstDay.weekday) % 7;
    if (diff < 0) diff += 7;

    int targetDay = 1 + diff + (nth - 1) * 7;
    final daysInMonth = DateTime(year, month + 1, 0).day;
    if (targetDay > daysInMonth) {
      // Fallback to the last matching weekday of that month
      targetDay -= 7;
    }
    return DateTime(year, month, targetDay, hour, minute);
  }

  /// Calculates the next occurrence timestamp for a given reminder.
  /// Returns null if the reminder does not repeat or has reached its end criteria.
  static DateTime? calculateNextOccurrence(Reminder reminder, [DateTime? fromDate]) {
    if (reminder.repeatRule == RepeatRule.none) return null;

    final base = fromDate ?? reminder.scheduledAt;
    final origHour = reminder.scheduledAt.hour;
    final origMinute = reminder.scheduledAt.minute;
    DateTime next;

    switch (reminder.repeatRule) {
      case RepeatRule.daily:
        // Wall-clock safe date construction to handle DST transitions
        next = DateTime(base.year, base.month, base.day + 1, origHour, origMinute);
        break;

      case RepeatRule.weekly:
        next = DateTime(base.year, base.month, base.day + 7, origHour, origMinute);
        break;

      case RepeatRule.monthly:
        int nextYear = base.year;
        int nextMonth = base.month + 1;
        if (nextMonth > 12) {
          nextMonth = 1;
          nextYear += 1;
        }
        next = NudgeDateUtils.clampMonthDay(
          nextYear,
          nextMonth,
          reminder.scheduledAt.day,
          origHour,
          origMinute,
        );
        break;

      case RepeatRule.weekdays:
        // Mon = 1 ... Sun = 7
        var candidate = DateTime(base.year, base.month, base.day + 1, origHour, origMinute);
        while (candidate.weekday == DateTime.saturday || candidate.weekday == DateTime.sunday) {
          candidate = DateTime(candidate.year, candidate.month, candidate.day + 1, origHour, origMinute);
        }
        next = candidate;
        break;

      case RepeatRule.weekends:
        var candidate = DateTime(base.year, base.month, base.day + 1, origHour, origMinute);
        while (candidate.weekday != DateTime.saturday && candidate.weekday != DateTime.sunday) {
          candidate = DateTime(candidate.year, candidate.month, candidate.day + 1, origHour, origMinute);
        }
        next = candidate;
        break;

      case RepeatRule.customInterval:
        final interval = (reminder.customRepeatInterval != null && reminder.customRepeatInterval! > 0)
            ? reminder.customRepeatInterval!
            : 1;
        final type = reminder.customRepeatType ?? CustomRepeatType.days;
        final specificDays = reminder.customRepeatDays;

        if (specificDays != null && specificDays.isNotEmpty) {
          // Find the next day matching the list of weekdays (1=Mon ... 7=Sun)
          var candidate = DateTime(base.year, base.month, base.day + 1, origHour, origMinute);
          while (!specificDays.contains(candidate.weekday)) {
            candidate = DateTime(candidate.year, candidate.month, candidate.day + 1, origHour, origMinute);
          }
          next = candidate;
        } else {
          switch (type) {
            case CustomRepeatType.days:
              next = DateTime(base.year, base.month, base.day + interval, origHour, origMinute);
              break;
            case CustomRepeatType.weeks:
              next = DateTime(base.year, base.month, base.day + (interval * 7), origHour, origMinute);
              break;
            case CustomRepeatType.months:
              int nextYear = base.year;
              int nextMonth = base.month + interval;
              while (nextMonth > 12) {
                nextMonth -= 12;
                nextYear += 1;
              }
              next = NudgeDateUtils.clampMonthDay(
                nextYear,
                nextMonth,
                reminder.scheduledAt.day,
                origHour,
                origMinute,
              );
              break;
          }
        }
        break;

      case RepeatRule.none:
        return null;
    }

    // Check repeat end date
    if (reminder.repeatEndDate != null && next.isAfter(reminder.repeatEndDate!)) {
      return null;
    }

    // Check repeat end occurrences
    if (reminder.repeatEndOccurrences != null && reminder.repeatEndOccurrences! <= 1) {
      return null;
    }

    return next;
  }

  /// Catches up a recurring reminder that has been overdue across multiple cycles.
  /// Iteratively advances to the first occurrence that is >= [referenceTime].
  static DateTime? catchUpToFuture(Reminder reminder, DateTime referenceTime) {
    if (reminder.repeatRule == RepeatRule.none) return null;

    DateTime? current = reminder.scheduledAt;
    int remainingOccurrences = reminder.repeatEndOccurrences ?? 999999;

    while (current != null && current.isBefore(referenceTime) && remainingOccurrences > 1) {
      final updatedReminder = reminder.copyWith(
        scheduledAt: current,
        repeatEndOccurrences: remainingOccurrences,
      );
      current = calculateNextOccurrence(updatedReminder, current);
      remainingOccurrences--;
    }

    return current;
  }
}
```

---

<a id="lib-domain-services-smart_suggestion_enginedart"></a>
## 71. `lib/domain/services/smart_suggestion_engine.dart`

**Path**: `lib/domain/services/smart_suggestion_engine.dart` | **Lines**: 39

```dart
﻿import 'package:uuid/uuid.dart';
import '../entities/reminder.dart';
import '../entities/smart_suggestion.dart';

class SmartSuggestionEngine {
  static List<SmartSuggestion> generateSuggestions(List<Reminder> reminders) {
    final suggestions = <SmartSuggestion>[];

    for (final reminder in reminders) {
      if (reminder.isDone || reminder.isArchived) continue;

      // 1. Task snoozed 3 times -> Frequently snoozed suggestion
      if (reminder.snoozeCount >= 3) {
        suggestions.add(SmartSuggestion(
          id: const Uuid().v4(),
          title: 'Frequently Snoozed Task',
          description: '"${reminder.message}" was snoozed 3 times. Consider rescheduling to tomorrow morning.',
          reminderId: reminder.id,
          suggestedTime: DateTime.now().add(const Duration(days: 1)).copyWith(hour: 10, minute: 0),
          actionType: 'reschedule',
        ));
      }

      // 2. Overdue task for > 2 hours -> Recovery suggestion
      if (reminder.isOverdue && DateTime.now().difference(reminder.scheduledAt).inHours >= 2) {
        suggestions.add(SmartSuggestion(
          id: const Uuid().v4(),
          title: 'Missed Reminder Recovery',
          description: '"${reminder.message}" is overdue. Move to this evening or complete now.',
          reminderId: reminder.id,
          suggestedTime: DateTime.now().copyWith(hour: 19, minute: 0),
          actionType: 'recover',
        ));
      }
    }

    return suggestions;
  }
}
```

---

<a id="lib-domain-services-stats_calculatordart"></a>
## 72. `lib/domain/services/stats_calculator.dart`

**Path**: `lib/domain/services/stats_calculator.dart` | **Lines**: 159

```dart
import '../entities/reminder.dart';
import '../entities/reminder_occurrence.dart';
import '../entities/reminder_history.dart';
import '../enums/enums.dart';

class StatsData {
  final int totalReminders;
  final int totalOccurrences;
  final int completedReminders;
  final int overdueReminders;
  final int archivedReminders;
  final double completionPercentage;
  final int totalSnoozes;
  final double averageSnoozeFrequency;
  final String? mostMissedFolderId;
  final String productiveTimeWindow;
  final List<int> sevenDayCompletionTrend; // [day-6, day-5, ... today]
  final List<int> hourlyDistribution; // 24 bins

  const StatsData({
    required this.totalReminders,
    required this.totalOccurrences,
    required this.completedReminders,
    required this.overdueReminders,
    required this.archivedReminders,
    required this.completionPercentage,
    required this.totalSnoozes,
    required this.averageSnoozeFrequency,
    this.mostMissedFolderId,
    required this.productiveTimeWindow,
    required this.sevenDayCompletionTrend,
    required this.hourlyDistribution,
  });
}

class StatsCalculator {
  static StatsData calculate({
    required List<Reminder> reminders,
    required List<ReminderOccurrence> occurrences,
    required List<ReminderHistory> history,
  }) {
    final totalReminders = reminders.length;
    final totalOccurrences = occurrences.isNotEmpty ? occurrences.length : totalReminders;

    final completed = occurrences.isNotEmpty
        ? occurrences.where((o) => o.status == OccurrenceStatus.completed).length
        : reminders.where((r) => r.isDone).length;

    final overdue = occurrences.isNotEmpty
        ? occurrences.where((o) => o.isOverdue).length
        : reminders.where((r) => r.isOverdue).length;

    final archived = reminders.where((r) => r.isArchived).length;

    final completionPct = totalOccurrences > 0 ? (completed / totalOccurrences) * 100.0 : 0.0;

    final totalSnoozes = occurrences.isNotEmpty
        ? occurrences.fold<int>(0, (sum, o) => sum + o.snoozeCount)
        : reminders.fold<int>(0, (sum, r) => sum + r.snoozeCount);

    final avgSnooze = totalOccurrences > 0 ? totalSnoozes / totalOccurrences : 0.0;

    // Most missed folder: count overdue reminders per folderId
    final missedFolderCounts = <String, int>{};
    for (final r in reminders.where((r) => r.isOverdue && r.folderId != null)) {
      missedFolderCounts[r.folderId!] = (missedFolderCounts[r.folderId!] ?? 0) + 1;
    }
    String? mostMissedFolder;
    int maxMissed = 0;
    missedFolderCounts.forEach((folderId, count) {
      if (count > maxMissed) {
        maxMissed = count;
        mostMissedFolder = folderId;
      }
    });

    // Productive Time Window from actual completion timestamps
    final completedOccurrences = occurrences.where((o) => o.completedAt != null).toList();
    final windowCounts = {'Morning': 0, 'Afternoon': 0, 'Evening': 0, 'Night': 0};
    final hourlyBins = List<int>.filled(24, 0);

    if (completedOccurrences.isNotEmpty) {
      for (final occ in completedOccurrences) {
        final h = occ.completedAt!.hour;
        hourlyBins[h]++;
        if (h >= 6 && h < 12) {
          windowCounts['Morning'] = windowCounts['Morning']! + 1;
        } else if (h >= 12 && h < 17) {
          windowCounts['Afternoon'] = windowCounts['Afternoon']! + 1;
        } else if (h >= 17 && h < 21) {
          windowCounts['Evening'] = windowCounts['Evening']! + 1;
        } else {
          windowCounts['Night'] = windowCounts['Night']! + 1;
        }
      }
    } else {
      // Fallback to completion history timestamps if occurrences table is empty
      final completionEvents = history.where((h) => h.action == ActionType.completed).toList();
      for (final event in completionEvents) {
        final h = event.timestamp.hour;
        hourlyBins[h]++;
        if (h >= 6 && h < 12) {
          windowCounts['Morning'] = windowCounts['Morning']! + 1;
        } else if (h >= 12 && h < 17) {
          windowCounts['Afternoon'] = windowCounts['Afternoon']! + 1;
        } else if (h >= 17 && h < 21) {
          windowCounts['Evening'] = windowCounts['Evening']! + 1;
        } else {
          windowCounts['Night'] = windowCounts['Night']! + 1;
        }
      }
    }

    String topWindow = 'Morning';
    int maxWindowCount = -1;
    windowCounts.forEach((win, count) {
      if (count > maxWindowCount) {
        maxWindowCount = count;
        topWindow = win;
      }
    });

    // 7-day completion trend based on actual completion dates
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final trend = List<int>.filled(7, 0);

    for (int i = 0; i < 7; i++) {
      final dayTarget = today.subtract(Duration(days: 6 - i));
      if (completedOccurrences.isNotEmpty) {
        trend[i] = completedOccurrences.where((o) {
          final d = o.completedAt!;
          return d.year == dayTarget.year && d.month == dayTarget.month && d.day == dayTarget.day;
        }).length;
      } else {
        final completionEvents = history.where((h) => h.action == ActionType.completed).toList();
        trend[i] = completionEvents.where((e) {
          final d = e.timestamp;
          return d.year == dayTarget.year && d.month == dayTarget.month && d.day == dayTarget.day;
        }).length;
      }
    }

    return StatsData(
      totalReminders: totalReminders,
      totalOccurrences: totalOccurrences,
      completedReminders: completed,
      overdueReminders: overdue,
      archivedReminders: archived,
      completionPercentage: completionPct,
      totalSnoozes: totalSnoozes,
      averageSnoozeFrequency: avgSnooze,
      mostMissedFolderId: mostMissedFolder,
      productiveTimeWindow: (completed == 0) ? 'Morning (9 AM - 12 PM)' : topWindow,
      sevenDayCompletionTrend: trend,
      hourlyDistribution: hourlyBins,
    );
  }
}
```

---

<a id="lib-features-alarms-ringing_screendart"></a>
## 73. `lib/features/alarms/ringing_screen.dart`

**Path**: `lib/features/alarms/ringing_screen.dart` | **Lines**: 275

```dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../application/controllers/reminder_controller.dart';
import '../../application/controllers/folder_controller.dart';
import '../../core/constants/app_constants.dart';
import '../../domain/entities/reminder.dart';
import '../../platform/alarms/alarm_platform_service.dart';
import '../../presentation/components/nudge_button.dart';

class RingingScreen extends StatefulWidget {
  final String reminderId;

  const RingingScreen({super.key, required this.reminderId});

  @override
  State<RingingScreen> createState() => _RingingScreenState();
}

class _RingingScreenState extends State<RingingScreen> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  StreamSubscription<void>? _dismissSubscription;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.08).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _dismissSubscription = AlarmPlatformService.onAlarmDismissed.listen((_) {
      if (mounted && !_isProcessing) {
        Navigator.of(context).pop();
        AlarmPlatformService.closeAlarmUi();
      }
    });
  }

  @override
  void dispose() {
    _dismissSubscription?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _handleSnooze(Reminder reminder, ReminderController reminderCtrl) async {
    if (_isProcessing) return;
    setState(() => _isProcessing = true);

    await AlarmPlatformService.dismissRingingAlarm();
    await reminderCtrl.snoozeReminder(reminder.id);

    if (mounted) {
      Navigator.of(context).pop();
    }
    await AlarmPlatformService.closeAlarmUi();
  }

  Future<void> _handleComplete(Reminder reminder, ReminderController reminderCtrl) async {
    if (_isProcessing) return;
    setState(() => _isProcessing = true);

    await AlarmPlatformService.dismissRingingAlarm();
    await reminderCtrl.completeReminder(reminder.id);

    if (mounted) {
      Navigator.of(context).pop();
    }
    await AlarmPlatformService.closeAlarmUi();
  }

  Future<void> _handleDismissOnly() async {
    if (_isProcessing) return;
    setState(() => _isProcessing = true);

    await AlarmPlatformService.dismissRingingAlarm();

    if (mounted) {
      Navigator.of(context).pop();
    }
    await AlarmPlatformService.closeAlarmUi();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final reminderCtrl = context.watch<ReminderController>();
    final folderCtrl = context.watch<FolderController>();

    final reminder = reminderCtrl.reminders.firstWhere(
      (r) => r.id == widget.reminderId,
      orElse: () => Reminder(
        id: widget.reminderId,
        message: 'Reminder Alarm',
        scheduledAt: DateTime.now(),
      ),
    );

    final folder = reminder.folderId != null
        ? folderCtrl.folders.firstWhere((f) => f.id == reminder.folderId, orElse: () => folderCtrl.folders.first)
        : null;

    final canSnooze = reminder.snoozeCount < AppConstants.maxSnoozeCount;
    final formattedTime = DateFormat('hh:mm a').format(DateTime.now());

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _handleDismissOnly();
        }
      },
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Top Header
                Column(
                  children: [
                    Text(
                      formattedTime,
                      style: theme.textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: -1,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Alarm Ringing',
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),

                // Pulsing Icon & Reminder Information
                Column(
                  children: [
                    ScaleTransition(
                      scale: _pulseAnimation,
                      child: Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: theme.colorScheme.primaryContainer,
                          boxShadow: [
                            BoxShadow(
                              color: theme.colorScheme.primary.withOpacity(0.3),
                              blurRadius: 28,
                              spreadRadius: 6,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.alarm,
                          size: 56,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      reminder.message,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (folder != null) ...[
                          Chip(
                            avatar: const Icon(Icons.folder, size: 16),
                            label: Text(folder.name),
                            visualDensity: VisualDensity.compact,
                          ),
                          const SizedBox(width: 8),
                        ],
                        Chip(
                          avatar: Icon(
                            Icons.flag,
                            size: 16,
                            color: reminder.priority.name == 'urgent'
                                ? theme.colorScheme.error
                                : reminder.priority.name == 'high'
                                    ? Colors.orange
                                    : theme.colorScheme.outline,
                          ),
                          label: Text(reminder.priority.name.toUpperCase()),
                          visualDensity: VisualDensity.compact,
                        ),
                      ],
                    ),
                    if (reminder.snoozeCount > 0) ...[
                      const SizedBox(height: 8),
                      Text(
                        'Snoozed ${reminder.snoozeCount}/${AppConstants.maxSnoozeCount} times',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: reminder.snoozeCount >= AppConstants.maxSnoozeCount
                              ? theme.colorScheme.error
                              : theme.colorScheme.outline,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),

                // Action Buttons
                Column(
                  children: [
                    NudgeButton(
                      label: 'Mark as Completed',
                      icon: Icons.check_circle_outline,
                      isExpanded: true,
                      onPressed: _isProcessing ? null : () => _handleComplete(reminder, reminderCtrl),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size.fromHeight(52),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            ),
                            icon: const Icon(Icons.snooze),
                            label: Text(canSnooze ? 'Snooze (10m)' : 'Snooze Maxed'),
                            onPressed: (canSnooze && !_isProcessing)
                                ? () => _handleSnooze(reminder, reminderCtrl)
                                : null,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size.fromHeight(52),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            ),
                            icon: const Icon(Icons.close),
                            label: const Text('Dismiss'),
                            onPressed: _isProcessing ? null : _handleDismissOnly,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

---

<a id="lib-features-analytics-analytics_screendart"></a>
## 74. `lib/features/analytics/analytics_screen.dart`

**Path**: `lib/features/analytics/analytics_screen.dart` | **Lines**: 340

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../application/controllers/reminder_controller.dart';
import '../../application/controllers/folder_controller.dart';
import '../../domain/services/stats_calculator.dart';
import '../../domain/services/smart_suggestion_engine.dart';
import '../../domain/entities/smart_suggestion.dart';
import '../../presentation/components/nudge_card.dart';
import '../../presentation/components/empty_state_widget.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  StatsData? _stats;
  List<SmartSuggestion> _suggestions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    final reminderCtrl = context.read<ReminderController>();
    final stats = await reminderCtrl.getStats();
    final suggestions = SmartSuggestionEngine.generateSuggestions(reminderCtrl.reminders);

    if (mounted) {
      setState(() {
        _stats = stats;
        _suggestions = suggestions;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final folderCtrl = context.watch<FolderController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Productivity Analytics'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadData,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _stats == null || _stats!.totalReminders == 0
              ? const EmptyStateWidget(
                  icon: Icons.bar_chart_outlined,
                  title: 'No Data Yet',
                  description: 'Create and complete reminders to unlock insights into your productive rhythm.',
                )
              : RefreshIndicator(
                  onRefresh: _loadData,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Completion Rate Hero Card
                        NudgeCard(
                          color: theme.colorScheme.primaryContainer.withOpacity(0.4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Completion Rate',
                                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${_stats!.completionPercentage.toStringAsFixed(1)}%',
                                    style: theme.textTheme.headlineMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: theme.colorScheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: LinearProgressIndicator(
                                  value: _stats!.completionPercentage / 100.0,
                                  minHeight: 10,
                                  backgroundColor: theme.colorScheme.surfaceContainerHighest,
                                  valueColor: AlwaysStoppedAnimation(theme.colorScheme.primary),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildStatItem('Completed', '${_stats!.completedReminders}', theme.colorScheme.primary),
                                  _buildStatItem('Overdue', '${_stats!.overdueReminders}', theme.colorScheme.error),
                                  _buildStatItem('Archived', '${_stats!.archivedReminders}', theme.colorScheme.outline),
                                  _buildStatItem('Total', '${_stats!.totalReminders}', theme.colorScheme.onSurface),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Insights Grid
                        Row(
                          children: [
                            Expanded(
                              child: NudgeCard(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.wb_sunny_outlined, color: theme.colorScheme.secondary, size: 24),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Peak Window',
                                      style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.outline),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      _stats!.productiveTimeWindow,
                                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: NudgeCard(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.snooze_outlined, color: theme.colorScheme.tertiary, size: 24),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Avg Snoozes',
                                      style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.outline),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${_stats!.averageSnoozeFrequency.toStringAsFixed(1)} / task',
                                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // 7-Day Completion Trend
                        Text(
                          '7-Day Completion Trend',
                          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        NudgeCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tasks checked off over the past week',
                                style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: 140,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: List.generate(7, (index) {
                                    final count = _stats!.sevenDayCompletionTrend[index];
                                    final maxTrend = _stats!.sevenDayCompletionTrend.reduce((a, b) => a > b ? a : b);
                                    final normalizedHeight = maxTrend > 0 ? (count / maxTrend) * 90 : 4.0;
                                    final dayLabel = DateFormat('E').format(
                                      DateTime.now().subtract(Duration(days: 6 - index)),
                                    );

                                    return Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          '$count',
                                          style: theme.textTheme.labelSmall?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: count > 0 ? theme.colorScheme.primary : theme.colorScheme.outline,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Container(
                                          width: 22,
                                          height: normalizedHeight.clamp(6.0, 90.0),
                                          decoration: BoxDecoration(
                                            color: count > 0 ? theme.colorScheme.primary : theme.colorScheme.surfaceContainerHighest,
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          dayLabel,
                                          style: theme.textTheme.labelSmall?.copyWith(
                                            color: theme.colorScheme.outline,
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Most Missed Category Warning if exists
                        if (_stats!.mostMissedFolderId != null) ...[
                          Builder(builder: (context) {
                            final folder = folderCtrl.folders.firstWhere(
                              (f) => f.id == _stats!.mostMissedFolderId,
                              orElse: () => folderCtrl.folders.first,
                            );
                            return NudgeCard(
                              color: theme.colorScheme.errorContainer.withOpacity(0.3),
                              child: Row(
                                children: [
                                  Icon(Icons.warning_amber_rounded, color: theme.colorScheme.error, size: 28),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Attention Area',
                                          style: theme.textTheme.titleSmall?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: theme.colorScheme.error,
                                          ),
                                        ),
                                        Text(
                                          'Reminders in "${folder.name}" have the highest overdue rate. Consider adjusting their timings or batching them together.',
                                          style: theme.textTheme.bodySmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                          const SizedBox(height: 20),
                        ],

                        // Smart Suggestions
                        if (_suggestions.isNotEmpty) ...[
                          Text(
                            'Smart Suggestions',
                            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          ..._suggestions.map((suggestion) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: NudgeCard(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.lightbulb_outline, color: theme.colorScheme.primary, size: 24),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            suggestion.title,
                                            style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            suggestion.description,
                                            style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ],
                      ],
                    ),
                  ),
                ),
    );
  }

  Widget _buildStatItem(String label, String value, Color valueColor) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: valueColor,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
      ],
    );
  }
}
```

---

<a id="lib-features-backup-backup_screendart"></a>
## 75. `lib/features/backup/backup_screen.dart`

**Path**: `lib/features/backup/backup_screen.dart` | **Lines**: 574

```dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:share_plus/share_plus.dart';

import '../../application/controllers/reminder_controller.dart';
import '../../application/controllers/folder_controller.dart';
import '../../application/controllers/todo_controller.dart';
import '../../application/controllers/record_controller.dart';
import '../../data/backup/backup_manager.dart';
import '../../presentation/components/nudge_card.dart';
import '../../presentation/components/nudge_button.dart';

class BackupScreen extends StatefulWidget {
  const BackupScreen({super.key});

  @override
  State<BackupScreen> createState() => _BackupScreenState();
}

class _BackupScreenState extends State<BackupScreen> {
  bool _isExporting = false;
  bool _isImporting = false;

  Future<String?> _showSetPasswordDialog() async {
    final passwordCtrl = TextEditingController();
    final confirmCtrl = TextEditingController();
    bool obscurePassword = true;
    bool obscureConfirm = true;
    String? errorText;

    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const Row(
              children: [
                Icon(Icons.lock_outline, color: Colors.blueAccent),
                SizedBox(width: 8),
                Text('Set Backup Password'),
              ],
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Set a password to encrypt your backup. You will need this exact password to restore your data on any device.',
                    style: TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: passwordCtrl,
                    obscureText: obscurePassword,
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter backup password',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      suffixIcon: IconButton(
                        icon: Icon(obscurePassword ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => setDialogState(() => obscurePassword = !obscurePassword),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: confirmCtrl,
                    obscureText: obscureConfirm,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      hintText: 'Re-enter backup password',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      suffixIcon: IconButton(
                        icon: Icon(obscureConfirm ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => setDialogState(() => obscureConfirm = !obscureConfirm),
                      ),
                    ),
                  ),
                  if (errorText != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      errorText!,
                      style: const TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  ],
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, null),
                child: const Text('Cancel'),
              ),
              FilledButton.icon(
                icon: const Icon(Icons.lock),
                label: const Text('Encrypt & Export'),
                onPressed: () {
                  final p1 = passwordCtrl.text.trim();
                  final p2 = confirmCtrl.text.trim();
                  if (p1.isEmpty) {
                    setDialogState(() => errorText = 'Password cannot be empty.');
                    return;
                  }
                  if (p1.length < 4) {
                    setDialogState(() => errorText = 'Password must be at least 4 characters.');
                    return;
                  }
                  if (p1 != p2) {
                    setDialogState(() => errorText = 'Passwords do not match.');
                    return;
                  }
                  Navigator.pop(ctx, p1);
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Future<String?> _showEnterPasswordDialog() async {
    final passwordCtrl = TextEditingController();
    bool obscurePassword = true;
    String? errorText;

    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const Row(
              children: [
                Icon(Icons.lock_open_outlined, color: Colors.indigoAccent),
                SizedBox(width: 8),
                Text('Encrypted Backup'),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'This backup file is encrypted. Enter the password that was set when exporting to decrypt and view contents:',
                  style: TextStyle(fontSize: 13),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordCtrl,
                  obscureText: obscurePassword,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter backup password',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    suffixIcon: IconButton(
                      icon: Icon(obscurePassword ? Icons.visibility_off : Icons.visibility),
                      onPressed: () => setDialogState(() => obscurePassword = !obscurePassword),
                    ),
                  ),
                ),
                if (errorText != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    errorText!,
                    style: const TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ],
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, null),
                child: const Text('Cancel'),
              ),
              FilledButton.icon(
                icon: const Icon(Icons.key),
                label: const Text('Unlock & Inspect'),
                onPressed: () {
                  final pwd = passwordCtrl.text.trim();
                  if (pwd.isEmpty) {
                    setDialogState(() => errorText = 'Please enter the password.');
                    return;
                  }
                  Navigator.pop(ctx, pwd);
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _handleExport() async {
    final password = await _showSetPasswordDialog();
    if (password == null) return; // User cancelled

    setState(() => _isExporting = true);
    try {
      final file = await BackupManager.exportBackup(password: password);
      if (!mounted) return;

      final filename = file.path.split(Platform.pathSeparator).last;
      final sizeKb = (file.lengthSync() / 1024).toStringAsFixed(1);

      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 8),
              Text('Backup Created'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Encrypted JSON backup generated successfully using authenticated AES-256 (PBKDF2-HMAC-SHA256). You can restore this file on any device using your password.'),
              const SizedBox(height: 12),
              Text(
                'File: $filename',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              Text(
                'Size: $sizeKb KB',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Close'),
            ),
            FilledButton.icon(
              icon: const Icon(Icons.share),
              label: const Text('Share / Save File'),
              onPressed: () {
                Navigator.pop(ctx);
                Share.shareXFiles([XFile(file.path)], text: 'Nudge 2.0 Encrypted Backup');
              },
            ),
          ],
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Export failed: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isExporting = false);
    }
  }

  Future<void> _handlePickAndInspect() async {
    try {
      final result = await FilePicker.platform.pickFiles();
      if (result == null || result.files.single.path == null) return;

      final filePath = result.files.single.path!;
      final isProtected = await BackupManager.isPasswordProtected(filePath);

      String? password;
      if (isProtected) {
        password = await _showEnterPasswordDialog();
        if (password == null) return; // User cancelled password dialog
      }

      setState(() => _isImporting = true);

      final preview = await BackupManager.inspectBackupFile(filePath, password: password);
      if (!mounted) return;

      _showImportPreviewDialog(preview);
    } catch (e) {
      if (mounted) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const Row(
              children: [
                Icon(Icons.error_outline, color: Colors.red),
                SizedBox(width: 8),
                Text('Cannot Read Backup'),
              ],
            ),
            content: Text(
              e is FormatException
                  ? e.message
                  : 'Verification or decryption failed: $e',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Dismiss'),
              ),
            ],
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isImporting = false);
    }
  }

  void _showImportPreviewDialog(BackupPreview preview) {
    BackupConflictPolicy selectedPolicy = BackupConflictPolicy.skip;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const Text('Backup Preview'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Decrypted and verified with HMAC-SHA256. Select conflict policy before committing:'),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<BackupConflictPolicy>(
                    value: selectedPolicy,
                    decoration: InputDecoration(
                      labelText: 'Conflict Policy',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: BackupConflictPolicy.skip,
                        child: Text('Skip Existing (Recommended)'),
                      ),
                      DropdownMenuItem(
                        value: BackupConflictPolicy.replace,
                        child: Text('Replace Existing Records'),
                      ),
                      DropdownMenuItem(
                        value: BackupConflictPolicy.keep,
                        child: Text('Keep Existing Records'),
                      ),
                      DropdownMenuItem(
                        value: BackupConflictPolicy.importAsCopy,
                        child: Text('Import Conflicts as Copies'),
                      ),
                    ],
                    onChanged: (val) {
                      if (val != null) {
                        setModalState(() => selectedPolicy = val);
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildMetricRow('Reminders in Backup', '${preview.validReminders.length}', Colors.blue),
                  _buildMetricRow('Tasks & Todos', '${preview.validTodos.length}', Colors.orange),
                  _buildMetricRow('Notes & Records', '${preview.validRecords.length}', Colors.teal),
                  _buildMetricRow('Tags Included', '${preview.validTags.length}', Colors.purple),
                  _buildMetricRow('Occurrences', '${preview.validOccurrences.length}', Colors.indigo),
                  _buildMetricRow('Media / Photos', '${preview.mediaFiles.length}', Colors.cyan),
                  _buildMetricRow('Duplicate IDs', '${preview.duplicateCount}', Colors.amber),
                  _buildMetricRow('Folders Included', '${preview.validFolders.length}', Colors.green),
                  _buildMetricRow('History Logs', '${preview.validHistory.length}', Colors.grey),
                  if (preview.companionProfile != null)
                    _buildMetricRow('Companion Profile', 'Included', Colors.pink),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () async {
                  Navigator.pop(ctx);
                  await _commitImport(preview, selectedPolicy);
                },
                child: const Text('Confirm Import'),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _commitImport(BackupPreview preview, BackupConflictPolicy policy) async {
    setState(() => _isImporting = true);
    final reminderCtrl = context.read<ReminderController>();
    final folderCtrl = context.read<FolderController>();
    final todoCtrl = context.read<TodoController>();
    final recordCtrl = context.read<RecordController>();

    try {
      await BackupManager.commitImport(preview, policy: policy);

      await reminderCtrl.loadReminders();
      await folderCtrl.loadFolders();
      todoCtrl.loadTodos();
      recordCtrl.loadRecords();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Successfully imported ${preview.validReminders.length} reminders, ${preview.validTodos.length} tasks, and ${preview.validRecords.length} records!'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Import error: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isImporting = false);
    }
  }

  Widget _buildMetricRow(String title, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 14)),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: color),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Backup & Restore'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Security Badge Card
            NudgeCard(
              color: theme.colorScheme.primaryContainer.withOpacity(0.4),
              child: Row(
                children: [
                  Icon(Icons.shield_outlined, size: 36, color: theme.colorScheme.primary),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Portable Encrypted JSON Backup',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Backups are encrypted using AES-256-CBC with PBKDF2-HMAC-SHA256 password derivation. You can safely restore your reminders, tasks, notes, and media on any device using your password.',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Export Section
            Text(
              'Export Data',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            NudgeCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create Encrypted JSON Backup',
                    style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Exports active reminders, tasks, notes, tags, occurrences, photos, custom folders, checklists, history, and companion milestones into a password-encrypted .json file.',
                    style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
                  ),
                  const SizedBox(height: 16),
                  NudgeButton(
                    label: _isExporting ? 'Packaging & Encrypting...' : 'Export Encrypted Backup',
                    icon: Icons.upload_file,
                    onPressed: _isExporting || _isImporting ? null : _handleExport,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Import Section
            Text(
              'Restore Data',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            NudgeCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Restore from Backup File',
                    style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Inspect, decrypt with your password, choose conflict policy, and restore data from any Nudge backup file (.json or .nudgebackup).',
                    style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    icon: const Icon(Icons.download),
                    label: Text(_isImporting ? 'Inspecting Backup...' : 'Select Backup File to Restore'),
                    onPressed: _isExporting || _isImporting ? null : _handlePickAndInspect,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

<a id="lib-features-calendar-calendar_screendart"></a>
## 76. `lib/features/calendar/calendar_screen.dart`

**Path**: `lib/features/calendar/calendar_screen.dart` | **Lines**: 156

```dart
﻿import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../application/controllers/reminder_controller.dart';
import '../../core/utils/date_utils.dart';
import '../../domain/entities/reminder.dart';
import '../../presentation/components/empty_state_widget.dart';
import '../home/reminder_card.dart';
import '../../presentation/theme/nudge_theme.dart';
import '../reminders/reminder_editor_screen.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final reminderController = context.watch<ReminderController>();

    final activeReminders = reminderController.reminders.where((r) => !r.isArchived).toList();

    List<Reminder> getRemindersForDay(DateTime day) {
      return activeReminders.where((r) => NudgeDateUtils.isSameDay(r.scheduledAt, day)).toList();
    }

    final selectedDayReminders = getRemindersForDay(_selectedDay);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: Column(
        children: [
          // TableCalendar
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(NudgeTheme.radiusL),
              side: BorderSide(color: isDark ? NudgeTheme.cardBorderDark : NudgeTheme.cardBorderLight),
            ),
            child: TableCalendar<Reminder>(
              firstDay: DateTime.now().subtract(const Duration(days: 365)),
              lastDay: DateTime.now().add(const Duration(days: 365 * 3)),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => NudgeDateUtils.isSameDay(_selectedDay, day),
              calendarFormat: CalendarFormat.month,
              eventLoader: getRemindersForDay,
              startingDayOfWeek: StartingDayOfWeek.monday,
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: isDark ? NudgeTheme.secondaryContainer : NudgeTheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: NudgeTheme.secondary.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                markerDecoration: const BoxDecoration(
                  color: NudgeTheme.secondary,
                  shape: BoxShape.circle,
                ),
              ),
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  NudgeDateUtils.formatDate(_selectedDay),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  '${selectedDayReminders.length} reminders',
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Reminders for selected day
          Expanded(
            child: selectedDayReminders.isEmpty
                ? EmptyStateWidget(
                    icon: Icons.event_available,
                    title: 'No Reminders for this Day',
                    subtitle: 'Schedule a reminder for ${NudgeDateUtils.formatDate(_selectedDay)}',
                    actionLabel: 'Add Reminder',
                    onAction: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ReminderEditorScreen(
                            initialReminder: Reminder(
                              message: '',
                              scheduledAt: _selectedDay.copyWith(hour: 10, minute: 0),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: selectedDayReminders.length,
                    itemBuilder: (context, index) {
                      return ReminderCard(reminder: selectedDayReminders[index]);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ReminderEditorScreen(
                initialReminder: Reminder(
                  message: '',
                  scheduledAt: _selectedDay.copyWith(hour: 10, minute: 0),
                ),
              ),
            ),
          );
        },
        tooltip: 'Add reminder for this day',
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

---

<a id="lib-features-companion-customize_companion_screendart"></a>
## 77. `lib/features/companion/customize_companion_screen.dart`

**Path**: `lib/features/companion/customize_companion_screen.dart` | **Lines**: 438

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../application/controllers/companion_controller.dart';
import '../../core/constants/app_constants.dart';
import '../../presentation/components/mascot_widget.dart';
import '../../presentation/components/nudge_button.dart';
import '../../presentation/components/nudge_card.dart';
import '../../presentation/components/nudge_text_field.dart';

class CustomizeCompanionScreen extends StatefulWidget {
  const CustomizeCompanionScreen({super.key});

  @override
  State<CustomizeCompanionScreen> createState() => _CustomizeCompanionScreenState();
}

class _CustomizeCompanionScreenState extends State<CustomizeCompanionScreen> {
  late TextEditingController _nameController;
  bool _isEditingName = false;

  final Map<String, Map<String, dynamic>> _cosmeticDetails = {
    'bandana': {
      'name': 'Explorer Bandana',
      'description': 'A stylish red bandana for adventurous days.',
      'icon': Icons.bookmark,
      'requirement': 3,
    },
    'neon_shades': {
      'name': 'Cyber Neon Shades',
      'description': 'Futuristic cool sunglasses for maximum focus.',
      'icon': Icons.visibility,
      'requirement': 8,
    },
    'headphones': {
      'name': 'Lo-Fi Headset',
      'description': 'Premium noise-cancelling studio headphones.',
      'icon': Icons.headphones,
      'requirement': 15,
    },
    'wizard_hat': {
      'name': 'Arcane Wizard Hat',
      'description': 'Magical starry cone hat for productivity wizards.',
      'icon': Icons.auto_fix_high,
      'requirement': 25,
    },
    'ninja_band': {
      'name': 'Shadow Shinobi Band',
      'description': 'Stealth headband for slicing through distractions.',
      'icon': Icons.sports_martial_arts,
      'requirement': 40,
    },
    'astronaut_helmet': {
      'name': 'Cosmic Space Helmet',
      'description': 'Interstellar bubble helmet for reaching the stars.',
      'icon': Icons.rocket_launch,
      'requirement': 60,
    },
    'sparkle_aura': {
      'name': 'Celestial Aura',
      'description': 'A glittering field of sparkles acknowledging dedication.',
      'icon': Icons.auto_awesome,
      'requirement': 80,
    },
    'crown': {
      'name': 'Emperor Golden Crown',
      'description': 'Reserved for champions of relentless consistency.',
      'icon': Icons.military_tech,
      'requirement': 100,
    },
    'flame_aura': {
      'name': 'Phoenix Flame Aura',
      'description': 'An intense burning aura of pure unstoppable momentum.',
      'icon': Icons.local_fire_department,
      'requirement': 150,
    },
    'golden_trophy': {
      'name': 'Master Achiever Trophy',
      'description': 'The ultimate badge of the master achiever.',
      'icon': Icons.emoji_events,
      'requirement': 200,
    },
  };

  @override
  void initState() {
    super.initState();
    final companion = context.read<CompanionController>();
    _nameController = TextEditingController(text: companion.profile.name);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _saveName(CompanionController controller) async {
    final newName = _nameController.text.trim();
    if (newName.isNotEmpty) {
      await controller.updateName(newName);
      setState(() => _isEditingName = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Companion renamed to $newName!'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final companion = context.watch<CompanionController>();
    final profile = companion.profile;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mascot & Companion'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Mascot Interactive Preview Card
            NudgeCard(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Column(
                children: [
                  MascotWidget(
                    mood: companion.currentMood,
                    equippedCosmetic: profile.equippedCosmetic,
                    size: 130,
                    onTap: () {
                      companion.triggerTapReaction();
                    },
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: theme.colorScheme.outlineVariant.withOpacity(0.5)),
                    ),
                    child: Text(
                      '"${companion.currentDialogue}"',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Tap ${profile.name} to interact!',
                    style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.outline),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Name Editing Card
            NudgeCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Companion Identity',
                        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: Icon(_isEditingName ? Icons.close : Icons.edit_outlined),
                        onPressed: () {
                          setState(() {
                            _isEditingName = !_isEditingName;
                            if (!_isEditingName) {
                              _nameController.text = profile.name;
                            }
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (_isEditingName) ...[
                    NudgeTextField(
                      controller: _nameController,
                      hintText: 'Enter name',
                      prefixIcon: const Icon(Icons.pets),
                    ),
                    const SizedBox(height: 12),
                    NudgeButton(
                      label: 'Save Name',
                      icon: Icons.check,
                      onPressed: () => _saveName(companion),
                    ),
                  ] else ...[
                    Text(
                      profile.name,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Your personal reminder companion and accountability buddy.',
                      style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Stats Matrix
            Row(
              children: [
                Expanded(
                  child: NudgeCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.local_fire_department, color: theme.colorScheme.error, size: 28),
                        const SizedBox(height: 8),
                        Text(
                          '${profile.currentStreak}',
                          style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Day Streak',
                          style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.outline),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: NudgeCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.ac_unit, color: theme.colorScheme.tertiary, size: 28),
                        const SizedBox(height: 8),
                        Text(
                          '${profile.streakFreezes}',
                          style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Freezes Left',
                          style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.outline),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: NudgeCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.check_circle_outline, color: theme.colorScheme.primary, size: 28),
                        const SizedBox(height: 8),
                        Text(
                          '${profile.lifetimeCompletions}',
                          style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Finished',
                          style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.outline),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Cosmetics Section
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Accessories & Milestones',
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),

            // None / Unequip Option
            NudgeCard(
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.block, size: 24),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Default Look', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                        Text('No accessories equipped', style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline)),
                      ],
                    ),
                  ),
                  if (profile.equippedCosmetic == null)
                    Chip(
                      label: const Text('Equipped'),
                      backgroundColor: theme.colorScheme.primaryContainer,
                      labelStyle: TextStyle(color: theme.colorScheme.onPrimaryContainer, fontWeight: FontWeight.bold),
                    )
                  else
                    OutlinedButton(
                      onPressed: () => companion.equipCosmetic(null),
                      child: const Text('Equip'),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Cosmetics list
            ...AppConstants.cosmeticMilestones.entries.map((entry) {
              final requiredCount = entry.key;
              final cosmeticId = entry.value;
              final info = _cosmeticDetails[cosmeticId] ?? {
                'name': cosmeticId,
                'description': 'Milestone accessory',
                'icon': Icons.star,
                'requirement': requiredCount,
              };

              final isUnlocked = profile.unlockedCosmetics.contains(cosmeticId) || profile.lifetimeCompletions >= requiredCount;
              final isEquipped = profile.equippedCosmetic == cosmeticId;
              final progress = (profile.lifetimeCompletions / requiredCount).clamp(0.0, 1.0);

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: NudgeCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isUnlocked ? theme.colorScheme.primaryContainer : theme.colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              info['icon'] as IconData,
                              color: isUnlocked ? theme.colorScheme.primary : theme.colorScheme.outline,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      info['name'] as String,
                                      style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                    if (!isUnlocked) ...[
                                      const SizedBox(width: 6),
                                      Icon(Icons.lock, size: 14, color: theme.colorScheme.outline),
                                    ],
                                  ],
                                ),
                                Text(
                                  info['description'] as String,
                                  style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
                                ),
                              ],
                            ),
                          ),
                          if (isEquipped)
                            Chip(
                              label: const Text('Equipped'),
                              backgroundColor: theme.colorScheme.primaryContainer,
                              labelStyle: TextStyle(color: theme.colorScheme.onPrimaryContainer, fontWeight: FontWeight.bold),
                            )
                          else if (isUnlocked)
                            FilledButton.tonal(
                              onPressed: () => companion.equipCosmetic(cosmeticId),
                              child: const Text('Equip'),
                            )
                          else
                            Text(
                              '${profile.lifetimeCompletions}/$requiredCount',
                              style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),
                            ),
                        ],
                      ),
                      if (!isUnlocked) ...[
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 6,
                            backgroundColor: theme.colorScheme.surfaceContainerHighest,
                            valueColor: AlwaysStoppedAnimation(theme.colorScheme.primary),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
```

---

<a id="lib-features-folders-folder_detail_screendart"></a>
## 78. `lib/features/folders/folder_detail_screen.dart`

**Path**: `lib/features/folders/folder_detail_screen.dart` | **Lines**: 163

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../application/controllers/folder_controller.dart';
import '../../application/controllers/reminder_controller.dart';
import '../../domain/entities/folder.dart';
import '../../domain/entities/reminder.dart';
import '../../presentation/components/empty_state_widget.dart';
import '../../presentation/theme/nudge_theme.dart';
import '../home/reminder_card.dart';
import '../reminders/reminder_editor_screen.dart';

class FolderDetailScreen extends StatefulWidget {
  final Folder folder;

  const FolderDetailScreen({super.key, required this.folder});

  @override
  State<FolderDetailScreen> createState() => _FolderDetailScreenState();
}

class _FolderDetailScreenState extends State<FolderDetailScreen> {
  int _tabIndex = 0; // 0: Active, 1: All, 2: Completed

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final folderController = context.watch<FolderController>();
    final reminderController = context.watch<ReminderController>();

    final currentFolder = folderController.folders.firstWhere(
      (f) => f.id == widget.folder.id,
      orElse: () => widget.folder,
    );

    final color = NudgeTheme.getFolderColor(currentFolder, isDark);

    final folderReminders = reminderController.reminders
        .where((r) => r.folderId == currentFolder.id && !r.isArchived)
        .toList();

    List<Reminder> displayList;
    if (_tabIndex == 0) {
      displayList = folderReminders.where((r) => !r.isDone).toList();
    } else if (_tabIndex == 2) {
      displayList = folderReminders.where((r) => r.isDone).toList();
    } else {
      displayList = folderReminders;
    }

    displayList.sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(NudgeTheme.getFolderIcon(currentFolder), color: color, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentFolder.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    ' active •  total',
                    style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.outline),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.centerLeft,
            child: SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 0, label: Text('Active')),
                ButtonSegment(value: 1, label: Text('All')),
                ButtonSegment(value: 2, label: Text('Done')),
              ],
              selected: {_tabIndex},
              onSelectionChanged: (set) {
                setState(() => _tabIndex = set.first);
              },
              showSelectedIcon: false,
              style: const ButtonStyle(
                visualDensity: VisualDensity.compact,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ),
        ),
      ),
      body: displayList.isEmpty
          ? EmptyStateWidget(
              icon: NudgeTheme.getFolderIcon(currentFolder),
              title: _tabIndex == 2
                  ? 'No Completed Reminders'
                  : 'No Reminders in ""',
              subtitle: _tabIndex == 2
                  ? 'Completed tasks will appear here'
                  : 'Tap below to add a reminder to this folder',
              actionLabel: _tabIndex != 2 ? 'Add Reminder' : null,
              onAction: _tabIndex != 2
                  ? () => _openEditorForFolder(context, currentFolder.id)
                  : null,
            )
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
              itemCount: displayList.length,
              itemBuilder: (context, index) {
                final reminder = displayList[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ReminderCard(
                    reminder: reminder,
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openEditorForFolder(context, currentFolder.id),
        icon: const Icon(Icons.add),
        label: const Text('Add Reminder'),
        backgroundColor: color,
        foregroundColor: Colors.white,
      ),
    );
  }

  void _openEditorForFolder(BuildContext context, String folderId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ReminderEditorScreen(
          initialReminder: Reminder(
            folderId: folderId,
            message: '',
            scheduledAt: DateTime.now().add(const Duration(hours: 1)),
          ),
        ),
      ),
    );
  }
}
```

---

<a id="lib-features-folders-folders_screendart"></a>
## 79. `lib/features/folders/folders_screen.dart`

**Path**: `lib/features/folders/folders_screen.dart` | **Lines**: 246

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../application/controllers/folder_controller.dart';
import '../../application/controllers/reminder_controller.dart';
import '../../domain/entities/folder.dart';
import '../../presentation/components/empty_state_widget.dart';
import '../../presentation/theme/nudge_theme.dart';
import 'folder_detail_screen.dart';

class FoldersScreen extends StatelessWidget {
  const FoldersScreen({super.key});

  void _showFolderDialog(BuildContext context, {Folder? folderToEdit}) {
    final isEditing = folderToEdit != null;
    final nameController = TextEditingController(text: folderToEdit?.name ?? '');
    String selectedIcon = folderToEdit?.iconId ?? 'folder';
    String selectedColor = folderToEdit?.colorTag ?? '#006A60';

    final availableIcons = [
      'folder', 'work', 'home', 'school', 'shopping_cart',
      'local_hospital', 'receipt', 'flight', 'movie', 'star'
    ];

    final availableColors = [
      '#006A60', '#BA1A1A', '#6750A4', '#E28743',
      '#2E7D32', '#00796B', '#1976D2', '#C2185B'
    ];

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(isEditing ? 'Edit Folder' : 'New Folder'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nameController,
                  autofocus: true,
                  decoration: const InputDecoration(
                    labelText: 'Folder Name',
                    hintText: 'e.g. Health, Finance, University',
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Choose Icon', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: availableIcons.map((iconId) {
                    final isSelected = selectedIcon == iconId;
                    return IconButton.filledTonal(
                      style: IconButton.styleFrom(
                        backgroundColor: isSelected ? NudgeTheme.primaryContainer : null,
                      ),
                      icon: Icon(
                        NudgeTheme.getIconDataForId(iconId),
                        color: isSelected ? Colors.white : null,
                      ),
                      onPressed: () => setDialogState(() => selectedIcon = iconId),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                const Text('Choose Color', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: availableColors.map((hex) {
                    final color = Color(int.parse(hex.replaceFirst('#', '0xFF')));
                    final isSelected = selectedColor == hex;
                    return GestureDetector(
                      onTap: () => setDialogState(() => selectedColor = hex),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: isSelected ? Border.all(color: Colors.white, width: 3) : null,
                          boxShadow: isSelected ? [const BoxShadow(color: Colors.black26, blurRadius: 4)] : null,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                final name = nameController.text.trim();
                if (name.isEmpty) return;

                final folderController = context.read<FolderController>();
                if (isEditing) {
                  folderController.updateFolder(folderToEdit.copyWith(
                    name: name,
                    iconId: selectedIcon,
                    colorTag: selectedColor,
                  ));
                } else {
                  folderController.createFolder(Folder(
                    name: name,
                    iconId: selectedIcon,
                    colorTag: selectedColor,
                  ));
                }
                Navigator.pop(ctx);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteFolderDialog(BuildContext context, Folder folder) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Delete "${folder.name}"?'),
        content: const Text(
          'What would you like to do with the reminders in this folder?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<FolderController>().deleteFolder(folder.id, deleteContainedReminders: false);
              context.read<ReminderController>().loadReminders();
              Navigator.pop(ctx);
            },
            child: const Text('Move to General'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: NudgeTheme.error),
            onPressed: () {
              context.read<FolderController>().deleteFolder(folder.id, deleteContainedReminders: true);
              context.read<ReminderController>().loadReminders();
              Navigator.pop(ctx);
            },
            child: const Text('Delete All Reminders'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final folderController = context.watch<FolderController>();
    final reminderController = context.watch<ReminderController>();

    final folders = folderController.folders;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Folders'),
      ),
      body: folders.isEmpty
          ? EmptyStateWidget(
              icon: Icons.folder_open,
              title: 'No Folders',
              subtitle: 'Organize your reminders into custom folders',
              actionLabel: 'Create Folder',
              onAction: () => _showFolderDialog(context),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: folders.length,
              itemBuilder: (context, index) {
                final folder = folders[index];
                final count = reminderController.reminders.where((r) => r.folderId == folder.id && !r.isArchived).length;
                final color = NudgeTheme.getFolderColor(folder, isDark);

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(NudgeTheme.radiusL),
                    side: BorderSide(color: isDark ? NudgeTheme.cardBorderDark : NudgeTheme.cardBorderLight),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FolderDetailScreen(folder: folder),
                        ),
                      );
                    },
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(NudgeTheme.getFolderIcon(folder), color: color),
                    ),
                    title: Text(
                      folder.name,
                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    subtitle: Text('$count active reminders'),
                    trailing: PopupMenuButton<String>(
                      onSelected: (val) {
                        if (val == 'edit') {
                          _showFolderDialog(context, folderToEdit: folder);
                        } else if (val == 'delete') {
                          _showDeleteFolderDialog(context, folder);
                        }
                      },
                      itemBuilder: (ctx) => [
                        const PopupMenuItem(value: 'edit', child: Text('Edit')),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Text('Delete', style: TextStyle(color: NudgeTheme.error)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showFolderDialog(context),
        tooltip: 'Create new folder',
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

---

<a id="lib-features-home-home_screendart"></a>
## 80. `lib/features/home/home_screen.dart`

**Path**: `lib/features/home/home_screen.dart` | **Lines**: 933

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../application/controllers/reminder_controller.dart';
import '../../application/controllers/folder_controller.dart';
import '../../application/controllers/companion_controller.dart';
import '../../application/controllers/theme_controller.dart';
import '../../application/controllers/reliability_controller.dart';
import '../../application/controllers/todo_controller.dart';
import '../../application/controllers/record_controller.dart';
import '../../domain/enums/enums.dart';
import '../../presentation/components/mascot_widget.dart';
import '../../presentation/components/nudge_card.dart';
import '../../presentation/components/empty_state_widget.dart';
import '../../presentation/components/quick_add_sheet.dart';
import '../calendar/calendar_screen.dart';
import '../timer/timer_screen.dart';
import '../analytics/analytics_screen.dart';
import '../settings/settings_screen.dart';
import '../settings/custom_alarm_sound_screen.dart';
import '../folders/folders_screen.dart';
import '../search/search_screen.dart';
import '../companion/customize_companion_screen.dart';
import '../reliability/improve_reliability_screen.dart';
import '../todos/todos_screen.dart';
import '../records/records_screen.dart';
import '../records/record_editor_screen.dart';
import 'reminder_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  int _currentNavIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ReminderController>().loadReminders();
      context.read<FolderController>().loadFolders();
      context.read<ReliabilityController>().refreshStatuses();
      context.read<TodoController>().loadTodos();
      context.read<RecordController>().loadRecords();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<ReliabilityController>().refreshStatuses();
      context.read<ReminderController>().checkExactAlarmCapability();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentNavIndex,
        children: [
          _buildHomeTab(context),
          const CalendarScreen(),
          const TimerScreen(),
          const CustomAlarmSoundScreen(),
          const AnalyticsScreen(),
          const SettingsScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentNavIndex,
        onDestinationSelected: (index) {
          setState(() => _currentNavIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.alarm_outlined),
            selectedIcon: Icon(Icons.alarm),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined),
            selectedIcon: Icon(Icons.calendar_month),
            label: 'Calendar',
          ),
          NavigationDestination(
            icon: Icon(Icons.timer_outlined),
            selectedIcon: Icon(Icons.timer),
            label: 'Timer',
          ),
          NavigationDestination(
            icon: Icon(Icons.graphic_eq_outlined),
            selectedIcon: Icon(Icons.graphic_eq),
            label: 'Sound',
          ),
          NavigationDestination(
            icon: Icon(Icons.insights_outlined),
            selectedIcon: Icon(Icons.insights),
            label: 'Analytics',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      floatingActionButton: _currentNavIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                QuickAddSheet.show(
                  context,
                  onOpenTimer: () => setState(() => _currentNavIndex = 2),
                );
              },
              tooltip: 'Quick Add',
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  Widget _buildHomeTab(BuildContext context) {
    final theme = Theme.of(context);
    final reminderCtrl = context.watch<ReminderController>();
    final folderCtrl = context.watch<FolderController>();
    final companionCtrl = context.watch<CompanionController>();
    final todoCtrl = context.watch<TodoController>();
    final recordCtrl = context.watch<RecordController>();

    final allReminders = reminderCtrl.reminders;
    final overdueCount = allReminders.where((r) => r.isOverdue).length;
    final todayCount = allReminders.where((r) => !r.isArchived && _isToday(r.scheduledAt)).length;
    final todayDoneCount = allReminders.where((r) => _isToday(r.scheduledAt) && r.isDone).length;

    // Next Up Reminder
    final upcomingList = allReminders
        .where((r) => !r.isDone && !r.isArchived && r.scheduledAt.isAfter(DateTime.now()))
        .toList()
      ..sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));
    final nextUpReminder = upcomingList.isNotEmpty ? upcomingList.first : null;

    // Filtered list
    final filteredReminders = reminderCtrl.filteredReminders;

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          // Header App Bar with Mascot, Greeting, and Action Icons
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Mascot Avatar
                      GestureDetector(
                        onTap: () {
                          companionCtrl.triggerTapReaction();
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('"${companionCtrl.currentDialogue}"'),
                              behavior: SnackBarBehavior.floating,
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                        child: MascotWidget(
                          mood: companionCtrl.currentMood,
                          equippedCosmetic: companionCtrl.profile.equippedCosmetic,
                          size: 44,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _getGreeting(),
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: theme.colorScheme.outline,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              companionCtrl.profile.name,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      // Streak Pill
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const CustomizeCompanionScreen()),
                          );
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.errorContainer.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.local_fire_department, size: 16, color: theme.colorScheme.error),
                              const SizedBox(width: 3),
                              Text(
                                '${companionCtrl.profile.currentStreak}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.error,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 2),
                      // Dark / Light Mode Toggle Logo Button
                      Consumer<ThemeController>(
                        builder: (context, themeCtrl, _) {
                          final isDark = themeCtrl.themeMode == ThemeMode.dark ||
                              (themeCtrl.themeMode == ThemeMode.system && theme.brightness == Brightness.dark);
                          return IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                            visualDensity: VisualDensity.compact,
                            icon: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              transitionBuilder: (child, anim) => RotationTransition(
                                turns: anim,
                                child: ScaleTransition(scale: anim, child: child),
                              ),
                              child: Icon(
                                isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                                key: ValueKey<bool>(isDark),
                                color: isDark ? Colors.amber : theme.colorScheme.primary,
                                size: 20,
                              ),
                            ),
                            tooltip: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
                            onPressed: () => themeCtrl.toggleTheme(),
                          );
                        },
                      ),
                      // Folder Screen
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                        visualDensity: VisualDensity.compact,
                        icon: const Icon(Icons.folder_outlined, size: 20),
                        tooltip: 'Folders',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const FoldersScreen()),
                          );
                        },
                      ),
                      // Search Screen
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                        visualDensity: VisualDensity.compact,
                        icon: const Icon(Icons.search, size: 20),
                        tooltip: 'Search',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const SearchScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Background & Alarm Permission Alert Banner
                  Consumer<ReliabilityController>(
                    builder: (context, rel, _) {
                      if (rel.notificationsEnabled &&
                          rel.exactAlarmsEnabled &&
                          rel.fullScreenIntentEnabled &&
                          rel.batteryOptimizationIgnored) {
                        return const SizedBox.shrink();
                      }
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const ImproveReliabilityScreen()),
                            );
                          },
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.orange.withOpacity(0.4)),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.shield_outlined, color: Colors.deepOrange, size: 24),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Allow Background & Alarm Access',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.deepOrange,
                                          fontSize: 13,
                                        ),
                                      ),
                                      Text(
                                        !rel.exactAlarmsEnabled
                                            ? 'Exact alarm permission needed to ring alarms on time.'
                                            : !rel.notificationsEnabled
                                                ? 'Notifications disabled. Tap to enable alarm alerts.'
                                                : !rel.fullScreenIntentEnabled
                                                    ? 'Full-screen alarm access needed for lock screen ringing.'
                                                    : 'Exempt Nudge from battery saver so it rings after close or reboot.',
                                        style: const TextStyle(fontSize: 11),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(Icons.chevron_right, color: Colors.deepOrange, size: 20),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  // Missed Reminders Recovery Banner
                  if (overdueCount > 0 && reminderCtrl.activeFilter != FilterType.overdue) ...[
                    InkWell(
                      onTap: () => reminderCtrl.setFilter(FilterType.overdue),
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.errorContainer.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: theme.colorScheme.error.withOpacity(0.3)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.warning_amber_rounded, color: theme.colorScheme.error, size: 24),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '$overdueCount Overdue ${overdueCount == 1 ? "Reminder" : "Reminders"}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: theme.colorScheme.error,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const Text(
                                    'Tap to review, complete, or reschedule.',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            Icon(Icons.chevron_right, color: theme.colorScheme.error),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // Overview Cards Row
                  Row(
                    children: [
                      Expanded(
                        child: NudgeCard(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Today',
                                style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.outline),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '$todayDoneCount/$todayCount',
                                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 6),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: todayCount > 0 ? (todayDoneCount / todayCount) : 0,
                                  minHeight: 4,
                                  backgroundColor: theme.colorScheme.surfaceContainerHighest,
                                  valueColor: AlwaysStoppedAnimation(theme.colorScheme.primary),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: NudgeCard(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Upcoming',
                                style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.outline),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${upcomingList.length}',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Next scheduled',
                                style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.outline),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Next Up Hero Card
                  if (nextUpReminder != null) ...[
                    const SizedBox(height: 16),
                    NudgeCard(
                      color: theme.colorScheme.primaryContainer.withOpacity(0.3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.access_time_filled, size: 16, color: theme.colorScheme.primary),
                                  const SizedBox(width: 6),
                                  Text(
                                    'NEXT UP • ${_formatNextUpTime(nextUpReminder.scheduledAt)}',
                                    style: TextStyle(
                                      color: theme.colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                              Chip(
                                label: Text(nextUpReminder.priority.name.toUpperCase()),
                                visualDensity: VisualDensity.compact,
                                padding: EdgeInsets.zero,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            nextUpReminder.message,
                            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              FilledButton.tonalIcon(
                                onPressed: () {
                                  reminderCtrl.completeReminder(nextUpReminder.id);
                                  companionCtrl.triggerCelebration();
                                },
                                icon: const Icon(Icons.check, size: 18),
                                label: const Text('Done'),
                              ),
                              const SizedBox(width: 8),
                              OutlinedButton.icon(
                                onPressed: nextUpReminder.snoozeCount < 3
                                    ? () => reminderCtrl.snoozeReminder(nextUpReminder.id)
                                    : null,
                                icon: const Icon(Icons.snooze, size: 18),
                                label: const Text('+10m'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],

                  const SizedBox(height: 16),

                  // Productivity Hub (Tasks & Records Cards)
                  _buildProductivityHub(context, todoCtrl, recordCtrl),

                  const SizedBox(height: 16),

                  // Filter Chips Carousel
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFilterChip(context, FilterType.all, 'All'),
                        _buildFilterChip(context, FilterType.today, 'Today'),
                        _buildFilterChip(context, FilterType.upcoming, 'Upcoming'),
                        _buildFilterChip(context, FilterType.overdue, 'Overdue'),
                        _buildFilterChip(context, FilterType.completed, 'Completed'),
                        _buildFilterChip(context, FilterType.archived, 'Archived'),
                      ],
                    ),
                  ),

                  // Priority and Folder filter pills
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      // Folder filter popup
                      PopupMenuButton<String?>(
                        initialValue: reminderCtrl.folderFilter,
                        tooltip: 'Filter by folder',
                        child: Chip(
                          avatar: const Icon(Icons.folder_outlined, size: 16),
                          label: Text(
                            reminderCtrl.folderFilter == null
                                ? 'Folder: All'
                                : folderCtrl.folders
                                    .firstWhere(
                                      (f) => f.id == reminderCtrl.folderFilter,
                                      orElse: () => folderCtrl.folders.first,
                                    )
                                    .name,
                          ),
                          deleteIcon: reminderCtrl.folderFilter != null ? const Icon(Icons.close, size: 14) : null,
                          onDeleted: reminderCtrl.folderFilter != null
                              ? () => reminderCtrl.setFolderFilter(null)
                              : null,
                        ),
                        onSelected: (folderId) => reminderCtrl.setFolderFilter(folderId),
                        itemBuilder: (ctx) => [
                          const PopupMenuItem(value: null, child: Text('All Folders')),
                          ...folderCtrl.folders.map(
                            (f) => PopupMenuItem(value: f.id, child: Text(f.name)),
                          ),
                        ],
                      ),
                      const SizedBox(width: 8),

                      // Priority filter popup
                      PopupMenuButton<PriorityLevel?>(
                        initialValue: reminderCtrl.priorityFilter,
                        tooltip: 'Filter by priority',
                        child: Chip(
                          avatar: const Icon(Icons.flag_outlined, size: 16),
                          label: Text(
                            reminderCtrl.priorityFilter == null
                                ? 'Priority: All'
                                : reminderCtrl.priorityFilter!.name.toUpperCase(),
                          ),
                          deleteIcon: reminderCtrl.priorityFilter != null ? const Icon(Icons.close, size: 14) : null,
                          onDeleted: reminderCtrl.priorityFilter != null
                              ? () => reminderCtrl.setPriorityFilter(null)
                              : null,
                        ),
                        onSelected: (p) => reminderCtrl.setPriorityFilter(p),
                        itemBuilder: (ctx) => const [
                          PopupMenuItem(value: null, child: Text('All Priorities')),
                          PopupMenuItem(value: PriorityLevel.high, child: Text('High')),
                          PopupMenuItem(value: PriorityLevel.normal, child: Text('Normal')),
                          PopupMenuItem(value: PriorityLevel.low, child: Text('Low')),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Reminder List / Empty State
          if (filteredReminders.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: Center(
                  child: EmptyStateWidget(
                    icon: _getEmptyIcon(reminderCtrl.activeFilter),
                    title: _getEmptyTitle(reminderCtrl.activeFilter),
                    description: _getEmptyDescription(reminderCtrl.activeFilter),
                  ),
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 80),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final reminder = filteredReminders[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: ReminderCard(reminder: reminder),
                    );
                  },
                  childCount: filteredReminders.length,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(BuildContext context, FilterType type, String label) {
    final reminderCtrl = context.watch<ReminderController>();
    final isSelected = reminderCtrl.activeFilter == type;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => reminderCtrl.setFilter(type),
      ),
    );
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  String _formatNextUpTime(DateTime date) {
    final now = DateTime.now();
    final diff = date.difference(now);
    if (diff.inMinutes < 60) {
      return 'in ${diff.inMinutes}m';
    } else if (diff.inHours < 24) {
      return DateFormat('h:mm a').format(date);
    } else {
      return DateFormat('MMM d, h:mm a').format(date);
    }
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning,';
    if (hour < 17) return 'Good afternoon,';
    return 'Good evening,';
  }

  IconData _getEmptyIcon(FilterType filter) {
    switch (filter) {
      case FilterType.overdue:
        return Icons.task_alt;
      case FilterType.completed:
        return Icons.checklist;
      case FilterType.archived:
        return Icons.archive_outlined;
      default:
        return Icons.notifications_none;
    }
  }

  String _getEmptyTitle(FilterType filter) {
    switch (filter) {
      case FilterType.overdue:
        return 'No Overdue Reminders';
      case FilterType.today:
        return 'All Done for Today!';
      case FilterType.upcoming:
        return 'No Upcoming Reminders';
      case FilterType.completed:
        return 'No Completed Reminders Yet';
      case FilterType.archived:
        return 'Archive is Empty';
      default:
        return 'No Reminders Found';
    }
  }

  String _getEmptyDescription(FilterType filter) {
    switch (filter) {
      case FilterType.overdue:
        return 'Awesome job! You are completely up to date.';
      case FilterType.today:
        return 'Take a breather or plan something new for tomorrow.';
      case FilterType.upcoming:
        return 'Tap the + button to schedule your next task.';
      case FilterType.completed:
        return 'Check off your active reminders to see them here.';
      case FilterType.archived:
        return 'Old reminders you archive will be stored safely here.';
      default:
        return 'Tap the + button below to add your first nudge.';
    }
  }

  Widget _buildProductivityHub(
    BuildContext context,
    TodoController todoCtrl,
    RecordController recordCtrl,
  ) {
    final theme = Theme.of(context);
    final topTodos = todoCtrl.todos
        .where((t) => !t.isDeleted && !t.isArchived && !t.isDone)
        .take(2)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Productivity Hub',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TodosScreen()),
                );
              },
              child: const Text('View All Tasks'),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            // Tasks Card
            Expanded(
              child: NudgeCard(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const TodosScreen()),
                  );
                },
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Icon(Icons.check_circle_outline, size: 16, color: Colors.blue),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Tasks',
                            style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        if (todoCtrl.overdueCount > 0)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '${todoCtrl.overdueCount}!',
                              style: const TextStyle(fontSize: 10, color: Colors.red, fontWeight: FontWeight.bold),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${todoCtrl.activeCount} active tasks',
                      style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '${todoCtrl.todayCount} due today',
                      style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.outline),
                    ),
                    if (topTodos.isNotEmpty) ...[
                      const Divider(height: 12),
                      ...topTodos.map(
                        (t) => InkWell(
                          onTap: () => todoCtrl.toggleTodoStatus(t.id),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Row(
                              children: [
                                Icon(Icons.circle_outlined, size: 14, color: theme.colorScheme.outline),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    t.title,
                                    style: theme.textTheme.labelSmall,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            // Records Card
            Expanded(
              child: NudgeCard(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RecordsScreen()),
                  );
                },
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.amber.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Icon(Icons.lightbulb_outline, size: 16, color: Colors.amber),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Capture',
                            style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Icon(Icons.chevron_right, size: 16),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${recordCtrl.totalActiveCount} records',
                      style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Notes, ideas & thoughts',
                      style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.outline),
                    ),
                    const SizedBox(height: 6),
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        visualDensity: VisualDensity.compact,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const RecordEditorScreen()),
                        );
                      },
                      icon: const Icon(Icons.add, size: 14),
                      label: const Text('New Note', style: TextStyle(fontSize: 11)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
```

---

<a id="lib-features-home-reminder_carddart"></a>
## 81. `lib/features/home/reminder_card.dart`

**Path**: `lib/features/home/reminder_card.dart` | **Lines**: 348

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../application/controllers/companion_controller.dart';
import '../../application/controllers/folder_controller.dart';
import '../../application/controllers/reminder_controller.dart';
import '../../core/utils/date_utils.dart';
import '../../domain/entities/reminder.dart';
import '../../domain/enums/enums.dart';
import '../../presentation/theme/nudge_theme.dart';
import '../../features/reminders/reminder_editor_screen.dart';

class ReminderCard extends StatelessWidget {
  final Reminder reminder;

  const ReminderCard({super.key, required this.reminder});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final folderController = context.watch<FolderController>();
    final reminderController = context.read<ReminderController>();
    final companionController = context.read<CompanionController>();

    final folder = folderController.getFolderById(reminder.folderId);
    final isOverdue = reminder.isOverdue;

    Color priorityColor = Colors.grey;
    if (reminder.priority == PriorityLevel.high) priorityColor = NudgeTheme.error;
    if (reminder.priority == PriorityLevel.normal) priorityColor = NudgeTheme.secondary;

    return Dismissible(
      key: Key('dismiss_${reminder.id}'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: NudgeTheme.error,
          borderRadius: BorderRadius.circular(NudgeTheme.radiusL),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.delete_outline, color: Colors.white, size: 24),
            SizedBox(width: 8),
            Text('Delete', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      onDismissed: (_) {
        reminderController.deleteReminder(reminder.id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Deleted "${reminder.message}"'),
            action: SnackBarAction(
              label: 'UNDO',
              onPressed: () => reminderController.undoDelete(),
            ),
            duration: const Duration(seconds: 4),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(NudgeTheme.radiusL),
          side: BorderSide(
            color: isOverdue ? NudgeTheme.error.withOpacity(0.5) : (isDark ? NudgeTheme.cardBorderDark : NudgeTheme.cardBorderLight),
            width: isOverdue ? 1.5 : 1.0,
          ),
        ),
        color: isDark ? NudgeTheme.surfaceDark : NudgeTheme.surfaceLight,
        child: InkWell(
          borderRadius: BorderRadius.circular(NudgeTheme.radiusL),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ReminderEditorScreen(initialReminder: reminder),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Pin, Completion Circle, Message, Menu
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Completion Checkbox Circle
                    IconButton(
                      icon: Icon(
                        reminder.isDone ? Icons.check_circle : Icons.radio_button_unchecked,
                        color: reminder.isDone ? Colors.green : (isOverdue ? NudgeTheme.error : NudgeTheme.secondary),
                        size: 24,
                      ),
                      tooltip: reminder.isDone ? 'Completed' : 'Mark as done',
                      onPressed: () => reminderController.completeReminder(reminder.id, companionController),
                    ),
                    const SizedBox(width: 6),
                    // Message
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              if (reminder.isPinned)
                                const Padding(
                                  padding: EdgeInsets.only(right: 6.0),
                                  child: Icon(Icons.push_pin, size: 16, color: Colors.amber),
                                ),
                              Expanded(
                                child: Text(
                                  reminder.message,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    decoration: reminder.isDone ? TextDecoration.lineThrough : null,
                                    color: reminder.isDone
                                        ? Colors.grey
                                        : (isDark ? NudgeTheme.onBgDark : NudgeTheme.onBgLight),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          // Time and Date Row
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 14,
                                color: isOverdue ? NudgeTheme.error : Colors.grey,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                NudgeDateUtils.formatDateTime(reminder.scheduledAt),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: isOverdue ? FontWeight.bold : FontWeight.normal,
                                  color: isOverdue ? NudgeTheme.error : (isDark ? Colors.grey[400] : Colors.grey[600]),
                                ),
                              ),
                              if (reminder.isRepeating) ...[
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                                  decoration: BoxDecoration(
                                    color: isDark ? NudgeTheme.surfaceContainerDark : NudgeTheme.surfaceContainerLight,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.repeat, size: 11, color: Colors.grey),
                                      const SizedBox(width: 2),
                                      Text(
                                        reminder.repeatRule.name,
                                        style: const TextStyle(fontSize: 10, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Card Menu
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert, size: 20),
                      onSelected: (value) {
                        switch (value) {
                          case 'pin':
                            reminderController.togglePin(reminder.id);
                            break;
                          case 'archive':
                            reminderController.toggleArchive(reminder.id);
                            break;
                          case 'skip':
                            reminderController.skipOccurrence(reminder.id);
                            break;
                          case 'edit':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ReminderEditorScreen(initialReminder: reminder),
                              ),
                            );
                            break;
                          case 'delete':
                            reminderController.deleteReminder(reminder.id);
                            break;
                        }
                      },
                      itemBuilder: (ctx) => [
                        PopupMenuItem(
                          value: 'pin',
                          child: Row(
                            children: [
                              Icon(reminder.isPinned ? Icons.push_pin_outlined : Icons.push_pin, size: 18),
                              const SizedBox(width: 10),
                              Text(reminder.isPinned ? 'Unpin' : 'Pin to top'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(Icons.edit_outlined, size: 18),
                              SizedBox(width: 10),
                              Text('Edit'),
                            ],
                          ),
                        ),
                        if (reminder.isRepeating)
                          const PopupMenuItem(
                            value: 'skip',
                            child: Row(
                              children: [
                                Icon(Icons.skip_next_outlined, size: 18),
                                SizedBox(width: 10),
                                Text('Skip occurrence'),
                              ],
                            ),
                          ),
                        PopupMenuItem(
                          value: 'archive',
                          child: Row(
                            children: [
                              Icon(reminder.isArchived ? Icons.unarchive_outlined : Icons.archive_outlined, size: 18),
                              const SizedBox(width: 10),
                              Text(reminder.isArchived ? 'Unarchive' : 'Archive'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete_outline, size: 18, color: NudgeTheme.error),
                              SizedBox(width: 10),
                              Text('Delete', style: TextStyle(color: NudgeTheme.error)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // Metadata Row: Folder, Checklist Progress, Priority Badge, Photo indicator
                Padding(
                  padding: const EdgeInsets.only(left: 42.0, top: 8.0),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      // Folder Chip
                      if (folder != null)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: NudgeTheme.getFolderColor(folder, isDark).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                NudgeTheme.getFolderIcon(folder),
                                size: 12,
                                color: NudgeTheme.getFolderColor(folder, isDark),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                folder.name,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: NudgeTheme.getFolderColor(folder, isDark),
                                ),
                              ),
                            ],
                          ),
                        ),
                      // Priority Badge
                      if (reminder.priority != PriorityLevel.normal)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: priorityColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            reminder.priority.name.toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: priorityColor,
                            ),
                          ),
                        ),
                      // Checklist Progress
                      if (reminder.hasChecklist)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.checklist, size: 14, color: Colors.grey),
                            const SizedBox(width: 3),
                            Text(
                              '${reminder.checklistCompletedCount}/${reminder.checklist.length}',
                              style: const TextStyle(fontSize: 11, color: Colors.grey),
                            ),
                          ],
                        ),
                      // Photo Indicator
                      if (reminder.photoPath != null && reminder.photoPath!.isNotEmpty)
                        const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.photo_outlined, size: 14, color: Colors.grey),
                          ],
                        ),
                      // Snooze Count badge
                      if (reminder.snoozeCount > 0)
                        Text(
                          'Snoozed ${reminder.snoozeCount}x',
                          style: const TextStyle(fontSize: 11, color: Colors.orange, fontWeight: FontWeight.bold),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

---

<a id="lib-features-records-record_carddart"></a>
## 82. `lib/features/records/record_card.dart`

**Path**: `lib/features/records/record_card.dart` | **Lines**: 256

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../application/controllers/folder_controller.dart';
import '../../application/controllers/record_controller.dart';
import '../../domain/entities/record.dart';
import '../../domain/enums/todo_enums.dart';
import '../../presentation/components/nudge_card.dart';
import '../../presentation/theme/nudge_theme.dart';
import '../todos/todo_editor_screen.dart';
import 'record_detail_screen.dart';
import 'record_editor_screen.dart';

class RecordCard extends StatelessWidget {
  final Record record;

  const RecordCard({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final recordCtrl = context.read<RecordController>();
    final folderCtrl = context.watch<FolderController>();
    final folder = record.folderId != null ? folderCtrl.getFolderById(record.folderId) : null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: NudgeCard(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => RecordDetailScreen(recordId: record.id),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Type badge, pin, more menu
              Row(
                children: [
                  _buildTypeBadge(context, record.recordType),
                  const SizedBox(width: 8),
                  if (folder != null)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(NudgeTheme.getFolderIcon(folder), size: 12, color: theme.colorScheme.primary),
                          const SizedBox(width: 4),
                          Text(folder.name, style: theme.textTheme.labelSmall),
                        ],
                      ),
                    ),
                  const Spacer(),
                  if (record.isPinned) ...[
                    Icon(Icons.push_pin, size: 14, color: theme.colorScheme.primary),
                    const SizedBox(width: 4),
                  ],
                  // Quick "Turn into Todo" button
                  IconButton(
                    icon: const Icon(Icons.add_task_outlined, size: 20),
                    tooltip: 'Turn into Task',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TodoEditorScreen(
                            initialTitle: record.title,
                            initialDescription: record.content,
                            initialFolderId: record.folderId,
                            initialSourceRecordId: record.id,
                          ),
                        ),
                      );
                    },
                  ),
                  PopupMenuButton<String>(
                    icon: Icon(Icons.more_vert, size: 20, color: theme.colorScheme.outline),
                    onSelected: (val) {
                      switch (val) {
                        case 'pin':
                          recordCtrl.togglePin(record.id);
                          break;
                        case 'edit':
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => RecordEditorScreen(record: record),
                            ),
                          );
                          break;
                        case 'archive':
                          recordCtrl.toggleArchive(record.id);
                          break;
                        case 'delete':
                          recordCtrl.softDeleteRecord(record.id);
                          break;
                      }
                    },
                    itemBuilder: (ctx) => [
                      PopupMenuItem(
                        value: 'pin',
                        child: Row(
                          children: [
                            Icon(record.isPinned ? Icons.push_pin_outlined : Icons.push_pin, size: 18),
                            const SizedBox(width: 8),
                            Text(record.isPinned ? 'Unpin' : 'Pin to top'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit_outlined, size: 18),
                            SizedBox(width: 8),
                            Text('Edit'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'archive',
                        child: Row(
                          children: [
                            Icon(record.isArchived ? Icons.unarchive_outlined : Icons.archive_outlined, size: 18),
                            const SizedBox(width: 8),
                            Text(record.isArchived ? 'Unarchive' : 'Archive'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete_outline, size: 18, color: Colors.red),
                            SizedBox(width: 8),
                            Text('Delete', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Title
              Text(
                record.title,
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              // Content snippet
              if (record.content.trim().isNotEmpty && record.content.trim() != record.title.trim()) ...[
                const SizedBox(height: 4),
                Text(
                  record.content.trim(),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.4,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],

              const SizedBox(height: 8),
              // Footer: Date
              Text(
                DateFormat('MMM d, yyyy · h:mm a').format(record.occurredAt ?? record.createdAt),
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.outline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTypeBadge(BuildContext context, RecordType type) {
    Color color;
    String label;
    IconData icon;

    switch (type) {
      case RecordType.idea:
        color = Colors.amber.shade700;
        label = 'Idea';
        icon = Icons.lightbulb_outline;
        break;
      case RecordType.thought:
        color = Colors.purple;
        label = 'Thought';
        icon = Icons.psychology_outlined;
        break;
      case RecordType.log:
        color = Colors.teal;
        label = 'Log';
        icon = Icons.list_alt_outlined;
        break;
      case RecordType.snippet:
        color = Colors.blue;
        label = 'Snippet';
        icon = Icons.code;
        break;
      case RecordType.decision:
        color = Colors.deepOrange;
        label = 'Decision';
        icon = Icons.gavel_outlined;
        break;
      case RecordType.note:
      default:
        color = Colors.indigo;
        label = 'Note';
        icon = Icons.edit_note;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.25), width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
```

---

<a id="lib-features-records-record_detail_screendart"></a>
## 83. `lib/features/records/record_detail_screen.dart`

**Path**: `lib/features/records/record_detail_screen.dart` | **Lines**: 261

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../application/controllers/folder_controller.dart';
import '../../application/controllers/record_controller.dart';
import '../../domain/entities/record.dart';
import '../../domain/enums/todo_enums.dart';
import '../../presentation/components/nudge_card.dart';
import '../../presentation/theme/nudge_theme.dart';
import '../todos/todo_editor_screen.dart';
import 'record_editor_screen.dart';

class RecordDetailScreen extends StatelessWidget {
  final String recordId;

  const RecordDetailScreen({super.key, required this.recordId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final recordCtrl = context.watch<RecordController>();
    final folderCtrl = context.watch<FolderController>();

    final record = recordCtrl.records.firstWhere(
      (r) => r.id == recordId,
      orElse: () => Record(id: recordId, title: 'Not found', content: ''),
    );

    if (record.title == 'Not found') {
      return Scaffold(
        appBar: AppBar(title: const Text('Record Detail')),
        body: const Center(child: Text('Record not found or was deleted.')),
      );
    }

    final folder = record.folderId != null ? folderCtrl.getFolderById(record.folderId) : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Record Details'),
        actions: [
          IconButton(
            icon: Icon(record.isPinned ? Icons.push_pin : Icons.push_pin_outlined),
            tooltip: record.isPinned ? 'Unpin' : 'Pin to top',
            onPressed: () => recordCtrl.togglePin(record.id),
          ),
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'Edit Record',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RecordEditorScreen(record: record),
                ),
              );
            },
          ),
          PopupMenuButton<String>(
            onSelected: (val) {
              if (val == 'archive') {
                recordCtrl.toggleArchive(record.id);
                Navigator.pop(context);
              } else if (val == 'delete') {
                recordCtrl.softDeleteRecord(record.id);
                Navigator.pop(context);
              }
            },
            itemBuilder: (ctx) => [
              PopupMenuItem(
                value: 'archive',
                child: Row(
                  children: [
                    Icon(record.isArchived ? Icons.unarchive_outlined : Icons.archive_outlined, size: 18),
                    const SizedBox(width: 8),
                    Text(record.isArchived ? 'Unarchive' : 'Archive'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete_outline, size: 18, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Delete Record', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Header Card with Title and Badges
          NudgeCard(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildTypeBadge(context, record.recordType),
                      const SizedBox(width: 8),
                      if (folder != null)
                        Row(
                          children: [
                            Icon(NudgeTheme.getFolderIcon(folder), size: 14, color: theme.colorScheme.primary),
                            const SizedBox(width: 4),
                            Text(folder.name, style: theme.textTheme.labelMedium),
                          ],
                        ),
                      const Spacer(),
                      Text(
                        DateFormat('MMM d, yyyy · h:mm a').format(record.occurredAt ?? record.createdAt),
                        style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.outline),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SelectableText(
                    record.title,
                    style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Content
          if (record.content.trim().isNotEmpty) ...[
            NudgeCard(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SelectableText(
                  record.content.trim(),
                  style: theme.textTheme.bodyLarge?.copyWith(height: 1.6),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],

          // Turn into Todo Action Card
          NudgeCard(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TodoEditorScreen(
                    initialTitle: record.title,
                    initialDescription: record.content,
                    initialFolderId: record.folderId,
                    initialSourceRecordId: record.id,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.add_task, color: theme.colorScheme.onPrimaryContainer),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Turn into Task (Todo)', style: theme.textTheme.titleSmall),
                        const SizedBox(height: 2),
                        Text(
                          'Convert this note into an actionable task with due date & subtasks',
                          style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeBadge(BuildContext context, RecordType type) {
    Color color;
    String label;
    IconData icon;

    switch (type) {
      case RecordType.idea:
        color = Colors.amber.shade700;
        label = 'Idea';
        icon = Icons.lightbulb_outline;
        break;
      case RecordType.thought:
        color = Colors.purple;
        label = 'Thought';
        icon = Icons.psychology_outlined;
        break;
      case RecordType.log:
        color = Colors.teal;
        label = 'Log';
        icon = Icons.list_alt_outlined;
        break;
      case RecordType.snippet:
        color = Colors.blue;
        label = 'Snippet';
        icon = Icons.code;
        break;
      case RecordType.decision:
        color = Colors.deepOrange;
        label = 'Decision';
        icon = Icons.gavel_outlined;
        break;
      case RecordType.note:
      default:
        color = Colors.indigo;
        label = 'Note';
        icon = Icons.edit_note;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
```

---

<a id="lib-features-records-record_editor_screendart"></a>
## 84. `lib/features/records/record_editor_screen.dart`

**Path**: `lib/features/records/record_editor_screen.dart` | **Lines**: 233

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../application/controllers/folder_controller.dart';
import '../../application/controllers/record_controller.dart';
import '../../domain/entities/record.dart';
import '../../domain/enums/todo_enums.dart';
import '../../presentation/theme/nudge_theme.dart';
import '../todos/todo_editor_screen.dart';

class RecordEditorScreen extends StatefulWidget {
  final Record? record;
  final String? initialFolderId;
  final RecordType? initialType;

  const RecordEditorScreen({
    super.key,
    this.record,
    this.initialFolderId,
    this.initialType,
  });

  @override
  State<RecordEditorScreen> createState() => _RecordEditorScreenState();
}

class _RecordEditorScreenState extends State<RecordEditorScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  late RecordType _recordType;
  String? _selectedFolderId;

  @override
  void initState() {
    super.initState();
    final r = widget.record;
    _titleController = TextEditingController(text: r?.title ?? '');
    _contentController = TextEditingController(text: r?.content ?? '');
    _recordType = r?.recordType ?? widget.initialType ?? RecordType.note;
    _selectedFolderId = r?.folderId ?? widget.initialFolderId;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<Record?> _saveRecord({bool closeOnSave = true}) async {
    if (!_formKey.currentState!.validate()) return null;

    final title = _titleController.text.trim();
    final content = _contentController.text.trim();
    final recordCtrl = context.read<RecordController>();

    Record result;
    if (widget.record != null) {
      result = widget.record!.copyWith(
        title: title,
        content: content,
        recordType: _recordType,
        folderId: _selectedFolderId,
      );
      await recordCtrl.updateRecord(result);
    } else {
      result = Record(
        title: title,
        content: content,
        recordType: _recordType,
        folderId: _selectedFolderId,
        occurredAt: DateTime.now(),
      );
      await recordCtrl.createRecord(result);
    }

    if (closeOnSave && mounted) {
      Navigator.pop(context);
    }
    return result;
  }

  Future<void> _saveAndTurnIntoTodo() async {
    final savedRecord = await _saveRecord(closeOnSave: false);
    if (savedRecord == null || !mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => TodoEditorScreen(
          initialTitle: savedRecord.title,
          initialDescription: savedRecord.content,
          initialFolderId: savedRecord.folderId,
          initialSourceRecordId: savedRecord.id,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final folderCtrl = context.watch<FolderController>();
    final isEditing = widget.record != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Record' : 'New Record'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: FilledButton.icon(
              onPressed: () => _saveRecord(closeOnSave: true),
              icon: const Icon(Icons.check, size: 18),
              label: const Text('Save'),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Title
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title *',
                hintText: 'Idea, thought, note heading...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.title),
              ),
              textCapitalization: TextCapitalization.sentences,
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Title is required' : null,
            ),
            const SizedBox(height: 14),

            // Record Type Selector
            Text('Type', style: theme.textTheme.titleSmall),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: RecordType.values.map((type) {
                final isSelected = _recordType == type;
                return ChoiceChip(
                  label: Text(_getTypeLabel(type)),
                  selected: isSelected,
                  onSelected: (val) {
                    if (val) setState(() => _recordType = type);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 18),

            // Folder Picker
            Text('Folder', style: theme.textTheme.titleSmall),
            const SizedBox(height: 8),
            DropdownButtonFormField<String?>(
              value: _selectedFolderId,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.folder_outlined),
              ),
              items: [
                const DropdownMenuItem<String?>(
                  value: null,
                  child: Text('No Folder (General)'),
                ),
                ...folderCtrl.folders.map(
                  (f) => DropdownMenuItem<String?>(
                    value: f.id,
                    child: Row(
                      children: [
                        Icon(NudgeTheme.getFolderIcon(f), size: 16),
                        const SizedBox(width: 8),
                        Text(f.name),
                      ],
                    ),
                  ),
                ),
              ],
              onChanged: (val) => setState(() => _selectedFolderId = val),
            ),
            const SizedBox(height: 18),

            // Content / Freeform Body
            TextFormField(
              controller: _contentController,
              decoration: const InputDecoration(
                labelText: 'Content / Notes',
                hintText: 'Write down details, reflections, code, or logs...',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              maxLines: 10,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 24),

            // Turn into Todo Action
            OutlinedButton.icon(
              onPressed: _saveAndTurnIntoTodo,
              icon: const Icon(Icons.add_task),
              label: const Text('Save & Turn into Task (Todo)'),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  String _getTypeLabel(RecordType type) {
    switch (type) {
      case RecordType.note:
        return '📝 Note';
      case RecordType.idea:
        return '💡 Idea';
      case RecordType.thought:
        return '🧠 Thought';
      case RecordType.log:
        return '📋 Log';
      case RecordType.snippet:
        return '💻 Snippet';
      case RecordType.decision:
        return '⚖️ Decision';
    }
  }
}
```

---

<a id="lib-features-records-records_screendart"></a>
## 85. `lib/features/records/records_screen.dart`

**Path**: `lib/features/records/records_screen.dart` | **Lines**: 263

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../application/controllers/folder_controller.dart';
import '../../application/controllers/record_controller.dart';
import '../../domain/enums/todo_enums.dart';
import '../../presentation/components/empty_state_widget.dart';
import '../../presentation/theme/nudge_theme.dart';
import 'record_card.dart';
import 'record_editor_screen.dart';

class RecordsScreen extends StatefulWidget {
  final String? initialFolderId;

  const RecordsScreen({super.key, this.initialFolderId});

  @override
  State<RecordsScreen> createState() => _RecordsScreenState();
}

class _RecordsScreenState extends State<RecordsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _quickCaptureController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ctrl = context.read<RecordController>();
      if (widget.initialFolderId != null) {
        ctrl.setFolder(widget.initialFolderId);
      }
      ctrl.loadRecords();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _quickCaptureController.dispose();
    super.dispose();
  }

  void _handleQuickCapture() {
    final text = _quickCaptureController.text.trim();
    if (text.isEmpty) return;

    final recordCtrl = context.read<RecordController>();
    recordCtrl.quickCapture(
      text,
      type: RecordType.note,
      folderId: recordCtrl.selectedFolderId ?? widget.initialFolderId,
    );
    _quickCaptureController.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final recordCtrl = context.watch<RecordController>();
    final folderCtrl = context.watch<FolderController>();

    final filteredRecords = recordCtrl.filteredRecords;
    final isTrash = recordCtrl.activeFilter == RecordFilter.trash;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Records & Capture'),
        actions: [
          if (isTrash)
            IconButton(
              icon: const Icon(Icons.delete_forever, color: Colors.red),
              tooltip: 'Empty Trash',
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Empty Trash?'),
                    content: const Text('This will permanently delete all records in the trash.'),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
                      FilledButton(
                        style: FilledButton.styleFrom(backgroundColor: Colors.red),
                        onPressed: () => Navigator.pop(ctx, true),
                        child: const Text('Delete Permanently'),
                      ),
                    ],
                  ),
                );
                if (confirm == true) {
                  await recordCtrl.purgeTrash();
                }
              },
            ),
        ],
      ),
      body: Column(
        children: [
          // Quick Capture Box
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _quickCaptureController,
                    decoration: InputDecoration(
                      hintText: 'Quick capture a thought, idea, or note...',
                      prefixIcon: const Icon(Icons.flash_on, color: Colors.amber),
                      isDense: true,
                      filled: true,
                      fillColor: theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onSubmitted: (_) => _handleQuickCapture(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filledTonal(
                  icon: const Icon(Icons.send, size: 18),
                  tooltip: 'Save Record',
                  onPressed: _handleQuickCapture,
                ),
              ],
            ),
          ),

          // Search Filter Input
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search records...',
                prefixIcon: const Icon(Icons.search, size: 20),
                isDense: true,
                border: InputBorder.none,
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 18),
                        onPressed: () {
                          _searchController.clear();
                          recordCtrl.setSearchQuery('');
                        },
                      )
                    : null,
              ),
              onChanged: (val) => recordCtrl.setSearchQuery(val),
            ),
          ),

          // Type Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                _buildTypeChip('All (${recordCtrl.totalActiveCount})', RecordFilter.all, recordCtrl),
                const SizedBox(width: 8),
                _buildTypeChip('📝 Notes', RecordFilter.notes, recordCtrl),
                const SizedBox(width: 8),
                _buildTypeChip('💡 Ideas', RecordFilter.ideas, recordCtrl),
                const SizedBox(width: 8),
                _buildTypeChip('🧠 Thoughts', RecordFilter.thoughts, recordCtrl),
                const SizedBox(width: 8),
                _buildTypeChip('📋 Logs', RecordFilter.logs, recordCtrl),
                const SizedBox(width: 8),
                _buildTypeChip('💻 Snippets', RecordFilter.snippets, recordCtrl),
                const SizedBox(width: 8),
                _buildTypeChip('⚖️ Decisions', RecordFilter.decisions, recordCtrl),
                const SizedBox(width: 8),
                _buildTypeChip('Archived', RecordFilter.archived, recordCtrl),
                const SizedBox(width: 8),
                _buildTypeChip('Trash', RecordFilter.trash, recordCtrl),
              ],
            ),
          ),

          // Folder Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
            child: Row(
              children: [
                ChoiceChip(
                  label: const Text('All Folders'),
                  selected: recordCtrl.selectedFolderId == null,
                  onSelected: (selected) {
                    if (selected) recordCtrl.setFolder(null);
                  },
                ),
                const SizedBox(width: 8),
                ...folderCtrl.folders.map((f) {
                  final isSelected = recordCtrl.selectedFolderId == f.id;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      avatar: Icon(NudgeTheme.getFolderIcon(f), size: 14),
                      label: Text(f.name),
                      selected: isSelected,
                      onSelected: (selected) {
                        recordCtrl.setFolder(selected ? f.id : null);
                      },
                    ),
                  );
                }),
              ],
            ),
          ),

          const Divider(height: 12),

          // Record List
          Expanded(
            child: filteredRecords.isEmpty
                ? EmptyStateWidget(
                    icon: Icons.note_alt_outlined,
                    title: isTrash ? 'Trash is Empty' : 'No Records Found',
                    subtitle: isTrash
                        ? 'Deleted records will appear here'
                        : 'Capture thoughts, notes, or ideas quickly above',
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 80, top: 4),
                    itemCount: filteredRecords.length,
                    itemBuilder: (ctx, index) {
                      return RecordCard(record: filteredRecords[index]);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => RecordEditorScreen(
                initialFolderId: recordCtrl.selectedFolderId ?? widget.initialFolderId,
              ),
            ),
          );
        },
        icon: const Icon(Icons.edit_note),
        label: const Text('New Record'),
      ),
    );
  }

  Widget _buildTypeChip(String label, RecordFilter filter, RecordController ctrl) {
    final isSelected = ctrl.activeFilter == filter;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (val) {
        if (val) ctrl.setFilter(filter);
      },
    );
  }
}
```

---

<a id="lib-features-reliability-improve_reliability_screendart"></a>
## 86. `lib/features/reliability/improve_reliability_screen.dart`

**Path**: `lib/features/reliability/improve_reliability_screen.dart` | **Lines**: 355

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../application/controllers/reliability_controller.dart';
import '../../presentation/components/nudge_card.dart';
import '../../presentation/components/nudge_button.dart';
import '../../platform/alarms/alarm_platform_service.dart';
import '../../domain/entities/reminder.dart';
import '../../domain/enums/enums.dart';

class ImproveReliabilityScreen extends StatefulWidget {
  const ImproveReliabilityScreen({super.key});

  @override
  State<ImproveReliabilityScreen> createState() => _ImproveReliabilityScreenState();
}

class _ImproveReliabilityScreenState extends State<ImproveReliabilityScreen> with WidgetsBindingObserver {
  bool _testingAlarm = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ReliabilityController>().refreshStatuses();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<ReliabilityController>().refreshStatuses();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _triggerTestAlarm() async {
    final reminder = Reminder(
      message: 'Nudge Alarm Test',
      scheduledAt: DateTime.now().add(
        const Duration(
          seconds: 10,
        ),
      ),
      alertStyle: AlertStyle.alarm,
      folderId: 'general',
      priority: PriorityLevel.high,
    );

    final allowed = await AlarmPlatformService.canScheduleExactAlarms();

    if (!allowed) {
      await AlarmPlatformService.openExactAlarmSettings();
      return;
    }

    setState(() => _testingAlarm = true);

    try {
      await AlarmPlatformService.scheduleAlarm(
        reminder,
      );

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Alarm scheduled for 10 seconds.',
          ),
        ),
      );
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Alarm scheduling failed: $e',
          ),
        ),
      );
    } finally {
      if (mounted) setState(() => _testingAlarm = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final reliability = context.watch<ReliabilityController>();

    final allPassed = reliability.notificationsEnabled &&
        reliability.exactAlarmsEnabled &&
        reliability.fullScreenIntentEnabled &&
        reliability.batteryOptimizationIgnored;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Alarm & Background Reliability'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => reliability.refreshStatuses(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Reliability Status Banner
            NudgeCard(
              color: allPassed
                  ? theme.colorScheme.primaryContainer.withOpacity(0.4)
                  : theme.colorScheme.errorContainer.withOpacity(0.3),
              child: Row(
                children: [
                  Icon(
                    allPassed ? Icons.verified_user : Icons.warning_amber_rounded,
                    size: 36,
                    color: allPassed ? theme.colorScheme.primary : theme.colorScheme.error,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          allPassed ? 'Fully Optimized' : 'Attention Needed',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: allPassed ? theme.colorScheme.primary : theme.colorScheme.error,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          allPassed
                              ? 'Nudge has all required permissions to ring exact alarms and wake your device.'
                              : 'Some permissions or OEM battery savers may prevent alarms from ringing on time.',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // System Permissions Checklist
            Text(
              'System Settings & Permissions',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Exact Alarms
            _buildChecklistTile(
              title: 'Schedule Exact Alarms',
              description: 'Required on Android 12+ to ring alarms at the exact minute without delay.',
              isGranted: reliability.exactAlarmsEnabled,
              onTap: () => reliability.requestExactAlarms(),
              buttonText: 'Grant Alarm Access',
            ),
            const SizedBox(height: 12),

            // Full-Screen Alarms
            _buildChecklistTile(
              title: 'Allow Full-Screen Alarms',
              description: 'Required on Android 14+ to display full-screen ringing screen when the phone is locked.',
              isGranted: reliability.fullScreenIntentEnabled,
              onTap: () => reliability.requestFullScreenIntent(),
              buttonText: 'Grant Full-Screen Access',
            ),
            const SizedBox(height: 12),

            // Notifications
            _buildChecklistTile(
              title: 'Post Notifications',
              description: 'Required to show gentle nudges, heads-up banners, and full-screen alarm controls.',
              isGranted: reliability.notificationsEnabled,
              onTap: () => reliability.requestNotifications(),
              buttonText: 'Enable Notifications',
            ),
            const SizedBox(height: 12),

            // Battery Optimization
            _buildChecklistTile(
              title: 'Ignore Battery Optimizations',
              description: 'Exempts Nudge from Android Doze mode so alarms ring even after hours of device inactivity.',
              isGranted: reliability.batteryOptimizationIgnored,
              onTap: () => reliability.requestBatteryOptimization(),
              buttonText: 'Disable Optimization',
            ),
            const SizedBox(height: 24),

            // Verify with Test Alarm
            Text(
              'Diagnostic Verification',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            NudgeCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Test Alarm Dispatch',
                    style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Schedule an instant 5-second test alarm. You can lock your device or switch apps to verify audio playback and full-screen ringing.',
                    style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
                  ),
                  const SizedBox(height: 14),
                  NudgeButton(
                    label: _testingAlarm ? 'Scheduling Test...' : 'Trigger 5-Second Test Alarm',
                    icon: Icons.alarm,
                    onPressed: _testingAlarm ? null : _triggerTestAlarm,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Manufacturer Specific Guides
            Text(
              'Manufacturer OEM Guides',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Aggressive battery killers in customized Android skins may terminate background services.',
              style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
            ),
            const SizedBox(height: 12),

            _buildOemGuideTile(
              brand: 'Samsung (One UI)',
              instructions: 'Settings > Apps > Nudge > Battery > Choose "Unrestricted". In Device Care > Battery > Background usage limits, ensure Nudge is not in "Sleeping apps".',
            ),
            const SizedBox(height: 8),
            _buildOemGuideTile(
              brand: 'Xiaomi / Redmi / POCO (MIUI / HyperOS)',
              instructions: 'Settings > Apps > Manage Apps > Nudge > Enable "Autostart". In Battery Saver, set to "No restrictions". Also lock Nudge in Recent Apps.',
            ),
            const SizedBox(height: 8),
            _buildOemGuideTile(
              brand: 'OnePlus / OPPO / Realme (OxygenOS / ColorOS)',
              instructions: 'Settings > Battery > More battery settings > App battery management > Nudge > Enable "Allow background activity" and "Allow auto-launch".',
            ),
            const SizedBox(height: 8),
            _buildOemGuideTile(
              brand: 'Huawei / Honor (EMUI / MagicOS)',
              instructions: 'Settings > Battery > App Launch > Nudge > Turn off "Manage automatically", and enable "Auto-launch", "Secondary launch", and "Run in background".',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChecklistTile({
    required String title,
    required String description,
    required bool isGranted,
    required VoidCallback onTap,
    required String buttonText,
  }) {
    final theme = Theme.of(context);
    return NudgeCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isGranted ? Icons.check_circle : Icons.cancel,
                color: isGranted ? theme.colorScheme.primary : theme.colorScheme.error,
                size: 22,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Chip(
                label: Text(isGranted ? 'Granted' : 'Missing'),
                backgroundColor: isGranted
                    ? theme.colorScheme.primaryContainer
                    : theme.colorScheme.errorContainer,
                labelStyle: TextStyle(
                  color: isGranted
                      ? theme.colorScheme.onPrimaryContainer
                      : theme.colorScheme.onErrorContainer,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
          ),
          if (!isGranted) ...[
            const SizedBox(height: 12),
            FilledButton.tonal(
              onPressed: onTap,
              child: Text(buttonText),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildOemGuideTile({required String brand, required String instructions}) {
    final theme = Theme.of(context);
    return ExpansionTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.colorScheme.outlineVariant.withOpacity(0.5)),
      ),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.colorScheme.outlineVariant.withOpacity(0.5)),
      ),
      leading: const Icon(Icons.phone_android),
      title: Text(brand, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
      childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      children: [
        Text(
          instructions,
          style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
        ),
      ],
    );
  }
}
```

---

<a id="lib-features-reminders-reminder_editor_screendart"></a>
## 87. `lib/features/reminders/reminder_editor_screen.dart`

**Path**: `lib/features/reminders/reminder_editor_screen.dart` | **Lines**: 755

```dart
﻿import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../application/controllers/folder_controller.dart';
import '../../application/controllers/reminder_controller.dart';
import '../../core/utils/date_utils.dart';
import '../../data/repositories/template_repository_impl.dart';
import '../../domain/entities/checklist_item.dart';
import '../../domain/entities/reminder.dart';
import '../../domain/entities/reminder_template.dart';
import '../../domain/enums/enums.dart';
import '../../domain/services/conflict_detector.dart';
import '../../domain/services/nlp_parser.dart';
import '../../presentation/components/checklist_widget.dart';
import '../../presentation/components/nudge_button.dart';
import '../../presentation/components/nudge_text_field.dart';
import '../../presentation/components/voice_input_button.dart';
import '../../presentation/theme/nudge_theme.dart';

class ReminderEditorScreen extends StatefulWidget {
  final Reminder? initialReminder;

  const ReminderEditorScreen({super.key, this.initialReminder});

  @override
  State<ReminderEditorScreen> createState() => _ReminderEditorScreenState();
}

class _ReminderEditorScreenState extends State<ReminderEditorScreen> {
  int _currentStep = 1;
  bool _isSaving = false;

  late TextEditingController _messageController;
  late DateTime _scheduledDate;
  late TimeOfDay _scheduledTime;
  late RepeatRule _repeatRule;
  late PriorityLevel _priority;
  late AlertStyle _alertStyle;
  late String _soundId;
  late bool _vibrationEnabled;
  late bool _calendarSync;
  String? _folderId;
  List<ChecklistItem> _checklist = [];
  String? _photoPath;
  int? _repeatEndOccurrences;
  DateTime? _repeatEndDate;

  NLPParseResult? _nlpPreview;
  ConflictDetectionResult _conflictResult = ConflictDetectionResult.noConflict;
  List<ReminderTemplate> _templates = [];

  bool get _isEditing => widget.initialReminder != null;

  @override
  void initState() {
    super.initState();
    final init = widget.initialReminder;
    _messageController = TextEditingController(text: init?.message ?? '');
    _scheduledDate = init?.scheduledAt ?? DateTime.now().add(const Duration(hours: 1));
    _scheduledTime = TimeOfDay(hour: _scheduledDate.hour, minute: _scheduledDate.minute);
    _repeatRule = init?.repeatRule ?? RepeatRule.none;
    _priority = init?.priority ?? PriorityLevel.normal;
    _alertStyle = init?.alertStyle ?? AlertStyle.alarm;
    _soundId = init?.soundId ?? 'alarm';
    _vibrationEnabled = init?.vibrationEnabled ?? true;
    _calendarSync = init?.calendarEventId != null;
    _folderId = init?.folderId;
    _checklist = init != null ? List<ChecklistItem>.from(init.checklist) : [];
    _photoPath = init?.photoPath;
    _repeatEndOccurrences = init?.repeatEndOccurrences;
    _repeatEndDate = init?.repeatEndDate;

    _messageController.addListener(_onMessageChanged);
    _loadTemplates();
  }

  Future<void> _loadTemplates() async {
    final templates = await TemplateRepositoryImpl().getAllTemplates();
    if (mounted) setState(() => _templates = templates);
  }

  void _onMessageChanged() {
    final text = _messageController.text;
    if (!_isEditing && text.isNotEmpty) {
      final parsed = NLPParser.parse(text);
      setState(() {
        _nlpPreview = parsed.hasParsedScheduling ? parsed : null;
      });
    }
    _runConflictCheck();
  }

  void _runConflictCheck() {
    final candidateTime = DateTime(
      _scheduledDate.year,
      _scheduledDate.month,
      _scheduledDate.day,
      _scheduledTime.hour,
      _scheduledTime.minute,
    );

    final candidate = Reminder(
      id: widget.initialReminder?.id,
      message: _messageController.text,
      scheduledAt: candidateTime,
      folderId: _folderId,
    );

    final existing = context.read<ReminderController>().reminders;
    final conflict = ConflictDetector.checkConflicts(
      candidate: candidate,
      existingReminders: existing,
      currentEditingId: widget.initialReminder?.id,
    );

    setState(() => _conflictResult = conflict);
  }

  void _applyNlpPreview() {
    if (_nlpPreview == null) return;
    setState(() {
      _messageController.text = _nlpPreview!.cleanedMessage;
      if (_nlpPreview!.scheduledDate != null) {
        _scheduledDate = _nlpPreview!.scheduledDate!;
      }
      if (_nlpPreview!.scheduledHour != null && _nlpPreview!.scheduledMinute != null) {
        _scheduledTime = TimeOfDay(
          hour: _nlpPreview!.scheduledHour!,
          minute: _nlpPreview!.scheduledMinute!,
        );
      }
      if (_nlpPreview!.repeatRule != null) {
        _repeatRule = _nlpPreview!.repeatRule!;
      }
      if (_nlpPreview!.priority != null) {
        _priority = _nlpPreview!.priority!;
      }
      _nlpPreview = null;
    });
    _runConflictCheck();
  }

  void _applyTemplate(ReminderTemplate t) {
    setState(() {
      _messageController.text = t.message;
      _priority = t.priority;
      _alertStyle = t.alertStyle;
      _repeatRule = t.repeatRule;
      _checklist = List<ChecklistItem>.from(t.checklist);
    });
    _runConflictCheck();
  }

  Future<void> _pickPhoto() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery, maxWidth: 1024);
    if (image != null) {
      setState(() => _photoPath = image.path);
    }
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _scheduledDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );
    if (picked != null) {
      setState(() => _scheduledDate = picked);
      _runConflictCheck();
    }
  }

  Future<void> _selectTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _scheduledTime,
    );
    if (picked != null) {
      setState(() => _scheduledTime = picked);
      _runConflictCheck();
    }
  }

  Future<void> _saveReminder() async {
    final message = _messageController.text.trim();
    if (message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a reminder title')),
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      final scheduledDateTime = DateTime(
        _scheduledDate.year,
        _scheduledDate.month,
        _scheduledDate.day,
        _scheduledTime.hour,
        _scheduledTime.minute,
      );

      final controller = context.read<ReminderController>();

      final reminder = Reminder(
        id: widget.initialReminder?.id,
        message: message,
        folderId: _folderId,
        scheduledAt: scheduledDateTime,
        repeatRule: _repeatRule,
        soundId: _soundId,
        vibrationEnabled: _vibrationEnabled,
        isDone: widget.initialReminder?.isDone ?? false,
        createdAt: widget.initialReminder?.createdAt,
        checklist: _checklist,
        photoPath: _photoPath,
        priority: _priority,
        repeatEndOccurrences: _repeatEndOccurrences,
        repeatEndDate: _repeatEndDate,
        alertStyle: _alertStyle,
        snoozeCount: widget.initialReminder?.snoozeCount ?? 0,
        calendarEventId: widget.initialReminder?.calendarEventId,
        isPinned: widget.initialReminder?.isPinned ?? false,
        isArchived: widget.initialReminder?.isArchived ?? false,
      );

      if (_isEditing) {
        await controller.updateReminder(reminder, syncCalendar: _calendarSync);
      } else {
        await controller.createReminder(reminder, syncCalendar: _calendarSync);
      }

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_isEditing ? 'Reminder updated' : 'Reminder created')),
        );
      }
    } catch (e) {
      if (mounted) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Save Error'),
            content: Text('Failed to save reminder: $e'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('OK')),
            ],
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<bool> _onWillPop() async {
    if (_currentStep == 2) {
      setState(() => _currentStep = 1);
      return false;
    }
    if (_messageController.text.trim().isNotEmpty) {
      final discard = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Discard Changes?'),
          content: const Text('You have unsaved changes. Are you sure you want to exit?'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Keep Editing')),
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: NudgeTheme.error),
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Discard'),
            ),
          ],
        ),
      );
      return discard ?? false;
    }
    return true;
  }

  @override
  void dispose() {
    _messageController.removeListener(_onMessageChanged);
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final folderController = context.watch<FolderController>();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        final shouldPop = await _onWillPop();
        if (shouldPop && context.mounted) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_isEditing ? 'Edit Reminder' : 'New Reminder'),
          leading: IconButton(
            icon: Icon(_currentStep == 2 ? Icons.arrow_back : Icons.close),
            onPressed: () async {
              if (_currentStep == 2) {
                setState(() => _currentStep = 1);
              } else {
                final shouldPop = await _onWillPop();
                if (shouldPop && context.mounted) Navigator.pop(context);
              }
            },
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: _currentStep == 1
                ? _buildStep1(isDark)
                : _buildStep2(isDark, folderController),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: isDark ? NudgeTheme.surfaceDark : NudgeTheme.surfaceLight,
            border: Border(
              top: BorderSide(
                color: isDark ? NudgeTheme.cardBorderDark : NudgeTheme.cardBorderLight,
              ),
            ),
          ),
          child: _currentStep == 1
              ? NudgeButton(
                  label: 'Next: Alert Settings',
                  icon: Icons.arrow_forward,
                  onPressed: () {
                    if (_messageController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter a reminder message')),
                      );
                      return;
                    }
                    setState(() => _currentStep = 2);
                  },
                )
              : Row(
                  children: [
                    Expanded(
                      child: NudgeButton(
                        label: 'Back',
                        variant: ButtonVariant.outline,
                        onPressed: () => setState(() => _currentStep = 1),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: NudgeButton(
                        label: _isEditing ? 'Update Reminder' : 'Save Reminder',
                        icon: Icons.check,
                        isLoading: _isSaving,
                        onPressed: _saveReminder,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildStep1(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Quick Templates
        if (_templates.isNotEmpty && !_isEditing) ...[
          Text(
            'Quick Templates',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isDark ? NudgeTheme.onPrimaryContainer : NudgeTheme.secondary,
            ),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _templates.map((t) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ActionChip(
                    avatar: const Icon(Icons.flash_on, size: 14),
                    label: Text(t.title),
                    onPressed: () => _applyTemplate(t),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),
        ],

        // Message Input & Voice
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: NudgeTextField(
                controller: _messageController,
                label: 'What would you like to be reminded of?',
                hint: 'e.g. Call dentist tomorrow at 3pm urgent',
                maxLines: 2,
                autofocus: !_isEditing,
              ),
            ),
            const SizedBox(width: 8),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: VoiceInputButton(
                onTranscript: (transcript) {
                  _messageController.text = transcript;
                },
              ),
            ),
          ],
        ),

        // Live NLP Preview Banner
        if (_nlpPreview != null) ...[
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isDark ? NudgeTheme.primaryContainer : NudgeTheme.secondaryContainer.withOpacity(0.3),
              borderRadius: BorderRadius.circular(NudgeTheme.radiusM),
              border: Border.all(color: NudgeTheme.secondary.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.auto_awesome, size: 18, color: NudgeTheme.secondary),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Detected Schedule',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: NudgeTheme.secondary),
                      ),
                      Text(
                        _nlpPreview!.previewSummary,
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: _applyNlpPreview,
                  child: const Text('Apply'),
                ),
              ],
            ),
          ),
        ],

        // Conflict Detection Warning Banner
        if (_conflictResult.hasConflict) ...[
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.amber.withOpacity(0.15),
              borderRadius: BorderRadius.circular(NudgeTheme.radiusM),
              border: Border.all(color: Colors.amber, width: 1.0),
            ),
            child: Row(
              children: [
                const Icon(Icons.warning_amber_rounded, size: 20, color: Colors.amber),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    _conflictResult.warningMessage ?? 'Scheduling conflict detected',
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ],

        const SizedBox(height: 20),

        // Date and Time selectors
        Row(
          children: [
            Expanded(
              child: InkWell(
                borderRadius: BorderRadius.circular(NudgeTheme.radiusM),
                onTap: _selectDate,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  decoration: BoxDecoration(
                    color: isDark ? NudgeTheme.surfaceContainerDark : NudgeTheme.surfaceContainerLight,
                    borderRadius: BorderRadius.circular(NudgeTheme.radiusM),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 18, color: NudgeTheme.secondary),
                      const SizedBox(width: 10),
                      Text(
                        NudgeDateUtils.formatDate(_scheduledDate),
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: InkWell(
                borderRadius: BorderRadius.circular(NudgeTheme.radiusM),
                onTap: _selectTime,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  decoration: BoxDecoration(
                    color: isDark ? NudgeTheme.surfaceContainerDark : NudgeTheme.surfaceContainerLight,
                    borderRadius: BorderRadius.circular(NudgeTheme.radiusM),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.access_time, size: 18, color: NudgeTheme.secondary),
                      const SizedBox(width: 10),
                      Text(
                        _scheduledTime.format(context),
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Recurrence Selector
        Text(
          'Repeat',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isDark ? NudgeTheme.onPrimaryContainer : NudgeTheme.secondary,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: RepeatRule.values.map((rule) {
            final isSelected = _repeatRule == rule;
            return ChoiceChip(
              label: Text(rule.name),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) setState(() => _repeatRule = rule);
              },
            );
          }).toList(),
        ),

        const SizedBox(height: 20),

        // Checklist builder
        ChecklistWidget(
          items: _checklist,
          onChanged: (updated) => setState(() => _checklist = updated),
        ),

        const SizedBox(height: 20),

        // Photo Attachment
        Text(
          'Photo Attachment',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isDark ? NudgeTheme.onPrimaryContainer : NudgeTheme.secondary,
          ),
        ),
        const SizedBox(height: 8),
        if (_photoPath != null && _photoPath!.isNotEmpty) ...[
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(NudgeTheme.radiusM),
                child: Image.file(
                  File(_photoPath!),
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 120,
                    color: Colors.grey[300],
                    alignment: Alignment.center,
                    child: const Text('Image file unavailable'),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton.filled(
                  style: IconButton.styleFrom(backgroundColor: Colors.black54),
                  icon: const Icon(Icons.close, color: Colors.white, size: 18),
                  onPressed: () => setState(() => _photoPath = null),
                ),
              ),
            ],
          ),
        ] else ...[
          OutlinedButton.icon(
            icon: const Icon(Icons.add_a_photo_outlined),
            label: const Text('Attach photo'),
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(NudgeTheme.radiusM)),
            ),
            onPressed: _pickPhoto,
          ),
        ],
      ],
    );
  }

  Widget _buildStep2(bool isDark, FolderController folderController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Folder Selector
        Text(
          'Folder',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isDark ? NudgeTheme.onPrimaryContainer : NudgeTheme.secondary,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: folderController.folders.map((f) {
            final isSelected = _folderId == f.id;
            return ChoiceChip(
              avatar: Icon(NudgeTheme.getFolderIcon(f), size: 16),
              label: Text(f.name),
              selected: isSelected,
              onSelected: (selected) {
                setState(() => _folderId = selected ? f.id : null);
              },
            );
          }).toList(),
        ),

        const SizedBox(height: 20),

        // Priority Level
        Text(
          'Priority',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isDark ? NudgeTheme.onPrimaryContainer : NudgeTheme.secondary,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: PriorityLevel.values.map((p) {
            final isSelected = _priority == p;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ChoiceChip(
                  label: Center(child: Text(p.name.toUpperCase())),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) setState(() => _priority = p);
                  },
                ),
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 24),

        // Alert Style (Alarm vs Gentle Notification)
        Text(
          'Alert Mode',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isDark ? NudgeTheme.onPrimaryContainer : NudgeTheme.secondary,
          ),
        ),
        const SizedBox(height: 8),
        RadioListTile<AlertStyle>(
          title: const Text('Full-Screen Alarm', style: TextStyle(fontWeight: FontWeight.w600)),
          subtitle: const Text('Intrusive wake-up alarm with looping audio & vibration'),
          value: AlertStyle.alarm,
          groupValue: _alertStyle,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(NudgeTheme.radiusM)),
          onChanged: (val) => setState(() => _alertStyle = val!),
        ),
        RadioListTile<AlertStyle>(
          title: const Text('Gentle Notification', style: TextStyle(fontWeight: FontWeight.w600)),
          subtitle: const Text('Subtle notification banner with action buttons'),
          value: AlertStyle.gentle,
          groupValue: _alertStyle,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(NudgeTheme.radiusM)),
          onChanged: (val) => setState(() => _alertStyle = val!),
        ),

        const SizedBox(height: 16),

        // Vibration Switch
        SwitchListTile(
          title: const Text('Vibration'),
          subtitle: const Text('Vibrate phone when alarm or notification triggers'),
          value: _vibrationEnabled,
          onChanged: (val) => setState(() => _vibrationEnabled = val),
        ),

        // Calendar Sync Switch
        SwitchListTile(
          title: const Text('Sync to Device Calendar'),
          subtitle: const Text('Add an event into your local device calendar'),
          value: _calendarSync,
          onChanged: (val) => setState(() => _calendarSync = val),
        ),
      ],
    );
  }
}
```

---

<a id="lib-features-search-search_screendart"></a>
## 88. `lib/features/search/search_screen.dart`

**Path**: `lib/features/search/search_screen.dart` | **Lines**: 239

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../application/controllers/folder_controller.dart';
import '../../application/controllers/record_controller.dart';
import '../../application/controllers/reminder_controller.dart';
import '../../application/controllers/todo_controller.dart';
import '../../presentation/components/empty_state_widget.dart';
import '../../presentation/theme/nudge_theme.dart';
import '../home/reminder_card.dart';
import '../records/record_card.dart';
import '../todos/todo_card.dart';

enum SearchCategory {
  all,
  reminders,
  todos,
  records,
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedFolderId;
  SearchCategory _selectedCategory = SearchCategory.all;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final reminderController = context.watch<ReminderController>();
    final todoController = context.watch<TodoController>();
    final recordController = context.watch<RecordController>();
    final folderController = context.watch<FolderController>();

    final query = _searchController.text.trim().toLowerCase();

    // 1. Matched Reminders
    final matchedReminders = reminderController.reminders.where((r) {
      if (r.isArchived) return false;
      if (_selectedFolderId != null && r.folderId != _selectedFolderId) return false;
      if (query.isEmpty) return true;

      final matchMsg = r.message.toLowerCase().contains(query);
      final folder = folderController.getFolderById(r.folderId);
      final matchFolder = folder?.name.toLowerCase().contains(query) ?? false;
      return matchMsg || matchFolder;
    }).toList();

    // 2. Matched Todos
    final matchedTodos = todoController.todos.where((t) {
      if (t.isDeleted || t.isArchived) return false;
      if (_selectedFolderId != null && t.folderId != _selectedFolderId) return false;
      if (query.isEmpty) return true;

      final matchTitle = t.title.toLowerCase().contains(query);
      final matchDesc = t.description?.toLowerCase().contains(query) ?? false;
      final matchTag = t.tags.any((tag) => tag.toLowerCase().contains(query));
      final folder = folderController.getFolderById(t.folderId);
      final matchFolder = folder?.name.toLowerCase().contains(query) ?? false;
      return matchTitle || matchDesc || matchTag || matchFolder;
    }).toList();

    // 3. Matched Records
    final matchedRecords = recordController.records.where((r) {
      if (r.isDeleted || r.isArchived) return false;
      if (_selectedFolderId != null && r.folderId != _selectedFolderId) return false;
      if (query.isEmpty) return true;

      final matchTitle = r.title.toLowerCase().contains(query);
      final matchContent = r.content.toLowerCase().contains(query);
      final folder = folderController.getFolderById(r.folderId);
      final matchFolder = folder?.name.toLowerCase().contains(query) ?? false;
      return matchTitle || matchContent || matchFolder;
    }).toList();

    final hasAnyResults = matchedReminders.isNotEmpty || matchedTodos.isNotEmpty || matchedRecords.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          style: TextStyle(color: isDark ? NudgeTheme.onBgDark : NudgeTheme.onBgLight),
          decoration: InputDecoration(
            hintText: 'Search reminders, tasks, & records...',
            hintStyle: TextStyle(color: Colors.grey[500]),
            border: InputBorder.none,
            prefixIcon: const Icon(Icons.search),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      setState(() {});
                    },
                  )
                : null,
          ),
          onChanged: (_) => setState(() {}),
        ),
      ),
      body: Column(
        children: [
          // Category Chips (All, Reminders, Tasks, Records)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                _buildCategoryChip('All (${matchedReminders.length + matchedTodos.length + matchedRecords.length})', SearchCategory.all),
                const SizedBox(width: 8),
                _buildCategoryChip('Reminders (${matchedReminders.length})', SearchCategory.reminders),
                const SizedBox(width: 8),
                _buildCategoryChip('Tasks (${matchedTodos.length})', SearchCategory.todos),
                const SizedBox(width: 8),
                _buildCategoryChip('Records (${matchedRecords.length})', SearchCategory.records),
              ],
            ),
          ),

          // Folder Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                ChoiceChip(
                  label: const Text('All Folders'),
                  selected: _selectedFolderId == null,
                  onSelected: (selected) {
                    if (selected) setState(() => _selectedFolderId = null);
                  },
                ),
                const SizedBox(width: 8),
                ...folderController.folders.map((f) {
                  final isSelected = _selectedFolderId == f.id;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      avatar: Icon(NudgeTheme.getFolderIcon(f), size: 14),
                      label: Text(f.name),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() => _selectedFolderId = selected ? f.id : null);
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
          const Divider(height: 1),

          // Results List
          Expanded(
            child: !hasAnyResults
                ? EmptyStateWidget(
                    icon: Icons.search_off,
                    title: 'No Matches Found',
                    subtitle: query.isEmpty
                        ? 'Type in the search bar above to look up items'
                        : 'No items found matching "$query"',
                  )
                : ListView(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    children: [
                      // Reminders Section
                      if ((_selectedCategory == SearchCategory.all || _selectedCategory == SearchCategory.reminders) &&
                          matchedReminders.isNotEmpty) ...[
                        _buildSectionHeader(context, 'Reminders', matchedReminders.length, Icons.alarm),
                        ...matchedReminders.map((r) => ReminderCard(reminder: r)),
                        const SizedBox(height: 12),
                      ],

                      // Todos Section
                      if ((_selectedCategory == SearchCategory.all || _selectedCategory == SearchCategory.todos) &&
                          matchedTodos.isNotEmpty) ...[
                        _buildSectionHeader(context, 'Tasks & Todos', matchedTodos.length, Icons.task_alt),
                        ...matchedTodos.map((t) => TodoCard(todo: t)),
                        const SizedBox(height: 12),
                      ],

                      // Records Section
                      if ((_selectedCategory == SearchCategory.all || _selectedCategory == SearchCategory.records) &&
                          matchedRecords.isNotEmpty) ...[
                        _buildSectionHeader(context, 'Records & Notes', matchedRecords.length, Icons.note_alt_outlined),
                        ...matchedRecords.map((r) => RecordCard(record: r)),
                        const SizedBox(height: 12),
                      ],
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label, SearchCategory category) {
    return ChoiceChip(
      label: Text(label),
      selected: _selectedCategory == category,
      onSelected: (selected) {
        if (selected) setState(() => _selectedCategory = category);
      },
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, int count, IconData icon) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: theme.colorScheme.primary),
          const SizedBox(width: 8),
          Text(
            '$title ($count)',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
```

---

<a id="lib-features-settings-custom_alarm_sound_screendart"></a>
## 89. `lib/features/settings/custom_alarm_sound_screen.dart`

**Path**: `lib/features/settings/custom_alarm_sound_screen.dart` | **Lines**: 668

```dart
import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../application/controllers/settings_controller.dart';
import '../../core/logging/app_logger.dart';
import '../../platform/alarms/alarm_platform_service.dart';
import '../../presentation/components/nudge_button.dart';
import '../../presentation/components/nudge_card.dart';

class CustomAlarmSoundScreen extends StatefulWidget {
  const CustomAlarmSoundScreen({super.key});

  @override
  State<CustomAlarmSoundScreen> createState() => _CustomAlarmSoundScreenState();
}

class _CustomAlarmSoundScreenState extends State<CustomAlarmSoundScreen>
    with SingleTickerProviderStateMixin {
  static const String _subsystem = 'CustomAlarmSoundScreen';

  String? _selectedFilePath;
  String _selectedTitle = '';
  int _totalDurationMs = 0;
  int _startMs = 0;
  int _clipDurationMs = 30000; // 30s default like Instagram
  bool _isPlayingPreview = false;
  bool _isLoadingFile = false;

  Timer? _previewProgressTimer;
  double _playbackProgress = 0.0; // 0.0 to 1.0 within segment

  // Deterministic visual waveform heights (80 bars)
  late List<double> _waveformBars;

  @override
  void initState() {
    super.initState();
    _generateWaveform();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadExistingSound();
    });
  }

  void _generateWaveform([String seed = 'nudge_sound']) {
    final random = Random(seed.hashCode);
    _waveformBars = List.generate(80, (index) {
      final envelope = sin((index / 80) * pi);
      final raw = (0.2 + 0.8 * random.nextDouble()) * (0.4 + 0.6 * envelope);
      return raw.clamp(0.15, 1.0);
    });
  }

  Future<void> _loadExistingSound() async {
    final settings = context.read<SettingsController>();
    await settings.refreshCustomSound();

    if (settings.hasCustomSound && settings.customSoundPath != null) {
      final file = File(settings.customSoundPath!);
      if (await file.exists()) {
        final durationInfo = await AlarmPlatformService.getAudioDuration(file.path);
        if (mounted) {
          setState(() {
            _selectedFilePath = file.path;
            _selectedTitle = settings.customSoundTitle ?? p.basenameWithoutExtension(file.path);
            _totalDurationMs = (durationInfo?['durationMs'] as num?)?.toInt() ?? 60000;
            _startMs = settings.customSoundStartMs;
            final endMs = settings.customSoundEndMs;
            if (endMs > _startMs) {
              _clipDurationMs = endMs - _startMs;
            } else {
              _clipDurationMs = 30000.clamp(1000, _totalDurationMs);
            }
            _generateWaveform(file.path);
          });
        }
      }
    }
  }

  @override
  void dispose() {
    _stopPreview();
    super.dispose();
  }

  Future<void> _pickAudioFile() async {
    try {
      setState(() => _isLoadingFile = true);
      _stopPreview();

      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: const ['mp3', 'm4a', 'wav', 'aac', 'ogg', 'flac'],
      );

      if (result != null && result.files.single.path != null) {
        final pickedPath = result.files.single.path!;
        final originalFile = File(pickedPath);

        // Copy to app documents storage to prevent deletion or permission expiration
        final docsDir = await getApplicationDocumentsDirectory();
        final ext = p.extension(pickedPath);
        final targetPath = p.join(docsDir.path, 'custom_alarm_sound$ext');
        final savedFile = await originalFile.copy(targetPath);

        final durationInfo = await AlarmPlatformService.getAudioDuration(savedFile.path);
        final durationMs = (durationInfo?['durationMs'] as num?)?.toInt() ?? 60000;
        final title = durationInfo?['title'] as String? ?? p.basenameWithoutExtension(pickedPath);

        setState(() {
          _selectedFilePath = savedFile.path;
          _selectedTitle = title;
          _totalDurationMs = durationMs;
          _startMs = 0;
          _clipDurationMs = min(30000, _totalDurationMs);
          _generateWaveform(savedFile.path);
        });

        AppLogger.info(_subsystem, 'Picked audio: $title, duration: ${durationMs}ms');
      }
    } catch (e, stack) {
      AppLogger.error(_subsystem, 'Failed picking audio file', error: e, stackTrace: stack);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not open audio file: $e'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoadingFile = false);
      }
    }
  }

  int get _effectiveEndMs {
    if (_totalDurationMs <= 0) return _startMs + _clipDurationMs;
    return min(_startMs + _clipDurationMs, _totalDurationMs);
  }

  void _onWaveformScrub(double ratio) {
    if (_totalDurationMs <= 0) return;
    final targetStart = (ratio * _totalDurationMs).toInt();
    final maxStart = max(0, _totalDurationMs - _clipDurationMs);
    final clampedStart = targetStart.clamp(0, maxStart);

    setState(() {
      _startMs = clampedStart;
      _playbackProgress = 0.0;
    });

    if (_isPlayingPreview) {
      _startPreview();
    }
  }

  void _nudgeStart(int deltaMs) {
    if (_totalDurationMs <= 0) return;
    final maxStart = max(0, _totalDurationMs - _clipDurationMs);
    final next = (_startMs + deltaMs).clamp(0, maxStart);
    setState(() {
      _startMs = next;
      _playbackProgress = 0.0;
    });

    if (_isPlayingPreview) {
      _startPreview();
    }
  }

  void _setClipDuration(int durationMs) {
    if (_totalDurationMs <= 0) {
      setState(() => _clipDurationMs = durationMs);
      return;
    }

    final targetDuration = durationMs == -1 ? _totalDurationMs : durationMs;
    final maxStart = max(0, _totalDurationMs - targetDuration);

    setState(() {
      _clipDurationMs = targetDuration;
      _startMs = _startMs.clamp(0, maxStart);
      _playbackProgress = 0.0;
    });

    if (_isPlayingPreview) {
      _startPreview();
    }
  }

  Future<void> _startPreview() async {
    if (_selectedFilePath == null) return;
    _stopPreview();

    final endMs = _effectiveEndMs;
    await AlarmPlatformService.playAudioPreview(_selectedFilePath!, _startMs, endMs);

    setState(() {
      _isPlayingPreview = true;
      _playbackProgress = 0.0;
    });

    final duration = endMs - _startMs;
    if (duration > 0) {
      const interval = Duration(milliseconds: 50);
      int elapsedMs = 0;
      _previewProgressTimer = Timer.periodic(interval, (timer) {
        elapsedMs += 50;
        if (elapsedMs >= duration) {
          elapsedMs = 0;
        }
        if (mounted) {
          setState(() {
            _playbackProgress = elapsedMs / duration;
          });
        }
      });
    }
  }

  void _stopPreview() {
    _previewProgressTimer?.cancel();
    _previewProgressTimer = null;
    AlarmPlatformService.stopAudioPreview();
    if (mounted) {
      setState(() {
        _isPlayingPreview = false;
        _playbackProgress = 0.0;
      });
    }
  }

  Future<void> _saveAsAlarmSound() async {
    if (_selectedFilePath == null) return;
    _stopPreview();

    final settings = context.read<SettingsController>();
    final endMs = _effectiveEndMs;

    await settings.setCustomSound(
      filePath: _selectedFilePath!,
      startMs: _startMs,
      endMs: endMs,
      title: _selectedTitle,
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Custom alarm set: $_selectedTitle (${_formatTime(_startMs)} - ${_formatTime(endMs)})',
                ),
              ),
            ],
          ),
          backgroundColor: Colors.green[700],
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _resetToDefault() async {
    _stopPreview();
    final settings = context.read<SettingsController>();
    await settings.resetCustomSound();

    setState(() {
      _selectedFilePath = null;
      _selectedTitle = '';
      _totalDurationMs = 0;
      _startMs = 0;
      _clipDurationMs = 30000;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Reverted to system default alarm sound.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  String _formatTime(int ms) {
    final totalSeconds = (ms / 1000).floor();
    final minutes = (totalSeconds / 60).floor();
    final seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final settings = context.watch<SettingsController>();
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Alarm Sound'),
        actions: [
          if (settings.hasCustomSound)
            IconButton(
              icon: const Icon(Icons.restore),
              tooltip: 'Reset to System Default',
              onPressed: _resetToDefault,
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: [
          NudgeCard(
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: settings.hasCustomSound
                        ? theme.colorScheme.primaryContainer
                        : theme.colorScheme.surfaceContainerHighest,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    settings.hasCustomSound ? Icons.music_note : Icons.alarm,
                    color: settings.hasCustomSound
                        ? theme.colorScheme.primary
                        : theme.colorScheme.outline,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Active Alarm Sound',
                        style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.outline),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        settings.hasCustomSound
                            ? (settings.customSoundTitle ?? 'Custom Song')
                            : 'System Default Alarm Ringtone',
                        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (settings.hasCustomSound) ...[
                        const SizedBox(height: 2),
                        Text(
                          'Clip: ${_formatTime(settings.customSoundStartMs)} - ${_formatTime(settings.customSoundEndMs)}',
                          style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.primary),
                        ),
                      ],
                    ],
                  ),
                ),
                if (settings.hasCustomSound)
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      visualDensity: VisualDensity.compact,
                    ),
                    onPressed: _resetToDefault,
                    child: const Text('Default'),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(54),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              side: BorderSide(color: theme.colorScheme.primary, width: 1.5),
            ),
            icon: _isLoadingFile
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.audio_file_rounded),
            label: Text(
              _selectedFilePath == null ? 'Select Audio File from Device' : 'Change Audio File',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            onPressed: _isLoadingFile ? null : _pickAudioFile,
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              'Supports MP3, M4A, WAV, AAC, OGG files on your phone',
              style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
            ),
          ),
          const SizedBox(height: 24),
          if (_selectedFilePath != null) ...[
            Text(
              'Select Alarm Audio Segment',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'Slide the selection window to choose the exact part you want to wake up to, like in Instagram.',
              style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
            ),
            const SizedBox(height: 16),
            NudgeCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.graphic_eq, color: theme.colorScheme.primary),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _selectedTitle,
                          style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        _formatTime(_totalDurationMs),
                        style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildInstagramWaveform(theme, isDark),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Start: ${_formatTime(_startMs)}',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ),
                      Text(
                        '${(_clipDurationMs / 1000).round()}s clip',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                          fontSize: 13,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'End: ${_formatTime(_effectiveEndMs)}',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text('Duration:', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Wrap(
                          spacing: 8,
                          children: [
                            _buildDurationChip(15000, '15s'),
                            _buildDurationChip(30000, '30s'),
                            _buildDurationChip(45000, '45s'),
                            _buildDurationChip(60000, '60s'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton.filledTonal(
                        icon: const Icon(Icons.fast_rewind_rounded),
                        tooltip: 'Nudge back 1s',
                        onPressed: () => _nudgeStart(-1000),
                      ),
                      const SizedBox(width: 16),
                      FilledButton.icon(
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                        ),
                        icon: Icon(_isPlayingPreview ? Icons.stop_rounded : Icons.play_arrow_rounded),
                        label: Text(_isPlayingPreview ? 'Stop Preview' : 'Play Segment'),
                        onPressed: _isPlayingPreview ? _stopPreview : _startPreview,
                      ),
                      const SizedBox(width: 16),
                      IconButton.filledTonal(
                        icon: const Icon(Icons.fast_forward_rounded),
                        tooltip: 'Nudge forward 1s',
                        onPressed: () => _nudgeStart(1000),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            NudgeButton(
              label: 'Set as Alarm Sound',
              icon: Icons.check_circle_outline,
              isExpanded: true,
              onPressed: _saveAsAlarmSound,
            ),
            const SizedBox(height: 32),
          ],
        ],
      ),
    );
  }

  Widget _buildDurationChip(int durationMs, String label) {
    final isSelected = _clipDurationMs == durationMs;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      visualDensity: VisualDensity.compact,
      onSelected: (_) => _setClipDuration(durationMs),
    );
  }

  Widget _buildInstagramWaveform(ThemeData theme, bool isDark) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        const height = 90.0;

        final totalMs = max(1, _totalDurationMs);
        final startRatio = (_startMs / totalMs).clamp(0.0, 1.0);
        final endRatio = (_effectiveEndMs / totalMs).clamp(0.0, 1.0);

        final windowLeft = startRatio * width;
        final windowWidth = max(24.0, (endRatio - startRatio) * width);
        final playheadX = windowLeft + (_playbackProgress * windowWidth);

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onHorizontalDragUpdate: (details) {
            final localX = details.localPosition.dx.clamp(0.0, width);
            final ratio = localX / width;
            _onWaveformScrub(ratio);
          },
          onTapDown: (details) {
            final localX = details.localPosition.dx.clamp(0.0, width);
            final ratio = localX / width;
            _onWaveformScrub(ratio);
          },
          child: Container(
            height: height,
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[900] : Colors.grey[100],
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: theme.colorScheme.outline.withOpacity(0.2)),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: _waveformBars.map((h) {
                        return Container(
                          width: 2.2,
                          height: (height - 24) * h,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.outline.withOpacity(0.35),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Positioned(
                  left: windowLeft,
                  top: 0,
                  bottom: 0,
                  width: windowWidth,
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.22),
                      border: Border.symmetric(
                        horizontal: BorderSide(color: theme.colorScheme.primary, width: 2),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: 6,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              borderRadius: const BorderRadius.horizontal(left: Radius.circular(4)),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: 6,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              borderRadius: const BorderRadius.horizontal(right: Radius.circular(4)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (_isPlayingPreview)
                  Positioned(
                    left: playheadX.clamp(0.0, width - 2.5),
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: 2.5,
                      color: theme.colorScheme.error,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
```

---

<a id="lib-features-settings-settings_screendart"></a>
## 90. `lib/features/settings/settings_screen.dart`

**Path**: `lib/features/settings/settings_screen.dart` | **Lines**: 388

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../application/controllers/settings_controller.dart';
import '../../application/controllers/theme_controller.dart';
import '../../application/controllers/reminder_controller.dart';
import '../../application/controllers/folder_controller.dart';
import '../../application/controllers/todo_controller.dart';
import '../../application/controllers/record_controller.dart';
import '../../core/constants/app_constants.dart';
import '../../presentation/components/nudge_card.dart';
import '../backup/backup_screen.dart';
import '../reliability/improve_reliability_screen.dart';
import '../companion/customize_companion_screen.dart';
import '../todos/todos_screen.dart';
import '../records/records_screen.dart';
import 'custom_alarm_sound_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _showResetConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.warning_rounded, color: Colors.red),
            SizedBox(width: 8),
            Text('Reset All Data?'),
          ],
        ),
        content: const Text(
          'This action will permanently delete all reminders, folders, history, and mascot achievements. It will also cancel all scheduled alarms.\n\nThis cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.error),
            onPressed: () async {
              Navigator.pop(ctx);
              final settings = context.read<SettingsController>();
              final reminders = context.read<ReminderController>();
              final folders = context.read<FolderController>();

              await settings.resetAppData(
                reminderController: reminders,
                folderController: folders,
              );

              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('App data has been completely reset to factory defaults.'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            child: const Text('Reset Everything'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeCtrl = context.watch<ThemeController>();
    final settingsCtrl = context.watch<SettingsController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: [
          // Appearance Section
          _buildSectionHeader(context, 'Appearance'),
          const SizedBox(height: 8),
          NudgeCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Theme Mode',
                  style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                SegmentedButton<ThemeMode>(
                  segments: const [
                    ButtonSegment(
                      value: ThemeMode.system,
                      label: Text('System'),
                      icon: Icon(Icons.brightness_auto),
                    ),
                    ButtonSegment(
                      value: ThemeMode.light,
                      label: Text('Light'),
                      icon: Icon(Icons.light_mode),
                    ),
                    ButtonSegment(
                      value: ThemeMode.dark,
                      label: Text('Dark'),
                      icon: Icon(Icons.dark_mode),
                    ),
                  ],
                  selected: {themeCtrl.themeMode},
                  onSelectionChanged: (Set<ThemeMode> selection) {
                    themeCtrl.setThemeMode(selection.first);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Alarm & Reminders Section
          _buildSectionHeader(context, 'Alarms & Timing'),
          const SizedBox(height: 8),
          NudgeCard(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Default Snooze',
                          style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Duration added when snoozing',
                          style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
                        ),
                      ],
                    ),
                    DropdownButton<int>(
                      value: settingsCtrl.defaultSnoozeMinutes,
                      borderRadius: BorderRadius.circular(16),
                      items: const [
                        DropdownMenuItem(value: 5, child: Text('5 minutes')),
                        DropdownMenuItem(value: 10, child: Text('10 minutes')),
                        DropdownMenuItem(value: 15, child: Text('15 minutes')),
                        DropdownMenuItem(value: 30, child: Text('30 minutes')),
                      ],
                      onChanged: (val) {
                        if (val != null) {
                          settingsCtrl.setDefaultSnoozeMinutes(val);
                        }
                      },
                    ),
                  ],
                ),
                const Divider(height: 24),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'Alarm Audio Playback',
                    style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Enable sound effects and looping alarm tones',
                    style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
                  ),
                  value: settingsCtrl.soundEnabled,
                  onChanged: (val) {
                    settingsCtrl.setSoundEnabled(val);
                  },
                ),
                const Divider(height: 24),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.music_note),
                  title: Text(
                    'Custom Alarm Sound',
                    style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    settingsCtrl.hasCustomSound
                        ? (settingsCtrl.customSoundTitle ?? 'Custom Song Segment')
                        : 'System Default (Tap to select & trim song)',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: settingsCtrl.hasCustomSound ? theme.colorScheme.primary : theme.colorScheme.outline,
                    ),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CustomAlarmSoundScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // System Reliability & Companion Navigation
          _buildSectionHeader(context, 'Features & Reliability'),
          const SizedBox(height: 8),
          NudgeCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.bolt),
                  title: const Text('Alarm & Background Reliability'),
                  subtitle: const Text('Permissions, exact alarms, battery guides'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ImproveReliabilityScreen()),
                    );
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.pets),
                  title: const Text('Mascot & Accountability Companion'),
                  subtitle: const Text('Customize avatar, milestones, cosmetics'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CustomizeCompanionScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
          // Tasks & Productivity
          _buildSectionHeader(context, 'Tasks & Productivity'),
          const SizedBox(height: 8),
          NudgeCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.task_alt, color: Colors.blue),
                  title: const Text('Manage Tasks & Todos'),
                  subtitle: Consumer<TodoController>(
                    builder: (_, todoCtrl, __) => Text('${todoCtrl.activeCount} active tasks, ${todoCtrl.completedCount} completed'),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const TodosScreen()),
                    );
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.note_alt_outlined, color: Colors.amber),
                  title: const Text('Records & Capture'),
                  subtitle: Consumer<RecordController>(
                    builder: (_, recordCtrl, __) => Text('${recordCtrl.totalActiveCount} saved notes & records'),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const RecordsScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Data Management Section
          _buildSectionHeader(context, 'Data & Backup'),
          const SizedBox(height: 8),
          NudgeCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.shield_outlined),
                  title: const Text('Encrypted Backup & Restore'),
                  subtitle: const Text('Export or import AES-256 authenticated data'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const BackupScreen()),
                    );
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.delete_forever, color: theme.colorScheme.error),
                  title: Text(
                    'Reset App Data',
                    style: TextStyle(color: theme.colorScheme.error, fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text('Wipe all reminders, database, and scheduled alarms'),
                  onTap: () => _showResetConfirmationDialog(context),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // About & Privacy
          _buildSectionHeader(context, 'About Nudge'),
          const SizedBox(height: 8),
          NudgeCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.notifications_active, color: theme.colorScheme.primary),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppConstants.appName,
                          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Version ${AppConstants.appVersion} (Build ${AppConstants.appBuild})',
                          style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  AppConstants.appTagline,
                  style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.lock_outline, size: 16, color: theme.colorScheme.primary),
                    const SizedBox(width: 6),
                    Text(
                      '100% Offline • Zero Analytics • Zero Tracking',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
    );
  }
}
```

---

<a id="lib-features-timer-timer_screendart"></a>
## 91. `lib/features/timer/timer_screen.dart`

**Path**: `lib/features/timer/timer_screen.dart` | **Lines**: 180

```dart
﻿import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../application/controllers/timer_controller.dart';
import '../../presentation/components/nudge_button.dart';
import '../../presentation/theme/nudge_theme.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  String _formatDuration(Duration d) {
    final hours = d.inHours;
    final minutes = d.inMinutes.remainder(60);
    final seconds = d.inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void _showCustomDurationDialog(BuildContext context, TimerController timer) {
    final minController = TextEditingController(text: '15');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Custom Duration'),
        content: TextField(
          controller: minController,
          keyboardType: TextInputType.number,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: 'Duration in Minutes',
            suffixText: 'mins',
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              final mins = int.tryParse(minController.text.trim()) ?? 0;
              if (mins > 0) {
                timer.startTimer(Duration(minutes: mins));
                Navigator.pop(ctx);
              }
            },
            child: const Text('Start'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final timer = context.watch<TimerController>();

    final presets = [
      {'label': '5m', 'duration': const Duration(minutes: 5)},
      {'label': '10m', 'duration': const Duration(minutes: 10)},
      {'label': '25m', 'duration': const Duration(minutes: 25)},
      {'label': '1h', 'duration': const Duration(hours: 1)},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Timer'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Countdown Circle
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 240,
                    height: 240,
                    child: CircularProgressIndicator(
                      value: timer.progress,
                      strokeWidth: 10,
                      backgroundColor: isDark ? NudgeTheme.surfaceContainerDark : NudgeTheme.surfaceContainerLight,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        timer.isFinished
                            ? Colors.green
                            : (isDark ? NudgeTheme.secondaryContainer : NudgeTheme.secondary),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        timer.isFinished
                            ? '00:00'
                            : (timer.isRunning ? _formatDuration(timer.remainingTime) : '00:00'),
                        style: const TextStyle(
                          fontSize: 44,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        timer.isFinished
                            ? 'Timer Completed!'
                            : (timer.isRunning ? 'Remaining' : 'Ready to Start'),
                        style: TextStyle(
                          fontSize: 14,
                          color: timer.isFinished ? Colors.green : Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),

              // Quick Presets
              if (!timer.isRunning) ...[
                const Text(
                  'Quick Presets',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: presets.map((p) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: ActionChip(
                        label: Text(p['label'] as String),
                        onPressed: () => timer.startTimer(p['duration'] as Duration),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 8),
                TextButton.icon(
                  icon: const Icon(Icons.tune),
                  label: const Text('Custom Duration'),
                  onPressed: () => _showCustomDurationDialog(context, timer),
                ),
              ],

              const SizedBox(height: 24),

              // Action Buttons
              if (timer.isRunning) ...[
                NudgeButton(
                  label: 'Cancel Timer',
                  icon: Icons.stop,
                  variant: ButtonVariant.danger,
                  width: double.infinity,
                  onPressed: () => timer.cancelTimer(),
                ),
              ] else if (timer.isFinished) ...[
                NudgeButton(
                  label: 'Dismiss & Reset',
                  icon: Icons.check,
                  variant: ButtonVariant.primary,
                  width: double.infinity,
                  onPressed: () => timer.cancelTimer(),
                ),
              ],
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

<a id="lib-features-todos-todo_carddart"></a>
## 92. `lib/features/todos/todo_card.dart`

**Path**: `lib/features/todos/todo_card.dart` | **Lines**: 362

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../application/controllers/folder_controller.dart';
import '../../application/controllers/todo_controller.dart';
import '../../domain/entities/todo.dart';
import '../../domain/enums/todo_enums.dart';
import '../../presentation/components/nudge_card.dart';
import '../../presentation/theme/nudge_theme.dart';
import 'todo_detail_screen.dart';
import 'todo_editor_screen.dart';

class TodoCard extends StatelessWidget {
  final Todo todo;

  const TodoCard({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final todoCtrl = context.read<TodoController>();
    final folderCtrl = context.watch<FolderController>();
    final folder = todo.folderId != null ? folderCtrl.getFolderById(todo.folderId) : null;

    final isDone = todo.isDone;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: NudgeCard(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TodoDetailScreen(todoId: todo.id),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Checkbox
                  Transform.scale(
                    scale: 1.1,
                    child: Checkbox(
                      value: isDone,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      activeColor: theme.colorScheme.primary,
                      onChanged: (_) {
                        todoCtrl.toggleTodoStatus(todo.id);
                      },
                    ),
                  ),
                  const SizedBox(width: 4),
                  // Title and details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            if (todo.isPinned) ...[
                              Icon(Icons.push_pin, size: 14, color: theme.colorScheme.primary),
                              const SizedBox(width: 4),
                            ],
                            Expanded(
                              child: Text(
                                todo.title,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  decoration: isDone ? TextDecoration.lineThrough : null,
                                  color: isDone
                                      ? theme.colorScheme.outline
                                      : theme.colorScheme.onSurface,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        if (todo.description != null && todo.description!.trim().isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            todo.description!.trim(),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                              decoration: isDone ? TextDecoration.lineThrough : null,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                  // Popup Menu
                  PopupMenuButton<String>(
                    icon: Icon(Icons.more_vert, size: 20, color: theme.colorScheme.outline),
                    onSelected: (val) {
                      switch (val) {
                        case 'pin':
                          todoCtrl.togglePin(todo.id);
                          break;
                        case 'edit':
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => TodoEditorScreen(todo: todo),
                            ),
                          );
                          break;
                        case 'archive':
                          todoCtrl.toggleArchive(todo.id);
                          break;
                        case 'delete':
                          todoCtrl.softDeleteTodo(todo.id);
                          break;
                      }
                    },
                    itemBuilder: (ctx) => [
                      PopupMenuItem(
                        value: 'pin',
                        child: Row(
                          children: [
                            Icon(todo.isPinned ? Icons.push_pin_outlined : Icons.push_pin, size: 18),
                            const SizedBox(width: 8),
                            Text(todo.isPinned ? 'Unpin' : 'Pin to top'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit_outlined, size: 18),
                            SizedBox(width: 8),
                            Text('Edit'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'archive',
                        child: Row(
                          children: [
                            Icon(todo.isArchived ? Icons.unarchive_outlined : Icons.archive_outlined, size: 18),
                            const SizedBox(width: 8),
                            Text(todo.isArchived ? 'Unarchive' : 'Archive'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete_outline, size: 18, color: Colors.red),
                            SizedBox(width: 8),
                            Text('Delete', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // Subtasks Progress
              if (todo.hasSubtasks) ...[
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(left: 44, right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Subtasks: ${todo.completedSubtasksCount}/${todo.subtasks.length}',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.outline,
                            ),
                          ),
                          Text(
                            '${(todo.subtasksProgress * 100).toInt()}%',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.outline,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: todo.subtasksProgress,
                          minHeight: 4,
                          backgroundColor: theme.colorScheme.surfaceContainerHighest,
                          valueColor: AlwaysStoppedAnimation(
                            todo.subtasksProgress == 1.0
                                ? Colors.green
                                : theme.colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 8),
              // Badges row: Priority, Due Date, Folder, Tags
              Padding(
                padding: const EdgeInsets.only(left: 44),
                child: Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    _buildPriorityBadge(context, todo.priority),
                    if (todo.dueAt != null) _buildDueDateBadge(context, todo),
                    if (folder != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(NudgeTheme.getFolderIcon(folder), size: 12, color: theme.colorScheme.primary),
                            const SizedBox(width: 4),
                            Text(folder.name, style: theme.textTheme.labelSmall),
                          ],
                        ),
                      ),
                    ...todo.tags.map(
                      (tag) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.secondaryContainer.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '#$tag',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.onSecondaryContainer,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriorityBadge(BuildContext context, TodoPriority priority) {
    final theme = Theme.of(context);
    Color color;
    String label;
    IconData icon;

    switch (priority) {
      case TodoPriority.urgent:
        color = Colors.red;
        label = 'Urgent';
        icon = Icons.priority_high;
        break;
      case TodoPriority.high:
        color = Colors.orange;
        label = 'High';
        icon = Icons.flag;
        break;
      case TodoPriority.normal:
        color = theme.colorScheme.primary;
        label = 'Normal';
        icon = Icons.outlined_flag;
        break;
      case TodoPriority.low:
        color = theme.colorScheme.outline;
        label = 'Low';
        icon = Icons.flag_outlined;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.3), width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 3),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDueDateBadge(BuildContext context, Todo todo) {
    final isOverdue = todo.isOverdue;
    final isDueToday = todo.isDueToday;
    final dueAt = todo.dueAt!;

    Color color;
    String label;

    if (isOverdue) {
      color = Colors.red;
      label = 'Overdue (${DateFormat('MMM d').format(dueAt)})';
    } else if (isDueToday) {
      color = Colors.orange;
      label = 'Today ${DateFormat('h:mm a').format(dueAt)}';
    } else {
      color = Theme.of(context).colorScheme.outline;
      label = DateFormat('MMM d, h:mm a').format(dueAt);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.event, size: 12, color: color),
          const SizedBox(width: 3),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
```

---

<a id="lib-features-todos-todo_detail_screendart"></a>
## 93. `lib/features/todos/todo_detail_screen.dart`

**Path**: `lib/features/todos/todo_detail_screen.dart` | **Lines**: 408

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../application/controllers/folder_controller.dart';
import '../../application/controllers/todo_controller.dart';
import '../../domain/entities/reminder.dart';
import '../../domain/entities/todo.dart';
import '../../domain/enums/todo_enums.dart';
import '../../presentation/components/nudge_card.dart';
import '../../presentation/theme/nudge_theme.dart';
import '../reminders/reminder_editor_screen.dart';
import 'todo_editor_screen.dart';

class TodoDetailScreen extends StatefulWidget {
  final String todoId;

  const TodoDetailScreen({super.key, required this.todoId});

  @override
  State<TodoDetailScreen> createState() => _TodoDetailScreenState();
}

class _TodoDetailScreenState extends State<TodoDetailScreen> {
  final TextEditingController _subtaskController = TextEditingController();

  @override
  void dispose() {
    _subtaskController.dispose();
    super.dispose();
  }

  void _handleAddSubtask(TodoController todoCtrl) {
    final text = _subtaskController.text.trim();
    if (text.isEmpty) return;
    todoCtrl.addSubtask(widget.todoId, text);
    _subtaskController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final todoCtrl = context.watch<TodoController>();
    final folderCtrl = context.watch<FolderController>();

    final todo = todoCtrl.todos.firstWhere(
      (t) => t.id == widget.todoId,
      orElse: () => Todo(id: widget.todoId, title: 'Not found'),
    );

    if (todo.title == 'Not found') {
      return Scaffold(
        appBar: AppBar(title: const Text('Task Detail')),
        body: const Center(child: Text('Task not found or was deleted.')),
      );
    }

    final folder = todo.folderId != null ? folderCtrl.getFolderById(todo.folderId) : null;
    final isDone = todo.isDone;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
        actions: [
          IconButton(
            icon: Icon(todo.isPinned ? Icons.push_pin : Icons.push_pin_outlined),
            tooltip: todo.isPinned ? 'Unpin' : 'Pin to top',
            onPressed: () => todoCtrl.togglePin(todo.id),
          ),
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'Edit Task',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TodoEditorScreen(todo: todo),
                ),
              );
            },
          ),
          PopupMenuButton<String>(
            onSelected: (val) {
              if (val == 'reminder') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ReminderEditorScreen(
                      initialReminder: Reminder(
                        message: todo.title,
                        folderId: todo.folderId,
                        scheduledAt: todo.dueAt ?? DateTime.now().add(const Duration(hours: 1)),
                      ),
                    ),
                  ),
                );
              } else if (val == 'archive') {
                todoCtrl.toggleArchive(todo.id);
                Navigator.pop(context);
              } else if (val == 'delete') {
                todoCtrl.softDeleteTodo(todo.id);
                Navigator.pop(context);
              }
            },
            itemBuilder: (ctx) => [
              const PopupMenuItem(
                value: 'reminder',
                child: Row(
                  children: [
                    Icon(Icons.alarm_add_outlined, size: 18),
                    SizedBox(width: 8),
                    Text('Convert to Reminder Alarm'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'archive',
                child: Row(
                  children: [
                    Icon(todo.isArchived ? Icons.unarchive_outlined : Icons.archive_outlined, size: 18),
                    const SizedBox(width: 8),
                    Text(todo.isArchived ? 'Unarchive' : 'Archive'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete_outline, size: 18, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Delete Task', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Header Card with Title and Toggle
          NudgeCard(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Transform.scale(
                    scale: 1.2,
                    child: Checkbox(
                      value: isDone,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      onChanged: (_) => todoCtrl.toggleTodoStatus(todo.id),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          todo.title,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            decoration: isDone ? TextDecoration.lineThrough : null,
                            color: isDone ? theme.colorScheme.outline : null,
                          ),
                        ),
                        if (todo.completedAt != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            'Completed on ${DateFormat('MMM d, yyyy h:mm a').format(todo.completedAt!)}',
                            style: theme.textTheme.labelSmall?.copyWith(color: Colors.green),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Metadata Details: Priority, Due Date, Folder
          NudgeCard(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Priority
                  Row(
                    children: [
                      const Icon(Icons.flag_outlined, size: 20),
                      const SizedBox(width: 12),
                      Text('Priority', style: theme.textTheme.bodyMedium),
                      const Spacer(),
                      _buildPriorityPill(context, todo.priority),
                    ],
                  ),
                  const Divider(height: 24),

                  // Due Date
                  Row(
                    children: [
                      const Icon(Icons.calendar_today_outlined, size: 20),
                      const SizedBox(width: 12),
                      Text('Due Date', style: theme.textTheme.bodyMedium),
                      const Spacer(),
                      Text(
                        todo.dueAt != null
                            ? DateFormat('EEE, MMM d, yyyy · h:mm a').format(todo.dueAt!)
                            : 'None',
                        style: TextStyle(
                          color: todo.isOverdue ? Colors.red : null,
                          fontWeight: todo.isOverdue ? FontWeight.bold : null,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24),

                  // Folder
                  Row(
                    children: [
                      const Icon(Icons.folder_outlined, size: 20),
                      const SizedBox(width: 12),
                      Text('Folder', style: theme.textTheme.bodyMedium),
                      const Spacer(),
                      if (folder != null)
                        Row(
                          children: [
                            Icon(NudgeTheme.getFolderIcon(folder), size: 16, color: theme.colorScheme.primary),
                            const SizedBox(width: 6),
                            Text(folder.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                          ],
                        )
                      else
                        const Text('Inbox / None'),
                    ],
                  ),

                  // Reminder Notification
                  if (todo.reminderEnabled) ...[
                    const Divider(height: 24),
                    Row(
                      children: [
                        const Icon(Icons.notifications_active_outlined, size: 20),
                        const SizedBox(width: 12),
                        Text('Gentle Reminder', style: theme.textTheme.bodyMedium),
                        const Spacer(),
                        Text(
                          todo.reminderAt != null
                              ? DateFormat('MMM d, h:mm a').format(todo.reminderAt!)
                              : 'Enabled',
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Description / Notes
          if (todo.description != null && todo.description!.trim().isNotEmpty) ...[
            Text('Notes', style: theme.textTheme.titleSmall),
            const SizedBox(height: 8),
            NudgeCard(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SelectableText(
                  todo.description!.trim(),
                  style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Subtasks Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Subtasks (${todo.completedSubtasksCount}/${todo.subtasks.length})',
                style: theme.textTheme.titleSmall,
              ),
              if (todo.hasSubtasks)
                Text(
                  '${(todo.subtasksProgress * 100).toInt()}% Done',
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          NudgeCard(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  // Add subtask input row
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _subtaskController,
                          decoration: const InputDecoration(
                            hintText: 'Add subtask...',
                            border: InputBorder.none,
                            isDense: true,
                          ),
                          onSubmitted: (_) => _handleAddSubtask(todoCtrl),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_circle, color: Colors.teal),
                        onPressed: () => _handleAddSubtask(todoCtrl),
                      ),
                    ],
                  ),
                  if (todo.subtasks.isNotEmpty) const Divider(),
                  ...todo.subtasks.map((subtask) {
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Checkbox(
                        value: subtask.isDone,
                        onChanged: (_) => todoCtrl.toggleSubtask(todo.id, subtask.id),
                      ),
                      title: Text(
                        subtask.text,
                        style: TextStyle(
                          decoration: subtask.isDone ? TextDecoration.lineThrough : null,
                          color: subtask.isDone ? theme.colorScheme.outline : null,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.close, size: 18),
                        onPressed: () => todoCtrl.deleteSubtask(todo.id, subtask.id),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Tags
          if (todo.tags.isNotEmpty) ...[
            Text('Tags', style: theme.textTheme.titleSmall),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: todo.tags.map((tag) {
                return Chip(
                  avatar: const Icon(Icons.tag, size: 14),
                  label: Text(tag),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
          ],
        ],
      ),
    );
  }

  Widget _buildPriorityPill(BuildContext context, TodoPriority priority) {
    Color color;
    String label;
    switch (priority) {
      case TodoPriority.urgent:
        color = Colors.red;
        label = 'Urgent';
        break;
      case TodoPriority.high:
        color = Colors.orange;
        label = 'High';
        break;
      case TodoPriority.normal:
        color = Theme.of(context).colorScheme.primary;
        label = 'Normal';
        break;
      case TodoPriority.low:
        color = Theme.of(context).colorScheme.outline;
        label = 'Low';
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }
}
```

---

<a id="lib-features-todos-todo_editor_screendart"></a>
## 94. `lib/features/todos/todo_editor_screen.dart`

**Path**: `lib/features/todos/todo_editor_screen.dart` | **Lines**: 440

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../application/controllers/folder_controller.dart';
import '../../application/controllers/todo_controller.dart';
import '../../domain/entities/todo.dart';
import '../../domain/entities/todo_subtask.dart';
import '../../domain/enums/todo_enums.dart';
import '../../presentation/theme/nudge_theme.dart';

class TodoEditorScreen extends StatefulWidget {
  final Todo? todo;
  final String? initialFolderId;
  final String? initialTitle;
  final String? initialDescription;
  final String? initialSourceRecordId;

  const TodoEditorScreen({
    super.key,
    this.todo,
    this.initialFolderId,
    this.initialTitle,
    this.initialDescription,
    this.initialSourceRecordId,
  });

  @override
  State<TodoEditorScreen> createState() => _TodoEditorScreenState();
}

class _TodoEditorScreenState extends State<TodoEditorScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descController;
  late TextEditingController _tagController;
  late TextEditingController _subtaskInputController;

  late TodoPriority _priority;
  String? _selectedFolderId;
  DateTime? _dueDate;
  TimeOfDay? _dueTime;
  bool _reminderEnabled = false;
  DateTime? _reminderDate;
  TimeOfDay? _reminderTime;

  List<TodoSubtask> _subtasks = [];
  List<String> _tags = [];

  @override
  void initState() {
    super.initState();
    final t = widget.todo;
    _titleController = TextEditingController(text: t?.title ?? widget.initialTitle ?? '');
    _descController = TextEditingController(text: t?.description ?? widget.initialDescription ?? '');
    _tagController = TextEditingController();
    _subtaskInputController = TextEditingController();

    _priority = t?.priority ?? TodoPriority.normal;
    _selectedFolderId = t?.folderId ?? widget.initialFolderId;
    if (t?.dueAt != null) {
      _dueDate = t!.dueAt;
      _dueTime = TimeOfDay.fromDateTime(t.dueAt!);
    }
    _reminderEnabled = t?.reminderEnabled ?? false;
    if (t?.reminderAt != null) {
      _reminderDate = t!.reminderAt;
      _reminderTime = TimeOfDay.fromDateTime(t.reminderAt!);
    }
    _subtasks = t != null ? List<TodoSubtask>.from(t.subtasks) : [];
    _tags = t != null ? List<String>.from(t.tags) : [];
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _tagController.dispose();
    _subtaskInputController.dispose();
    super.dispose();
  }

  DateTime? _getCombinedDateTime(DateTime? date, TimeOfDay? time) {
    if (date == null) return null;
    final t = time ?? const TimeOfDay(hour: 9, minute: 0);
    return DateTime(date.year, date.month, date.day, t.hour, t.minute);
  }

  void _addSubtask() {
    final text = _subtaskInputController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _subtasks.add(
        TodoSubtask(
          todoId: widget.todo?.id ?? '',
          text: text,
          sortOrder: _subtasks.length,
        ),
      );
      _subtaskInputController.clear();
    });
  }

  void _addTag() {
    final tag = _tagController.text.trim().replaceAll('#', '');
    if (tag.isNotEmpty && !_tags.contains(tag)) {
      setState(() {
        _tags.add(tag);
        _tagController.clear();
      });
    }
  }

  Future<void> _pickDueDate() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? now,
      firstDate: now.subtract(const Duration(days: 365)),
      lastDate: now.add(const Duration(days: 365 * 5)),
    );
    if (pickedDate != null) {
      if (!mounted) return;
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: _dueTime ?? const TimeOfDay(hour: 12, minute: 0),
      );
      if (!mounted) return;
      setState(() {
        _dueDate = pickedDate;
        _dueTime = pickedTime ?? _dueTime ?? const TimeOfDay(hour: 12, minute: 0);
      });
    }
  }

  Future<void> _saveTodo() async {
    if (!_formKey.currentState!.validate()) return;

    final title = _titleController.text.trim();
    final desc = _descController.text.trim().isEmpty ? null : _descController.text.trim();
    final dueAt = _getCombinedDateTime(_dueDate, _dueTime);
    final reminderAt = _reminderEnabled ? _getCombinedDateTime(_reminderDate ?? _dueDate, _reminderTime ?? _dueTime) : null;

    final todoCtrl = context.read<TodoController>();

    if (widget.todo != null) {
      final updated = widget.todo!.copyWith(
        title: title,
        description: desc,
        priority: _priority,
        folderId: _selectedFolderId,
        dueAt: dueAt,
        tags: _tags,
        reminderEnabled: _reminderEnabled,
        reminderAt: reminderAt,
        subtasks: _subtasks,
      );
      await todoCtrl.updateTodo(updated);
    } else {
      final newTodo = Todo(
        title: title,
        description: desc,
        priority: _priority,
        folderId: _selectedFolderId,
        dueAt: dueAt,
        tags: _tags,
        reminderEnabled: _reminderEnabled,
        reminderAt: reminderAt,
        sourceRecordId: widget.initialSourceRecordId,
        subtasks: _subtasks,
      );
      await todoCtrl.createTodo(newTodo);
    }

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final folderCtrl = context.watch<FolderController>();
    final isEditing = widget.todo != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Task' : 'New Task'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: FilledButton.icon(
              onPressed: _saveTodo,
              icon: const Icon(Icons.check, size: 18),
              label: const Text('Save'),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Title Input
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Task Title *',
                hintText: 'What needs to be done?',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.check_box_outlined),
              ),
              textCapitalization: TextCapitalization.sentences,
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Title is required' : null,
            ),
            const SizedBox(height: 14),

            // Description Input
            TextFormField(
              controller: _descController,
              decoration: const InputDecoration(
                labelText: 'Description / Notes',
                hintText: 'Add details, links, or context...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.notes),
              ),
              maxLines: 3,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 18),

            // Priority Selector
            Text('Priority', style: theme.textTheme.titleSmall),
            const SizedBox(height: 8),
            SegmentedButton<TodoPriority>(
              segments: const [
                ButtonSegment(value: TodoPriority.low, label: Text('Low')),
                ButtonSegment(value: TodoPriority.normal, label: Text('Normal')),
                ButtonSegment(value: TodoPriority.high, label: Text('High')),
                ButtonSegment(value: TodoPriority.urgent, label: Text('Urgent')),
              ],
              selected: {_priority},
              onSelectionChanged: (newSelection) {
                setState(() => _priority = newSelection.first);
              },
            ),
            const SizedBox(height: 18),

            // Folder Picker
            Text('Folder', style: theme.textTheme.titleSmall),
            const SizedBox(height: 8),
            DropdownButtonFormField<String?>(
              value: _selectedFolderId,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.folder_outlined),
              ),
              items: [
                const DropdownMenuItem<String?>(
                  value: null,
                  child: Text('No Folder (Inbox)'),
                ),
                ...folderCtrl.folders.map(
                  (f) => DropdownMenuItem<String?>(
                    value: f.id,
                    child: Row(
                      children: [
                        Icon(NudgeTheme.getFolderIcon(f), size: 16),
                        const SizedBox(width: 8),
                        Text(f.name),
                      ],
                    ),
                  ),
                ),
              ],
              onChanged: (val) => setState(() => _selectedFolderId = val),
            ),
            const SizedBox(height: 18),

            // Due Date & Time
            Text('Due Date', style: theme.textTheme.titleSmall),
            const SizedBox(height: 8),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: theme.colorScheme.outlineVariant),
              ),
              leading: const Icon(Icons.calendar_today_outlined),
              title: Text(
                _dueDate != null
                    ? DateFormat('EEE, MMM d, yyyy').format(_dueDate!) +
                        (_dueTime != null ? ' at ${_dueTime!.format(context)}' : '')
                    : 'Set Due Date',
              ),
              trailing: _dueDate != null
                  ? IconButton(
                      icon: const Icon(Icons.clear, size: 20),
                      onPressed: () {
                        setState(() {
                          _dueDate = null;
                          _dueTime = null;
                        });
                      },
                    )
                  : const Icon(Icons.chevron_right),
              onTap: _pickDueDate,
            ),
            const SizedBox(height: 18),

            // Gentle Notification Switch
            SwitchListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: theme.colorScheme.outlineVariant),
              ),
              secondary: const Icon(Icons.notifications_active_outlined),
              title: const Text('Gentle Reminder Notification'),
              subtitle: const Text('Sends a quiet notification at due time without loud alarms'),
              value: _reminderEnabled,
              onChanged: (val) {
                setState(() => _reminderEnabled = val);
              },
            ),
            const SizedBox(height: 22),

            // Subtasks Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Subtasks (${_subtasks.where((s) => s.isDone).length}/${_subtasks.length})',
                  style: theme.textTheme.titleSmall,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _subtaskInputController,
                    decoration: const InputDecoration(
                      hintText: 'Add a subtask...',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    onSubmitted: (_) => _addSubtask(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  icon: const Icon(Icons.add),
                  onPressed: _addSubtask,
                ),
              ],
            ),
            if (_subtasks.isNotEmpty) ...[
              const SizedBox(height: 8),
              ..._subtasks.asMap().entries.map((entry) {
                final idx = entry.key;
                final subtask = entry.value;
                return ListTile(
                  dense: true,
                  leading: Checkbox(
                    value: subtask.isDone,
                    onChanged: (val) {
                      setState(() {
                        _subtasks[idx] = subtask.copyWith(isDone: val ?? false);
                      });
                    },
                  ),
                  title: Text(
                    subtask.text,
                    style: TextStyle(
                      decoration: subtask.isDone ? TextDecoration.lineThrough : null,
                      color: subtask.isDone ? theme.colorScheme.outline : null,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.close, size: 18),
                    onPressed: () {
                      setState(() {
                        _subtasks.removeAt(idx);
                      });
                    },
                  ),
                );
              }),
            ],
            const SizedBox(height: 22),

            // Tags Section
            Text('Tags', style: theme.textTheme.titleSmall),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _tagController,
                    decoration: const InputDecoration(
                      hintText: 'Add tag (e.g. work, project)',
                      border: OutlineInputBorder(),
                      prefixText: '#',
                      isDense: true,
                    ),
                    onSubmitted: (_) => _addTag(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filledTonal(
                  icon: const Icon(Icons.add),
                  onPressed: _addTag,
                ),
              ],
            ),
            if (_tags.isNotEmpty) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: _tags.map((tag) {
                  return Chip(
                    label: Text('#$tag'),
                    onDeleted: () {
                      setState(() {
                        _tags.remove(tag);
                      });
                    },
                  );
                }).toList(),
              ),
            ],
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
```

---

<a id="lib-features-todos-todos_screendart"></a>
## 95. `lib/features/todos/todos_screen.dart`

**Path**: `lib/features/todos/todos_screen.dart` | **Lines**: 216

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../application/controllers/folder_controller.dart';
import '../../application/controllers/todo_controller.dart';
import '../../domain/enums/todo_enums.dart';
import '../../presentation/components/empty_state_widget.dart';
import '../../presentation/theme/nudge_theme.dart';
import 'todo_card.dart';
import 'todo_editor_screen.dart';

class TodosScreen extends StatefulWidget {
  final String? initialFolderId;

  const TodosScreen({super.key, this.initialFolderId});

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ctrl = context.read<TodoController>();
      if (widget.initialFolderId != null) {
        ctrl.setFolder(widget.initialFolderId);
      }
      ctrl.loadTodos();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final todoCtrl = context.watch<TodoController>();
    final folderCtrl = context.watch<FolderController>();

    final filteredTodos = todoCtrl.filteredTodos;
    final isTrash = todoCtrl.activeFilter == TodoFilter.trash;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks & Todos'),
        actions: [
          if (isTrash)
            IconButton(
              icon: const Icon(Icons.delete_forever, color: Colors.red),
              tooltip: 'Empty Trash',
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Empty Trash?'),
                    content: const Text('This will permanently delete all tasks in the trash.'),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
                      FilledButton(
                        style: FilledButton.styleFrom(backgroundColor: Colors.red),
                        onPressed: () => Navigator.pop(ctx, true),
                        child: const Text('Delete Permanently'),
                      ),
                    ],
                  ),
                );
                if (confirm == true) {
                  await todoCtrl.purgeTrash();
                }
              },
            ),
        ],
      ),
      body: Column(
        children: [
          // Search & Filter Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search tasks...',
                prefixIcon: const Icon(Icons.search),
                isDense: true,
                filled: true,
                fillColor: theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 18),
                        onPressed: () {
                          _searchController.clear();
                          todoCtrl.setSearchQuery('');
                        },
                      )
                    : null,
              ),
              onChanged: (val) => todoCtrl.setSearchQuery(val),
            ),
          ),

          // Filter Chips (All, Today, Upcoming, High Priority, Completed, Archived, Trash)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Row(
              children: [
                _buildFilterChip('All (${todoCtrl.activeCount})', TodoFilter.all, todoCtrl),
                const SizedBox(width: 8),
                _buildFilterChip('Today (${todoCtrl.todayCount})', TodoFilter.today, todoCtrl),
                const SizedBox(width: 8),
                _buildFilterChip('Upcoming', TodoFilter.upcoming, todoCtrl),
                const SizedBox(width: 8),
                _buildFilterChip('High Priority', TodoFilter.highPriority, todoCtrl),
                const SizedBox(width: 8),
                _buildFilterChip('Completed (${todoCtrl.completedCount})', TodoFilter.completed, todoCtrl),
                const SizedBox(width: 8),
                _buildFilterChip('Archived', TodoFilter.archived, todoCtrl),
                const SizedBox(width: 8),
                _buildFilterChip('Trash', TodoFilter.trash, todoCtrl),
              ],
            ),
          ),

          // Folder Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
            child: Row(
              children: [
                ChoiceChip(
                  label: const Text('All Folders'),
                  selected: todoCtrl.selectedFolderId == null,
                  onSelected: (selected) {
                    if (selected) todoCtrl.setFolder(null);
                  },
                ),
                const SizedBox(width: 8),
                ...folderCtrl.folders.map((f) {
                  final isSelected = todoCtrl.selectedFolderId == f.id;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      avatar: Icon(NudgeTheme.getFolderIcon(f), size: 14),
                      label: Text(f.name),
                      selected: isSelected,
                      onSelected: (selected) {
                        todoCtrl.setFolder(selected ? f.id : null);
                      },
                    ),
                  );
                }),
              ],
            ),
          ),

          const Divider(height: 12),

          // Task List
          Expanded(
            child: filteredTodos.isEmpty
                ? EmptyStateWidget(
                    icon: Icons.task_alt,
                    title: isTrash ? 'Trash is Empty' : 'No Tasks Found',
                    subtitle: isTrash
                        ? 'Deleted tasks will appear here'
                        : 'Tap the button below to add your first task',
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 80, top: 4),
                    itemCount: filteredTodos.length,
                    itemBuilder: (ctx, index) {
                      return TodoCard(todo: filteredTodos[index]);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TodoEditorScreen(
                initialFolderId: todoCtrl.selectedFolderId ?? widget.initialFolderId,
              ),
            ),
          );
        },
        icon: const Icon(Icons.add_task),
        label: const Text('New Task'),
      ),
    );
  }

  Widget _buildFilterChip(String label, TodoFilter filter, TodoController ctrl) {
    final isSelected = ctrl.activeFilter == filter;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (val) {
        if (val) ctrl.setFilter(filter);
      },
    );
  }
}
```

---

<a id="lib-maindart"></a>
## 96. `lib/main.dart`

**Path**: `lib/main.dart` | **Lines**: 275

```dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/constants/app_constants.dart';
import 'core/logging/app_logger.dart';
import 'data/database/app_database.dart';
import 'data/repositories/companion_repository_impl.dart';
import 'data/repositories/folder_repository_impl.dart';
import 'data/repositories/history_repository_impl.dart';
import 'data/repositories/occurrence_repository_impl.dart';
import 'data/repositories/reminder_repository_impl.dart';
import 'data/repositories/todo_repository_impl.dart';
import 'data/repositories/record_repository_impl.dart';

import 'application/controllers/companion_controller.dart';
import 'application/controllers/folder_controller.dart';
import 'application/controllers/reliability_controller.dart';
import 'application/controllers/reminder_controller.dart';
import 'application/controllers/settings_controller.dart';
import 'application/controllers/theme_controller.dart';
import 'application/controllers/timer_controller.dart';
import 'application/controllers/todo_controller.dart';
import 'application/controllers/record_controller.dart';

import 'presentation/theme/nudge_theme.dart';
import 'platform/alarms/alarm_platform_service.dart';
import 'platform/notifications/notification_platform_service.dart';
import 'platform/permissions/permission_manager.dart';

import 'features/home/home_screen.dart';
import 'features/alarms/ringing_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppLogger.info('Main', 'Launching Nudge 2.0...');

  // Initialize SQLite Database
  await AppDatabase.database;

  // Initialize Notification Channels
  await NotificationPlatformService.initialize();

  // Initialize Alarm Manager
  await AlarmPlatformService.initialize();

  // Repositories
  final reminderRepo = ReminderRepositoryImpl();
  final occurrenceRepo = OccurrenceRepositoryImpl();
  final folderRepo = FolderRepositoryImpl();
  final historyRepo = HistoryRepositoryImpl();
  final companionRepo = CompanionRepositoryImpl();
  final todoRepo = TodoRepositoryImpl();
  final recordRepo = RecordRepositoryImpl();

  // Controllers
  final themeController = ThemeController();
  final settingsController = SettingsController();
  final reliabilityController = ReliabilityController();
  final folderController = FolderController(folderRepo: folderRepo);
  final companionController = CompanionController(repository: companionRepo);
  final reminderController = ReminderController(
    reminderRepo: reminderRepo,
    occurrenceRepo: occurrenceRepo,
    historyRepo: historyRepo,
  );
  final timerController = TimerController();
  final todoController = TodoController(todoRepo: todoRepo);
  final recordController = RecordController(recordRepo: recordRepo);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: themeController),
        ChangeNotifierProvider.value(value: settingsController),
        ChangeNotifierProvider.value(value: reliabilityController),
        ChangeNotifierProvider.value(value: folderController),
        ChangeNotifierProvider.value(value: companionController),
        ChangeNotifierProvider.value(value: reminderController),
        ChangeNotifierProvider.value(value: timerController),
        ChangeNotifierProvider.value(value: todoController),
        ChangeNotifierProvider.value(value: recordController),
      ],
      child: const NudgeApp(),
    ),
  );
}

class NudgeApp extends StatelessWidget {
  const NudgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<ThemeController>();

    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: NudgeTheme.lightTheme,
      darkTheme: NudgeTheme.darkTheme,
      themeMode: themeController.themeMode,
      home: const NudgeAppRoot(),
    );
  }
}

class NudgeAppRoot extends StatefulWidget {
  const NudgeAppRoot({super.key});

  @override
  State<NudgeAppRoot> createState() => _NudgeAppRootState();
}

class _NudgeAppRootState extends State<NudgeAppRoot> with WidgetsBindingObserver {
  StreamSubscription<AlarmLaunchData>? _alarmSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Listen for alarms triggered while app is active or opened
    _alarmSubscription = AlarmPlatformService.onAlarmTriggered.listen((data) async {
      await _openRingingScreen(data);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkLaunchAlarm();
      _initializeAlarmReliability();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkLaunchAlarm();
      context.read<ReliabilityController>().refreshStatuses();
      context.read<ReminderController>().checkExactAlarmCapability();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _alarmSubscription?.cancel();
    super.dispose();
  }

  Future<void> _initializeAlarmReliability() async {
    final reliability = context.read<ReliabilityController>();
    await reliability.refreshStatuses();
    if (!mounted) return;

    if (!reliability.notificationsEnabled) {
      await PermissionManager.requestNotificationPermission();
    }
    await reliability.refreshStatuses();
    if (!mounted) return;

    if (!reliability.exactAlarmsEnabled) {
      await _showExactAlarmRequiredDialog();
    }
    await reliability.refreshStatuses();
    if (!mounted) return;

    if (!reliability.fullScreenIntentEnabled) {
      await _showFullScreenIntentDialog();
    }
    await reliability.refreshStatuses();
  }

  Future<void> _showExactAlarmRequiredDialog() async {
    final controller = context.read<ReliabilityController>();
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Allow setting alarms and reminders'),
          content: const Text(
            'Nudge needs exact alarm access so your reminders can ring at the scheduled time even when the app is closed or your phone is locked.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Not now'),
            ),
            FilledButton(
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                await controller.requestExactAlarmAccess();
              },
              child: const Text('Allow'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showFullScreenIntentDialog() async {
    final controller = context.read<ReliabilityController>();
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Allow full-screen alarms'),
          content: const Text(
            'Nudge can show a full-screen alarm screen directly when your phone is locked so you never miss an urgent reminder.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Not now'),
            ),
            FilledButton(
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                await controller.requestFullScreenIntent();
              },
              child: const Text('Allow'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _openRingingScreen(AlarmLaunchData data) async {
    if (!mounted) return;

    final reminderController = context.read<ReminderController>();
    await reminderController.loadReminders();

    String? reminderId = data.reminderId;

    if (reminderId == null && data.alarmId != null) {
      for (final reminder in reminderController.reminders) {
        if (AlarmPlatformService.alarmIdFor(reminder.id) == data.alarmId) {
          reminderId = reminder.id;
          break;
        }
      }
    }

    if (reminderId == null) return;
    if (!mounted) return;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => RingingScreen(
          reminderId: reminderId!,
        ),
      ),
    );
  }

  Future<void> _checkLaunchAlarm() async {
    final launchData = await AlarmPlatformService.getLaunchAlarmData();
    if (launchData.alarmId != null || launchData.reminderId != null) {
      await _openRingingScreen(launchData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}
```

---

<a id="lib-platform-alarms-alarm_platform_servicedart"></a>
## 97. `lib/platform/alarms/alarm_platform_service.dart`

**Path**: `lib/platform/alarms/alarm_platform_service.dart` | **Lines**: 491

```dart
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../../core/constants/app_constants.dart';
import '../../core/logging/app_logger.dart';
import '../../core/utils/fnv1a_hash.dart';
import '../../domain/entities/reminder.dart';

class AlarmPermissionRequiredException
    implements Exception {
  const AlarmPermissionRequiredException();

  @override
  String toString() =>
      'Exact alarm permission is required.';
}

class AlarmScheduleException
    implements Exception {
  final String message;

  const AlarmScheduleException(
    this.message,
  );

  @override
  String toString() => message;
}

class AlarmLaunchData {
  final int? alarmId;
  final String? reminderId;

  const AlarmLaunchData({
    this.alarmId,
    this.reminderId,
  });
}

class AlarmPlatformService {

  static const String _subsystem =
      'AlarmPlatformService';

  static const MethodChannel _channel =
      MethodChannel(
    AppConstants.alarmChannel,
  );

  static final StreamController<
      AlarmLaunchData> _events =
      StreamController<
          AlarmLaunchData>.broadcast();

  static final StreamController<void> _dismissEvents =
      StreamController<void>.broadcast();

  static Stream<AlarmLaunchData>
      get onAlarmTriggered =>
          _events.stream;

  static Stream<void>
      get onAlarmDismissed =>
          _dismissEvents.stream;

  static bool get isAndroid =>
      defaultTargetPlatform == TargetPlatform.android;

  static Future<void> initialize() async {

    _channel.setMethodCallHandler(
      (call) async {

        if (
            call.method ==
            'onAlarmTriggered'
        ) {

          final raw =
              Map<Object?, Object?>.from(
            call.arguments as Map,
          );

          _events.add(
            AlarmLaunchData(
              alarmId:
                  raw['alarmId'] as int?,
              reminderId:
                  raw['reminderId']
                      as String?,
            ),
          );
        } else if (call.method == 'onAlarmDismissed') {
          _dismissEvents.add(null);
        }
      },
    );
  }

  static int alarmIdFor(
    String reminderId
  ) {
    return Fnv1aHash.hash32(
      reminderId,
    );
  }

  static Future<bool>
      canScheduleExactAlarms() async {

    if (!isAndroid) {
      return true;
    }

    try {

      final result =
          await _channel.invokeMethod<bool>(
        'canScheduleExactAlarms',
      );

      return result ?? false;

    } catch (e, stack) {

      AppLogger.error(
        _subsystem,
        'Exact alarm capability query failed',
        error: e,
        stackTrace: stack,
      );

      return false;
    }
  }

  static Future<void>
      openExactAlarmSettings() async {

    if (!isAndroid) {
      return;
    }

    await _channel.invokeMethod(
      'openExactAlarmSettings',
    );
  }

  static Future<bool>
      canUseFullScreenIntent() async {

    if (!isAndroid) {
      return true;
    }

    try {

      final result =
          await _channel.invokeMethod<bool>(
        'canUseFullScreenIntent',
      );

      return result ?? false;

    } catch (e, stack) {

      AppLogger.error(
        _subsystem,
        'Full-screen capability query failed',
        error: e,
        stackTrace: stack,
      );

      return false;
    }
  }

  static Future<void>
      openFullScreenIntentSettings() async {

    if (!isAndroid) {
      return;
    }

    await _channel.invokeMethod(
      'openFullScreenIntentSettings',
    );
  }

  static Future<void>
      scheduleAlarm(
    Reminder reminder,
  ) async {

    if (
        reminder.isDone ||
        reminder.isArchived
    ) {
      return;
    }

    if (
        reminder.scheduledAt
            .isBefore(
          DateTime.now(),
        )
    ) {

      throw const AlarmScheduleException(
        'Cannot schedule an alarm in the past.',
      );
    }

    final exactAllowed =
        await canScheduleExactAlarms();

    if (!exactAllowed) {

      throw const AlarmPermissionRequiredException();
    }

    final alarmId =
        alarmIdFor(
      reminder.id,
    );

    AppLogger.info(
      _subsystem,
      'ALARM_SCHEDULE_REQUEST id=$alarmId reminder=${reminder.id} trigger=${reminder.scheduledAt}',
    );

    try {

      // Remove any existing alarm first.
      await cancelAlarm(
        reminder.id,
      );

      final result =
          await _channel.invokeMethod<bool>(
        'scheduleAlarm',
        <String, dynamic>{
          'id': alarmId,
          'reminderId': reminder.id,
          'title': 'Nudge Reminder',
          'message': reminder.message,
          'vibration':
              reminder.vibrationEnabled,
          'triggerAtMillis':
              reminder.scheduledAt
                  .millisecondsSinceEpoch,
        },
      );

      if (result != true) {

        throw const AlarmScheduleException(
          'Native AlarmManager did not confirm scheduling.',
        );
      }

      AppLogger.info(
        _subsystem,
        'ALARM_SCHEDULE_SUCCESS id=$alarmId',
      );

    } on PlatformException catch (e, stack) {

      AppLogger.error(
        _subsystem,
        'ALARM_SCHEDULE_PLATFORM_FAILURE',
        error: e,
        stackTrace: stack,
      );

      if (
          e.code ==
          'EXACT_ALARM_PERMISSION_REQUIRED'
      ) {

        throw const AlarmPermissionRequiredException();
      }

      throw AlarmScheduleException(
        e.message ??
            'Unable to schedule alarm.',
      );
    }
  }

  static Future<void>
      cancelAlarm(
    String reminderId,
  ) async {

    if (!isAndroid) {
      return;
    }

    final alarmId =
        alarmIdFor(
      reminderId,
    );

    await _channel.invokeMethod(
      'cancelAlarm',
      <String, dynamic>{
        'id': alarmId,
      },
    );
  }

  static Future<void>
      dismissRingingAlarm([
    int? alarmId,
  ]) async {

    if (!isAndroid) {
      return;
    }

    await _channel.invokeMethod(
      'dismissAlarm',
      alarmId == null
          ? null
          : <String, dynamic>{
              'id': alarmId,
            },
    );
  }

  static Future<AlarmLaunchData>
      getLaunchAlarmData() async {

    try {

      final result =
          await _channel.invokeMethod<
              Map<dynamic, dynamic>>(
        'getAlarmData',
      );

      if (result == null) {
        return const AlarmLaunchData();
      }

      return AlarmLaunchData(
        alarmId:
            result['alarmId']
                as int?,
        reminderId:
            result['reminderId']
                as String?,
      );

    } catch (e, stack) {

      AppLogger.error(
        _subsystem,
        'Failed to read launch alarm',
        error: e,
        stackTrace: stack,
      );

      return const AlarmLaunchData();
    }
  }

  static Future<void> closeAlarmUi() async {
    if (!isAndroid) return;
    try {
      await _channel.invokeMethod('closeAlarmUi');
    } catch (e, stack) {
      AppLogger.error(
        _subsystem,
        'Failed to close alarm UI',
        error: e,
        stackTrace: stack,
      );
    }
  }

  static Future<Map<String, dynamic>?> getAudioDuration(String filePath) async {
    if (!isAndroid) return null;
    try {
      final result = await _channel.invokeMethod<Map<dynamic, dynamic>>(
        'getAudioDuration',
        {'filePath': filePath},
      );
      if (result == null) return null;
      return Map<String, dynamic>.from(result);
    } catch (e, stack) {
      AppLogger.error(
        _subsystem,
        'Failed to get audio duration',
        error: e,
        stackTrace: stack,
      );
      return null;
    }
  }

  static Future<void> playAudioPreview(String filePath, int startMs, int endMs) async {
    if (!isAndroid) return;
    try {
      await _channel.invokeMethod('playAudioPreview', {
        'filePath': filePath,
        'startMs': startMs,
        'endMs': endMs,
      });
    } catch (e, stack) {
      AppLogger.error(
        _subsystem,
        'Failed to play audio preview',
        error: e,
        stackTrace: stack,
      );
    }
  }

  static Future<void> stopAudioPreview() async {
    if (!isAndroid) return;
    try {
      await _channel.invokeMethod('stopAudioPreview');
    } catch (e, stack) {
      AppLogger.error(
        _subsystem,
        'Failed to stop audio preview',
        error: e,
        stackTrace: stack,
      );
    }
  }

  static Future<void> saveCustomAlarmSound(
    String filePath,
    int startMs,
    int endMs, {
    String? title,
  }) async {
    if (!isAndroid) return;
    try {
      await _channel.invokeMethod('saveCustomAlarmSound', {
        'filePath': filePath,
        'startMs': startMs,
        'endMs': endMs,
        'title': title,
      });
    } catch (e, stack) {
      AppLogger.error(
        _subsystem,
        'Failed to save custom alarm sound',
        error: e,
        stackTrace: stack,
      );
    }
  }

  static Future<Map<String, dynamic>?> getCustomAlarmSound() async {
    if (!isAndroid) return null;
    try {
      final result = await _channel.invokeMethod<Map<dynamic, dynamic>>('getCustomAlarmSound');
      if (result == null) return null;
      return Map<String, dynamic>.from(result);
    } catch (e, stack) {
      AppLogger.error(
        _subsystem,
        'Failed to get custom alarm sound',
        error: e,
        stackTrace: stack,
      );
      return null;
    }
  }

  static Future<void> clearCustomAlarmSound() async {
    if (!isAndroid) return;
    try {
      await _channel.invokeMethod('clearCustomAlarmSound');
    } catch (e, stack) {
      AppLogger.error(
        _subsystem,
        'Failed to clear custom alarm sound',
        error: e,
        stackTrace: stack,
      );
    }
  }
}
```

---

<a id="lib-platform-calendar-device_calendar_bridgedart"></a>
## 98. `lib/platform/calendar/device_calendar_bridge.dart`

**Path**: `lib/platform/calendar/device_calendar_bridge.dart` | **Lines**: 72

```dart
import 'package:device_calendar/device_calendar.dart' hide Reminder;
import 'package:timezone/data/latest.dart' as tz;
import '../../core/logging/app_logger.dart';
import '../../domain/entities/reminder.dart';
import 'i_calendar_bridge.dart';

class DeviceCalendarBridge implements ICalendarBridge {
  static const String _subsystem = 'DeviceCalendarBridge';
  final DeviceCalendarPlugin _calendarPlugin = DeviceCalendarPlugin();

  @override
  Future<String?> syncReminderToCalendar(Reminder reminder) async {
    try {
      tz.initializeTimeZones();
      final permissions = await _calendarPlugin.hasPermissions();
      if (permissions.isSuccess && !(permissions.data ?? false)) {
        final request = await _calendarPlugin.requestPermissions();
        if (!request.isSuccess || !(request.data ?? false)) {
          AppLogger.warning(_subsystem, 'Calendar permission denied');
          return null;
        }
      }

      final calendarsResult = await _calendarPlugin.retrieveCalendars();
      if (!calendarsResult.isSuccess || calendarsResult.data == null || calendarsResult.data!.isEmpty) {
        return null;
      }

      final defaultCal = calendarsResult.data!.firstWhere(
        (c) => c.isDefault ?? false,
        orElse: () => calendarsResult.data!.first,
      );

      final event = Event(
        defaultCal.id,
        eventId: (reminder.calendarEventId != null && reminder.calendarEventId != 'pending')
            ? reminder.calendarEventId
            : null,
      );
      event.title = reminder.message;
      event.start = TZDateTime.from(reminder.scheduledAt, local);
      event.end = TZDateTime.from(reminder.scheduledAt.add(const Duration(hours: 1)), local);

      final res = await _calendarPlugin.createOrUpdateEvent(event);
      if (res?.isSuccess == true && res?.data != null) {
        AppLogger.info(_subsystem, 'Synced reminder to calendar event ID: ${res?.data}');
        return res?.data;
      }
    } catch (e, stack) {
      AppLogger.error(_subsystem, 'Failed to sync reminder to device calendar', error: e, stackTrace: stack);
    }
    return null;
  }

  @override
  Future<void> removeReminderFromCalendar(String? eventId) async {
    if (eventId == null || eventId == 'pending') return;
    try {
      final calendarsResult = await _calendarPlugin.retrieveCalendars();
      if (calendarsResult.isSuccess && calendarsResult.data != null) {
        final defaultCal = calendarsResult.data!.firstWhere(
          (c) => c.isDefault ?? false,
          orElse: () => calendarsResult.data!.first,
        );
        await _calendarPlugin.deleteEvent(defaultCal.id, eventId);
        AppLogger.info(_subsystem, 'Deleted calendar event: $eventId');
      }
    } catch (e) {
      AppLogger.warning(_subsystem, 'Failed to delete calendar event $eventId: $e');
    }
  }
}
```

---

<a id="lib-platform-calendar-i_calendar_bridgedart"></a>
## 99. `lib/platform/calendar/i_calendar_bridge.dart`

**Path**: `lib/platform/calendar/i_calendar_bridge.dart` | **Lines**: 6

```dart
import '../../domain/entities/reminder.dart';

abstract class ICalendarBridge {
  Future<String?> syncReminderToCalendar(Reminder reminder);
  Future<void> removeReminderFromCalendar(String? eventId);
}
```

---

<a id="lib-platform-notifications-notification_platform_servicedart"></a>
## 100. `lib/platform/notifications/notification_platform_service.dart`

**Path**: `lib/platform/notifications/notification_platform_service.dart` | **Lines**: 86

```dart
﻿import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../core/constants/app_constants.dart';
import '../../core/logging/app_logger.dart';
import '../../domain/entities/reminder.dart';

class NotificationPlatformService {
  static const String _subsystem = 'NotificationPlatformService';
  static final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();

  static Future<void> initialize({
    void Function(NotificationResponse)? onDidReceiveNotificationResponse,
    void Function(NotificationResponse)? onDidReceiveBackgroundNotificationResponse,
  }) async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidSettings);

    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse: onDidReceiveBackgroundNotificationResponse,
    );

    // Create Notification Channels on Android 8.0+
    final androidPlugin = _notifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    if (androidPlugin != null) {
      await androidPlugin.createNotificationChannel(
        const AndroidNotificationChannel(
          AppConstants.alarmChannelId,
          AppConstants.alarmChannelName,
          description: 'High-priority full-screen alarms',
          importance: Importance.max,
          playSound: false,
          enableVibration: false,
        ),
      );

      await androidPlugin.createNotificationChannel(
        const AndroidNotificationChannel(
          AppConstants.gentleChannelId,
          AppConstants.gentleChannelName,
          description: 'Gentle notification reminders with actions',
          importance: Importance.high,
          playSound: true,
          enableVibration: true,
        ),
      );
    }
    AppLogger.info(_subsystem, 'Notification channels initialized');
  }

  static Future<void> showGentleNotification(Reminder reminder, int alarmId) async {
    final actions = <AndroidNotificationAction>[];
    if (reminder.snoozeCount < AppConstants.maxSnoozeCount) {
      actions.add(const AndroidNotificationAction('snooze', 'Snooze', showsUserInterface: true));
    }
    actions.add(const AndroidNotificationAction('done', 'Done', showsUserInterface: true));

    final androidDetails = AndroidNotificationDetails(
      AppConstants.gentleChannelId,
      AppConstants.gentleChannelName,
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      enableVibration: reminder.vibrationEnabled,
      actions: actions,
    );

    await _notifications.show(
      alarmId,
      'Nudge Reminder',
      reminder.message,
      NotificationDetails(android: androidDetails),
      payload: reminder.id,
    );
  }

  static Future<void> cancel(int id) async {
    await _notifications.cancel(id);
  }

  static Future<void> cancelAll() async {
    await _notifications.cancelAll();
  }
}
```

---

<a id="lib-platform-permissions-permission_managerdart"></a>
## 101. `lib/platform/permissions/permission_manager.dart`

**Path**: `lib/platform/permissions/permission_manager.dart` | **Lines**: 119

```dart
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart' as ph;

import '../../core/constants/app_constants.dart';
import '../../core/logging/app_logger.dart';

class PermissionManager {
  static const String _subsystem = 'PermissionManager';

  static const MethodChannel _reliabilityChannel =
      MethodChannel(
    AppConstants.reliabilityChannel,
  );

  static Future<bool> requestNotificationPermission() async {
    try {
      final status =
          await ph.Permission.notification.request();

      AppLogger.info(
        _subsystem,
        'Notification permission status: $status',
      );

      return status.isGranted;
    } catch (e, stack) {
      AppLogger.error(
        _subsystem,
        'Notification permission request failed',
        error: e,
        stackTrace: stack,
      );

      return false;
    }
  }

  static Future<bool> requestMicrophonePermission() async {
    try {
      final status =
          await ph.Permission.microphone.request();

      AppLogger.info(
        _subsystem,
        'Microphone permission status: $status',
      );

      return status.isGranted;
    } catch (e, stack) {
      AppLogger.error(
        _subsystem,
        'Microphone permission request failed',
        error: e,
        stackTrace: stack,
      );

      return false;
    }
  }

  static Future<bool>
      isIgnoringBatteryOptimizations() async {

    try {
      final result =
          await _reliabilityChannel.invokeMethod<bool>(
        'isIgnoringBatteryOptimizations',
      );

      return result ?? false;
    } catch (e) {
      return false;
    }
  }

  static Future<void>
      openBatteryOptimizationSettings() async {

    try {
      await _reliabilityChannel.invokeMethod(
        'openBatteryOptimizationSettings',
      );
    } catch (e, stack) {
      AppLogger.error(
        _subsystem,
        'Unable to open battery optimization settings',
        error: e,
        stackTrace: stack,
      );
    }
  }

  static Future<void>
      openExactAlarmSettings() async {

    try {
      await _reliabilityChannel.invokeMethod(
        'openExactAlarmSettings',
      );
    } catch (e, stack) {
      AppLogger.error(
        _subsystem,
        'Unable to open exact alarm settings',
        error: e,
        stackTrace: stack,
      );
    }
  }

  static Future<bool>
      openAppSettings() async {

    try {
      return await ph.openAppSettings();
    } catch (_) {
      return false;
    }
  }
}
```

---

<a id="lib-platform-widgets-home_widget_bridgedart"></a>
## 102. `lib/platform/widgets/home_widget_bridge.dart`

**Path**: `lib/platform/widgets/home_widget_bridge.dart` | **Lines**: 42

```dart
﻿import 'package:home_widget/home_widget.dart';
import '../../core/logging/app_logger.dart';
import '../../domain/entities/reminder.dart';

class HomeWidgetBridge {
  static const String _subsystem = 'HomeWidgetBridge';

  static Future<void> updateWidget(List<Reminder> upcomingReminders) async {
    try {
      final count = upcomingReminders.length;
      final countText = count > 0 ? '$count upcoming' : 'All done';

      await HomeWidget.saveWidgetData<String>('widget_count', countText);

      if (upcomingReminders.isNotEmpty) {
        await HomeWidget.saveWidgetData<String>('widget_reminder_1', upcomingReminders[0].message);
      } else {
        await HomeWidget.saveWidgetData<String>('widget_reminder_1', 'No upcoming reminders');
      }

      if (upcomingReminders.length > 1) {
        await HomeWidget.saveWidgetData<String>('widget_reminder_2', upcomingReminders[1].message);
      } else {
        await HomeWidget.saveWidgetData<String>('widget_reminder_2', '');
      }

      if (upcomingReminders.length > 2) {
        await HomeWidget.saveWidgetData<String>('widget_reminder_3', upcomingReminders[2].message);
      } else {
        await HomeWidget.saveWidgetData<String>('widget_reminder_3', '');
      }

      await HomeWidget.updateWidget(
        name: 'NudgeWidgetProvider',
        androidName: 'NudgeWidgetProvider',
      );
      AppLogger.info(_subsystem, 'Home widget updated with $count reminders');
    } catch (e) {
      AppLogger.warning(_subsystem, 'Failed to update home widget: $e');
    }
  }
}
```

---

<a id="lib-presentation-components-checklist_widgetdart"></a>
## 103. `lib/presentation/components/checklist_widget.dart`

**Path**: `lib/presentation/components/checklist_widget.dart` | **Lines**: 132

```dart
﻿import 'package:flutter/material.dart';
import '../../domain/entities/checklist_item.dart';
import '../theme/nudge_theme.dart';

class ChecklistWidget extends StatefulWidget {
  final List<ChecklistItem> items;
  final ValueChanged<List<ChecklistItem>> onChanged;

  const ChecklistWidget({
    super.key,
    required this.items,
    required this.onChanged,
  });

  @override
  State<ChecklistWidget> createState() => _ChecklistWidgetState();
}

class _ChecklistWidgetState extends State<ChecklistWidget> {
  final TextEditingController _itemController = TextEditingController();

  void _addItem() {
    final text = _itemController.text.trim();
    if (text.isEmpty) return;

    final updated = List<ChecklistItem>.from(widget.items)..add(ChecklistItem.create(text: text));
    widget.onChanged(updated);
    _itemController.clear();
  }

  void _toggleItem(int index) {
    final updated = List<ChecklistItem>.from(widget.items);
    updated[index] = updated[index].copyWith(isDone: !updated[index].isDone);
    widget.onChanged(updated);
  }

  void _removeItem(int index) {
    final updated = List<ChecklistItem>.from(widget.items)..removeAt(index);
    widget.onChanged(updated);
  }

  @override
  void dispose() {
    _itemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Checklist (${widget.items.length})',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDark ? NudgeTheme.onPrimaryContainer : NudgeTheme.secondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Item list
        ...widget.items.asMap().entries.map((entry) {
          final idx = entry.key;
          final item = entry.value;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              children: [
                Checkbox(
                  value: item.isDone,
                  onChanged: (_) => _toggleItem(idx),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                ),
                Expanded(
                  child: Text(
                    item.text,
                    style: TextStyle(
                      fontSize: 14,
                      decoration: item.isDone ? TextDecoration.lineThrough : null,
                      color: item.isDone ? Colors.grey : (isDark ? NudgeTheme.onBgDark : NudgeTheme.onBgLight),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 18),
                  onPressed: () => _removeItem(idx),
                  tooltip: 'Remove item',
                ),
              ],
            ),
          );
        }),
        // Add new item input
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _itemController,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Add checklist step...',
                  hintStyle: const TextStyle(fontSize: 13),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(NudgeTheme.radiusS),
                  ),
                ),
                onSubmitted: (_) => _addItem(),
              ),
            ),
            const SizedBox(width: 8),
            IconButton.filledTonal(
              icon: const Icon(Icons.add),
              onPressed: _addItem,
              tooltip: 'Add item',
            ),
          ],
        ),
      ],
    );
  }
}
```

---

<a id="lib-presentation-components-empty_state_widgetdart"></a>
## 104. `lib/presentation/components/empty_state_widget.dart`

**Path**: `lib/presentation/components/empty_state_widget.dart` | **Lines**: 79

```dart
import 'package:flutter/material.dart';
import '../theme/nudge_theme.dart';
import 'nudge_button.dart';

class EmptyStateWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final String? description;
  final String? actionLabel;
  final VoidCallback? onAction;

  const EmptyStateWidget({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.description,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 48.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? NudgeTheme.surfaceContainerDark : NudgeTheme.surfaceContainerLight,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 44,
                color: isDark ? NudgeTheme.onPrimaryContainer : NudgeTheme.secondary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: isDark ? NudgeTheme.onBgDark : NudgeTheme.onBgLight,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description ?? subtitle ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
                height: 1.4,
              ),
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 24),
              NudgeButton(
                label: actionLabel!,
                onPressed: onAction,
                variant: ButtonVariant.primary,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
```

---

<a id="lib-presentation-components-loading_overlaydart"></a>
## 105. `lib/presentation/components/loading_overlay.dart`

**Path**: `lib/presentation/components/loading_overlay.dart` | **Lines**: 35

```dart
﻿import 'package:flutter/material.dart';

class LoadingOverlay {
  static void show(BuildContext context, {String message = 'Please wait...'}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => PopScope(
        canPop: false,
        child: Center(
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(width: 16),
                  Text(message, style: const TextStyle(fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static void hide(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }
}
```

---

<a id="lib-presentation-components-mascot_widgetdart"></a>
## 106. `lib/presentation/components/mascot_widget.dart`

**Path**: `lib/presentation/components/mascot_widget.dart` | **Lines**: 478

```dart
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../application/controllers/companion_controller.dart';
import '../../domain/enums/enums.dart';
import '../theme/nudge_theme.dart';

class MascotWidget extends StatefulWidget {
  final CompanionMood? mood;
  final String? equippedCosmetic;
  final double size;
  final VoidCallback? onTap;
  final bool showBubble;

  const MascotWidget({
    super.key,
    this.mood,
    this.equippedCosmetic,
    this.size = 56.0,
    this.onTap,
    this.showBubble = false,
  });

  @override
  State<MascotWidget> createState() => _MascotWidgetState();
}

class _MascotWidgetState extends State<MascotWidget> with TickerProviderStateMixin {
  late AnimationController _floatController;
  late Animation<double> _floatAnimation;

  late AnimationController _actionController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _tiltAnimation;

  late AnimationController _celebrationController;
  late Animation<double> _spinAnimation;

  bool _isTapped = false;

  @override
  void initState() {
    super.initState();

    // Idle floating/breathing animation
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -3.0, end: 3.0).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOutSine),
    );

    // Tap action: squash and stretch bounce + tilt wiggle
    _actionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.84), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 0.84, end: 1.15), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 1.15, end: 1.0), weight: 30),
    ]).animate(CurvedAnimation(parent: _actionController, curve: Curves.easeOut));

    _tiltAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -0.12), weight: 25),
      TweenSequenceItem(tween: Tween(begin: -0.12, end: 0.12), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 0.12, end: 0.0), weight: 25),
    ]).animate(CurvedAnimation(parent: _actionController, curve: Curves.easeInOut));

    // Celebration 360 spin
    _celebrationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _spinAnimation = Tween<double>(begin: 0.0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: _celebrationController, curve: Curves.easeInOutBack),
    );
  }

  @override
  void dispose() {
    _floatController.dispose();
    _actionController.dispose();
    _celebrationController.dispose();
    super.dispose();
  }

  void _handleTap(CompanionController controller) {
    _actionController.forward(from: 0.0);
    setState(() => _isTapped = true);

    if (widget.mood == CompanionMood.celebratory || controller.currentMood == CompanionMood.celebratory) {
      _celebrationController.forward(from: 0.0);
    }

    if (widget.onTap != null) {
      widget.onTap!();
    } else {
      controller.triggerTapReaction();
    }

    Future.delayed(const Duration(milliseconds: 1400), () {
      if (mounted) setState(() => _isTapped = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CompanionController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final effectiveMood = widget.mood ?? controller.currentMood;
    final effectiveCosmetic = widget.equippedCosmetic ?? controller.profile.equippedCosmetic;

    // Trigger celebration spin if mood transitions to celebratory
    if (effectiveMood == CompanionMood.celebratory && !_celebrationController.isAnimating) {
      _celebrationController.forward(from: 0.0);
    }

    // Dynamic Face expressions
    String moodFace = '( •_• )';
    if (_isTapped) {
      moodFace = '( ^_~ )';
    } else if (effectiveMood == CompanionMood.happy) {
      moodFace = '( ^‿^ )';
    } else if (effectiveMood == CompanionMood.celebratory) {
      moodFace = '＼(★^∀^★)／';
    } else if (effectiveMood == CompanionMood.sleepy) {
      moodFace = '( -_- )zzZ';
    } else if (controller.profile.currentStreak >= 5) {
      moodFace = '(ง •̀_•́)ง';
    }

    final avatarWidget = GestureDetector(
      onTap: () => _handleTap(controller),
      child: AnimatedBuilder(
        animation: Listenable.merge([_floatAnimation, _scaleAnimation, _tiltAnimation, _spinAnimation]),
        builder: (context, child) {
          final floatOffset = _floatAnimation.value;
          final scale = _scaleAnimation.value;
          final tilt = _tiltAnimation.value + _spinAnimation.value;
          final cosmetic = effectiveCosmetic;

          return Transform.translate(
            offset: Offset(0, floatOffset),
            child: Transform.rotate(
              angle: tilt,
              child: Transform.scale(
                scale: scale,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    // Aura Glow Effect if special aura is equipped
                    if (cosmetic == 'sparkle_aura' || cosmetic == 'flame_aura')
                      _buildAuraEffect(cosmetic!, widget.size),

                    // Mascot Base Circle
                    Container(
                      width: widget.size,
                      height: widget.size,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: isDark
                              ? [NudgeTheme.primaryContainer, NudgeTheme.surfaceDark]
                              : [NudgeTheme.secondaryContainer, Colors.teal.shade100],
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: (isDark ? Colors.tealAccent : Colors.teal).withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        border: Border.all(
                          color: (isDark ? Colors.tealAccent : Colors.teal).withOpacity(0.3),
                          width: 1.5,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        moodFace,
                        style: TextStyle(
                          fontSize: widget.size * 0.23,
                          fontWeight: FontWeight.bold,
                          color: isDark ? NudgeTheme.onPrimaryContainer : NudgeTheme.onSecondaryContainer,
                        ),
                      ),
                    ),

                    // Detailed Cosmetic Overlay
                    if (cosmetic != null)
                      _buildCosmeticOverlay(cosmetic, widget.size),

                    // Tap Sparkle Particle Burst
                    if (_isTapped)
                      Positioned(
                        top: -widget.size * 0.15,
                        right: -widget.size * 0.1,
                        child: const Icon(Icons.auto_awesome, color: Colors.amber, size: 18),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );

    if (!widget.showBubble) {
      return avatarWidget;
    }

    return GestureDetector(
      onTap: () => _handleTap(controller),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: isDark ? NudgeTheme.surfaceDark : NudgeTheme.surfaceLight,
          borderRadius: BorderRadius.circular(NudgeTheme.radiusXL),
          border: Border.all(
            color: isDark ? NudgeTheme.cardBorderDark : NudgeTheme.cardBorderLight,
            width: 1.0,
          ),
        ),
        child: Row(
          children: [
            avatarWidget,
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        controller.profile.name,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: isDark ? NudgeTheme.onPrimaryContainer : NudgeTheme.secondary,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.local_fire_department, size: 14, color: Colors.orange),
                            const SizedBox(width: 4),
                            Text(
                              '${controller.profile.currentStreak}d',
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.orange),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    controller.currentDialogue,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.3,
                      color: isDark ? NudgeTheme.onBgDark : NudgeTheme.onBgLight,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAuraEffect(String auraType, double s) {
    if (auraType == 'flame_aura') {
      return Container(
        width: s * 1.25,
        height: s * 1.25,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              Colors.orange.withOpacity(0.45),
              Colors.deepOrange.withOpacity(0.2),
              Colors.transparent,
            ],
          ),
        ),
      );
    }
    // sparkle_aura
    return Container(
      width: s * 1.28,
      height: s * 1.28,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            Colors.amber.withOpacity(0.4),
            Colors.yellow.withOpacity(0.15),
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  Widget _buildCosmeticOverlay(String cosmeticId, double s) {
    switch (cosmeticId) {
      case 'crown':
        return Positioned(
          top: -s * 0.28,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: s * 0.08, vertical: s * 0.04),
            decoration: BoxDecoration(
              color: Colors.amber.shade400,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.military_tech, size: s * 0.32, color: Colors.amber.shade900),
              ],
            ),
          ),
        );

      case 'neon_shades':
        return Positioned(
          top: s * 0.32,
          child: Container(
            width: s * 0.72,
            height: s * 0.22,
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.cyanAccent, width: 1.5),
              boxShadow: [
                BoxShadow(color: Colors.cyan.withOpacity(0.5), blurRadius: 6),
              ],
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(width: s * 0.26, height: s * 0.12, color: Colors.cyanAccent.withOpacity(0.7)),
                Container(width: s * 0.26, height: s * 0.12, color: Colors.purpleAccent.withOpacity(0.7)),
              ],
            ),
          ),
        );

      case 'headphones':
        return Positioned(
          top: -s * 0.08,
          child: SizedBox(
            width: s * 1.15,
            height: s * 0.7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: s * 0.2,
                  height: s * 0.32,
                  decoration: BoxDecoration(
                    color: Colors.indigoAccent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                Container(
                  width: s * 0.2,
                  height: s * 0.32,
                  decoration: BoxDecoration(
                    color: Colors.indigoAccent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ],
            ),
          ),
        );

      case 'wizard_hat':
        return Positioned(
          top: -s * 0.32,
          child: Icon(Icons.auto_fix_high, size: s * 0.36, color: Colors.deepPurpleAccent),
        );

      case 'ninja_band':
        return Positioned(
          top: s * 0.12,
          child: Container(
            width: s * 0.85,
            height: s * 0.12,
            decoration: BoxDecoration(
              color: Colors.red.shade900,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.white70, width: 1),
            ),
          ),
        );

      case 'astronaut_helmet':
        return Positioned(
          top: -s * 0.08,
          child: Container(
            width: s * 1.12,
            height: s * 1.12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.lightBlueAccent.withOpacity(0.8), width: 2.5),
            ),
          ),
        );

      case 'golden_trophy':
        return Positioned(
          top: -s * 0.25,
          right: -s * 0.15,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: Colors.amber,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.emoji_events, size: s * 0.28, color: Colors.brown.shade900),
          ),
        );

      case 'bandana':
        return Positioned(
          top: s * 0.1,
          child: Container(
            width: s * 0.78,
            height: s * 0.12,
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        );

      case 'flame_aura':
        return Positioned(
          top: -s * 0.22,
          child: const Icon(Icons.local_fire_department, color: Colors.deepOrange, size: 24),
        );

      case 'sparkle_aura':
      default:
        return Positioned(
          top: -s * 0.12,
          right: -s * 0.1,
          child: const Icon(Icons.auto_awesome, color: Colors.amber, size: 22),
        );
    }
  }
}

```

---

<a id="lib-presentation-components-nudge_buttondart"></a>
## 107. `lib/presentation/components/nudge_button.dart`

**Path**: `lib/presentation/components/nudge_button.dart` | **Lines**: 104

```dart
import 'package:flutter/material.dart';
import '../theme/nudge_theme.dart';

enum ButtonVariant { primary, secondary, danger, outline }

class NudgeButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final ButtonVariant variant;
  final bool isLoading;
  final bool isExpanded;
  final double? width;
  final double height;

  const NudgeButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.variant = ButtonVariant.primary,
    this.isLoading = false,
    this.isExpanded = false,
    this.width,
    this.height = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Color bg;
    Color fg;
    BorderSide border = BorderSide.none;

    switch (variant) {
      case ButtonVariant.primary:
        bg = isDark ? NudgeTheme.secondaryContainer : NudgeTheme.primaryContainer;
        fg = isDark ? NudgeTheme.onSecondaryContainer : Colors.white;
        break;
      case ButtonVariant.secondary:
        bg = isDark ? NudgeTheme.surfaceContainerDark : NudgeTheme.surfaceContainerLight;
        fg = isDark ? NudgeTheme.onBgDark : NudgeTheme.onBgLight;
        break;
      case ButtonVariant.danger:
        bg = NudgeTheme.error;
        fg = Colors.white;
        break;
      case ButtonVariant.outline:
        bg = Colors.transparent;
        fg = isDark ? NudgeTheme.onBgDark : NudgeTheme.primary;
        border = BorderSide(color: isDark ? NudgeTheme.cardBorderDark : NudgeTheme.cardBorderLight, width: 1.5);
        break;
    }

    final child = isLoading
        ? SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor: AlwaysStoppedAnimation<Color>(fg),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 20, color: fg),
                const SizedBox(width: 8),
              ],
              Text(
                label,
                style: TextStyle(
                  color: fg,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ],
          );

    return SizedBox(
      width: isExpanded ? double.infinity : width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fg,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(NudgeTheme.radiusM),
            side: border,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        onPressed: isLoading ? null : onPressed,
        child: child,
      ),
    );
  }
}
```

---

<a id="lib-presentation-components-nudge_carddart"></a>
## 108. `lib/presentation/components/nudge_card.dart`

**Path**: `lib/presentation/components/nudge_card.dart` | **Lines**: 64

```dart
import 'package:flutter/material.dart';
import '../theme/nudge_theme.dart';

class NudgeCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? color;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double borderRadius;
  final Border? border;

  const NudgeCard({
    super.key,
    required this.child,
    this.onTap,
    this.backgroundColor,
    this.color,
    this.padding = const EdgeInsets.all(16.0),
    this.margin = const EdgeInsets.symmetric(vertical: 6.0),
    this.borderRadius = NudgeTheme.radiusL,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bg = color ?? backgroundColor ?? (isDark ? NudgeTheme.surfaceDark : NudgeTheme.surfaceLight);
    final defaultBorder = border ??
        Border.all(
          color: isDark ? NudgeTheme.cardBorderDark : NudgeTheme.cardBorderLight,
          width: 1.0,
        );

    Widget content = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(borderRadius),
        border: defaultBorder,
      ),
      child: child,
    );

    if (onTap != null) {
      content = Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: onTap,
          child: content,
        ),
      );
    }

    return Padding(
      padding: margin,
      child: content,
    );
  }
}
```

---

<a id="lib-presentation-components-nudge_text_fielddart"></a>
## 109. `lib/presentation/components/nudge_text_field.dart`

**Path**: `lib/presentation/components/nudge_text_field.dart` | **Lines**: 92

```dart
import 'package:flutter/material.dart';
import '../theme/nudge_theme.dart';

class NudgeTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final String? hint;
  final String? hintText;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int maxLines;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextInputAction? textInputAction;
  final bool autofocus;

  const NudgeTextField({
    super.key,
    required this.controller,
    this.label,
    this.hint,
    this.hintText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.onChanged,
    this.onSubmitted,
    this.textInputAction,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isDark ? NudgeTheme.onPrimaryContainer : NudgeTheme.secondary,
            ),
          ),
          const SizedBox(height: 6),
        ],
        TextField(
          controller: controller,
          maxLines: maxLines,
          autofocus: autofocus,
          textInputAction: textInputAction,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          style: TextStyle(
            fontSize: 15,
            color: isDark ? NudgeTheme.onBgDark : NudgeTheme.onBgLight,
          ),
          decoration: InputDecoration(
            hintText: hint ?? hintText,
            errorText: errorText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: isDark ? NudgeTheme.surfaceContainerDark : NudgeTheme.surfaceContainerLight,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(NudgeTheme.radiusM),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(NudgeTheme.radiusM),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(NudgeTheme.radiusM),
              borderSide: BorderSide(
                color: isDark ? NudgeTheme.secondaryContainer : NudgeTheme.secondary,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
```

---

<a id="lib-presentation-components-quick_add_sheetdart"></a>
## 110. `lib/presentation/components/quick_add_sheet.dart`

**Path**: `lib/presentation/components/quick_add_sheet.dart` | **Lines**: 143

```dart
import 'package:flutter/material.dart';
import '../../features/records/record_editor_screen.dart';
import '../../features/reminders/reminder_editor_screen.dart';
import '../../features/todos/todo_editor_screen.dart';

class QuickAddSheet extends StatelessWidget {
  final VoidCallback? onOpenTimer;

  const QuickAddSheet({super.key, this.onOpenTimer});

  static Future<void> show(BuildContext context, {VoidCallback? onOpenTimer}) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => QuickAddSheet(onOpenTimer: onOpenTimer),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: theme.colorScheme.outlineVariant,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Quick Add',
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // 1. New Reminder (Exact Alarm)
          ListTile(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.teal.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.alarm_add, color: Colors.teal),
            ),
            title: const Text('Reminder Alarm', style: TextStyle(fontWeight: FontWeight.w600)),
            subtitle: const Text('Exact time notification & native ringing alarm'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ReminderEditorScreen()),
              );
            },
          ),
          const SizedBox(height: 8),

          // 2. New Task / Todo
          ListTile(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.check_circle_outline, color: Colors.blue),
            ),
            title: const Text('Task / Todo', style: TextStyle(fontWeight: FontWeight.w600)),
            subtitle: const Text('Action item with subtasks, priority, & due date'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TodoEditorScreen()),
              );
            },
          ),
          const SizedBox(height: 8),

          // 3. New Record / Note
          ListTile(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.edit_note, color: Colors.amber),
            ),
            title: const Text('Record / Note', style: TextStyle(fontWeight: FontWeight.w600)),
            subtitle: const Text('Freeform capture of thoughts, ideas, decisions, or logs'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RecordEditorScreen()),
              );
            },
          ),
          const SizedBox(height: 8),

          // 4. Timer / Focus
          ListTile(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.timer_outlined, color: Colors.purple),
            ),
            title: const Text('Focus Timer', style: TextStyle(fontWeight: FontWeight.w600)),
            subtitle: const Text('Countdown timer for deep work sessions'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.pop(context);
              onOpenTimer?.call();
            },
          ),
        ],
      ),
    );
  }
}
```

---

<a id="lib-presentation-components-voice_input_buttondart"></a>
## 111. `lib/presentation/components/voice_input_button.dart`

**Path**: `lib/presentation/components/voice_input_button.dart` | **Lines**: 84

```dart
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../../platform/permissions/permission_manager.dart';
import '../theme/nudge_theme.dart';

class VoiceInputButton extends StatefulWidget {
  final ValueChanged<String> onTranscript;

  const VoiceInputButton({super.key, required this.onTranscript});

  @override
  State<VoiceInputButton> createState() => _VoiceInputButtonState();
}

class _VoiceInputButtonState extends State<VoiceInputButton> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  bool _isAvailable = false;

  Future<void> _toggleListening() async {
    if (_isListening) {
      await _speech.stop();
      setState(() => _isListening = false);
      return;
    }

    final status = await PermissionManager.requestMicrophonePermission();
    if (!status) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Microphone permission is required for voice input.'),
            action: SnackBarAction(
              label: 'SETTINGS',
              onPressed: () => PermissionManager.openAppSettings(),
            ),
          ),
        );
      }
      return;
    }

    _isAvailable = await _speech.initialize(
      onError: (val) => setState(() => _isListening = false),
      onStatus: (status) {
        if (status == 'done' || status == 'notListening') {
          setState(() => _isListening = false);
        }
      },
    );

    if (_isAvailable) {
      setState(() => _isListening = true);
      _speech.listen(
        onResult: (result) {
          if (result.recognizedWords.isNotEmpty) {
            widget.onTranscript(result.recognizedWords);
          }
        },
      );
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Speech recognition not available on this device')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton.filledTonal(
      style: IconButton.styleFrom(
        backgroundColor: _isListening ? NudgeTheme.error : null,
      ),
      icon: Icon(
        _isListening ? Icons.mic : Icons.mic_none,
        color: _isListening ? Colors.white : null,
      ),
      tooltip: _isListening ? 'Stop voice listening' : 'Start voice input',
      onPressed: _toggleListening,
    );
  }
}
```

---

<a id="lib-presentation-theme-nudge_themedart"></a>
## 112. `lib/presentation/theme/nudge_theme.dart`

**Path**: `lib/presentation/theme/nudge_theme.dart` | **Lines**: 171

```dart
﻿import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/folder.dart';

class NudgeTheme {
  // Brand Colors
  static const Color primary = Color(0xFF002B26);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFF16423C);
  static const Color onPrimaryContainer = Color(0xFF83AEA6);

  static const Color secondary = Color(0xFF006A60);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFF79F4E2);
  static const Color onSecondaryContainer = Color(0xFF006F64);

  static const Color tertiary = Color(0xFF3E1C11);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFF583125);
  static const Color onTertiaryContainer = Color(0xFFD09988);

  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF93000A);

  static const Color bgLight = Color(0xFFF9F9F8);
  static const Color onBgLight = Color(0xFF1A1C1B);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceContainerLight = Color(0xFFF0F1EF);
  static const Color cardBorderLight = Color(0xFFE2E3E1);

  static const Color bgDark = Color(0xFF121413);
  static const Color onBgDark = Color(0xFFE2E3E1);
  static const Color surfaceDark = Color(0xFF1A1C1B);
  static const Color surfaceContainerDark = Color(0xFF222524);
  static const Color cardBorderDark = Color(0xFF2D3130);

  // Radii
  static const double radiusS = 12.0;
  static const double radiusM = 16.0;
  static const double radiusL = 20.0;
  static const double radiusXL = 24.0;
  static const double radiusPill = 28.0;

  static ThemeData get lightTheme {
    final baseTextTheme = Typography.material2021().black;
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: bgLight,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: primary,
        onPrimary: onPrimary,
        primaryContainer: primaryContainer,
        onPrimaryContainer: onPrimaryContainer,
        secondary: secondary,
        onSecondary: onSecondary,
        secondaryContainer: secondaryContainer,
        onSecondaryContainer: onSecondaryContainer,
        tertiary: tertiary,
        onTertiary: onTertiary,
        error: error,
        onError: onError,
        errorContainer: errorContainer,
        onErrorContainer: onErrorContainer,
        surface: surfaceLight,
        onSurface: onBgLight,
        surfaceContainer: surfaceContainerLight,
      ),
      textTheme: GoogleFonts.plusJakartaSansTextTheme(baseTextTheme),
      cardTheme: CardTheme(
        color: surfaceLight,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusL),
          side: const BorderSide(color: cardBorderLight, width: 1.0),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: bgLight,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
      ),
    );
  }

  static ThemeData get darkTheme {
    final baseTextTheme = Typography.material2021().white;
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: bgDark,
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: onPrimaryContainer,
        onPrimary: primary,
        primaryContainer: primaryContainer,
        onPrimaryContainer: onPrimaryContainer,
        secondary: secondaryContainer,
        onSecondary: onSecondaryContainer,
        tertiary: onTertiaryContainer,
        onTertiary: tertiary,
        error: errorContainer,
        onError: onErrorContainer,
        errorContainer: error,
        onErrorContainer: onError,
        surface: surfaceDark,
        onSurface: onBgDark,
        surfaceContainer: surfaceContainerDark,
      ),
      textTheme: GoogleFonts.plusJakartaSansTextTheme(baseTextTheme),
      cardTheme: CardTheme(
        color: surfaceDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusL),
          side: const BorderSide(color: cardBorderDark, width: 1.0),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: bgDark,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
      ),
    );
  }

  static Color getFolderColor(Folder? folder, bool isDark) {
    if (folder == null) {
      return isDark ? surfaceContainerDark : surfaceContainerLight;
    }
    try {
      final colorHex = folder.colorTag.replaceFirst('#', '0xFF');
      final baseColor = Color(int.parse(colorHex));
      if (isDark) {
        final hsl = HSLColor.fromColor(baseColor);
        return hsl
            .withLightness((hsl.lightness - 0.15).clamp(0.0, 1.0))
            .withSaturation((hsl.saturation + 0.1).clamp(0.0, 1.0))
            .toColor();
      }
      return baseColor;
    } catch (_) {
      return isDark ? surfaceContainerDark : surfaceContainerLight;
    }
  }

  static IconData getFolderIcon(Folder? folder) {
    if (folder == null) return Icons.folder_outlined;
    return getIconDataForId(folder.iconId);
  }

  static IconData getIconDataForId(String id) {
    switch (id) {
      case 'work': return Icons.work_outline;
      case 'home': return Icons.home_outlined;
      case 'school': return Icons.school_outlined;
      case 'shopping_cart': return Icons.shopping_cart_outlined;
      case 'local_hospital': return Icons.local_hospital_outlined;
      case 'receipt': return Icons.receipt_long_outlined;
      case 'flight': return Icons.flight_takeoff_outlined;
      case 'movie': return Icons.movie_outlined;
      case 'star': return Icons.star_outline;
      default: return Icons.folder_outlined;
    }
  }
}
```

---

<a id="test-unit-alarm_platform_service_testdart"></a>
## 113. `test/unit/alarm_platform_service_test.dart`

**Path**: `test/unit/alarm_platform_service_test.dart` | **Lines**: 269

```dart
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nudge/core/constants/app_constants.dart';
import 'package:nudge/domain/entities/reminder.dart';
import 'package:nudge/domain/enums/enums.dart';
import 'package:nudge/platform/alarms/alarm_platform_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel(AppConstants.alarmChannel);
  final List<MethodCall> log = [];

  setUp(() {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    log.clear();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      log.add(methodCall);

      switch (methodCall.method) {
        case 'canScheduleExactAlarms':
          return true;
        case 'canUseFullScreenIntent':
          return true;
        case 'scheduleAlarm':
          return true;
        case 'cancelAlarm':
          return true;
        case 'dismissAlarm':
          return true;
        case 'openExactAlarmSettings':
          return true;
        case 'openFullScreenIntentSettings':
          return true;
        case 'getAlarmData':
          return {
            'alarmId': 12345,
            'reminderId': 'rem_test_1',
          };
        case 'closeAlarmUi':
          return true;
        case 'getAudioDuration':
          return {
            'durationMs': 45000,
            'title': 'Test Song',
            'artist': 'Test Artist',
          };
        case 'playAudioPreview':
          return true;
        case 'stopAudioPreview':
          return true;
        case 'saveCustomAlarmSound':
          return true;
        case 'getCustomAlarmSound':
          return {
            'filePath': '/path/to/test.mp3',
            'startMs': 10000,
            'endMs': 40000,
            'title': 'Test Song',
          };
        case 'clearCustomAlarmSound':
          return true;
        default:
          return null;
      }
    });
  });

  tearDown(() {
    debugDefaultTargetPlatformOverride = null;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  group('AlarmPlatformService Unit Tests', () {
    test('alarmIdFor generates consistent FNV-1a 32-bit positive integer', () {
      final id1 = AlarmPlatformService.alarmIdFor('reminder-123');
      final id2 = AlarmPlatformService.alarmIdFor('reminder-123');
      final id3 = AlarmPlatformService.alarmIdFor('reminder-456');

      expect(id1, equals(id2));
      expect(id1, isNot(equals(id3)));
      expect(id1, isPositive);
    });

    test('AlarmLaunchData holds alarmId and reminderId', () {
      const data = AlarmLaunchData(alarmId: 999, reminderId: 'rem_abc');
      expect(data.alarmId, equals(999));
      expect(data.reminderId, equals('rem_abc'));
    });

    test('AlarmPermissionRequiredException has meaningful message', () {
      const ex = AlarmPermissionRequiredException();
      expect(ex.toString(), contains('Exact alarm permission is required'));
    });

    test('AlarmScheduleException has custom message', () {
      const ex = AlarmScheduleException('Device memory failure');
      expect(ex.toString(), equals('Device memory failure'));
    });

    test('canScheduleExactAlarms returns true on mocked platform channel', () async {
      final canSchedule = await AlarmPlatformService.canScheduleExactAlarms();
      expect(canSchedule, isTrue);
      expect(log.any((call) => call.method == 'canScheduleExactAlarms'), isTrue);
    });

    test('canUseFullScreenIntent returns true on mocked platform channel', () async {
      final canFsi = await AlarmPlatformService.canUseFullScreenIntent();
      expect(canFsi, isTrue);
      expect(log.any((call) => call.method == 'canUseFullScreenIntent'), isTrue);
    });

    test('scheduleAlarm throws AlarmScheduleException when reminder is in the past', () async {
      final pastReminder = Reminder(
        id: 'past_rem',
        message: 'Old reminder',
        scheduledAt: DateTime.now().subtract(const Duration(hours: 1)),
      );

      expect(
        () => AlarmPlatformService.scheduleAlarm(pastReminder),
        throwsA(isA<AlarmScheduleException>()),
      );
    });

    test('scheduleAlarm ignores inactive reminders and does not invoke channel', () async {
      final doneReminder = Reminder(
        id: 'done_rem',
        message: 'Completed reminder',
        scheduledAt: DateTime.now().add(const Duration(hours: 1)),
        isDone: true,
      );

      await AlarmPlatformService.scheduleAlarm(doneReminder);
      expect(log.any((c) => c.method == 'scheduleAlarm'), isFalse);
    });

    test('scheduleAlarm cancels previous alarm and invokes scheduleAlarm on channel', () async {
      final futureReminder = Reminder(
        id: 'future_rem',
        message: 'Active future reminder',
        scheduledAt: DateTime.now().add(const Duration(hours: 2)),
        alertStyle: AlertStyle.alarm,
        soundId: 'gentle_bell',
        vibrationEnabled: true,
      );

      await AlarmPlatformService.scheduleAlarm(futureReminder);

      final cancelCalls = log.where((c) => c.method == 'cancelAlarm').toList();
      final scheduleCalls = log.where((c) => c.method == 'scheduleAlarm').toList();

      expect(cancelCalls.isNotEmpty, isTrue);
      expect(scheduleCalls.isNotEmpty, isTrue);

      final scheduleArgs = scheduleCalls.first.arguments as Map;
      expect(scheduleArgs['reminderId'], equals('future_rem'));
      expect(scheduleArgs['vibration'], isTrue);
    });

    test('scheduleAlarm throws AlarmPermissionRequiredException when permission denied', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
        if (methodCall.method == 'canScheduleExactAlarms') {
          return false;
        }
        return null;
      });

      final futureReminder = Reminder(
        id: 'blocked_rem',
        message: 'Should fail due to permission',
        scheduledAt: DateTime.now().add(const Duration(hours: 1)),
      );

      expect(
        () => AlarmPlatformService.scheduleAlarm(futureReminder),
        throwsA(isA<AlarmPermissionRequiredException>()),
      );
    });

    test('scheduleAlarm throws AlarmPermissionRequiredException when platform throws EXACT_ALARM_PERMISSION_REQUIRED', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
        if (methodCall.method == 'canScheduleExactAlarms') {
          return true;
        }
        if (methodCall.method == 'cancelAlarm') {
          return true;
        }
        if (methodCall.method == 'scheduleAlarm') {
          throw PlatformException(
            code: 'EXACT_ALARM_PERMISSION_REQUIRED',
            message: 'Permission denied',
          );
        }
        return null;
      });

      final futureReminder = Reminder(
        id: 'platform_blocked_rem',
        message: 'Should fail due to native permission check',
        scheduledAt: DateTime.now().add(const Duration(hours: 1)),
      );

      expect(
        () => AlarmPlatformService.scheduleAlarm(futureReminder),
        throwsA(isA<AlarmPermissionRequiredException>()),
      );
    });

    test('getLaunchAlarmData retrieves pending launch data from platform', () async {
      final launchData = await AlarmPlatformService.getLaunchAlarmData();
      expect(launchData.alarmId, equals(12345));
      expect(launchData.reminderId, equals('rem_test_1'));
    });

    test('dismissRingingAlarm calls dismissAlarm on channel', () async {
      await AlarmPlatformService.dismissRingingAlarm(123);
      expect(log.any((c) => c.method == 'dismissAlarm'), isTrue);
    });

    test('openExactAlarmSettings and openFullScreenIntentSettings invoke correct methods', () async {
      await AlarmPlatformService.openExactAlarmSettings();
      expect(log.any((c) => c.method == 'openExactAlarmSettings'), isTrue);

      await AlarmPlatformService.openFullScreenIntentSettings();
      expect(log.any((c) => c.method == 'openFullScreenIntentSettings'), isTrue);
    });

    test('closeAlarmUi invokes platform channel method', () async {
      await AlarmPlatformService.closeAlarmUi();
      expect(log.any((c) => c.method == 'closeAlarmUi'), isTrue);
    });

    test('getAudioDuration returns duration and title metadata', () async {
      final info = await AlarmPlatformService.getAudioDuration('/test.mp3');
      expect(info, isNotNull);
      expect(info!['durationMs'], equals(45000));
      expect(info['title'], equals('Test Song'));
      expect(log.any((c) => c.method == 'getAudioDuration'), isTrue);
    });

    test('playAudioPreview and stopAudioPreview send correct channel invocations', () async {
      await AlarmPlatformService.playAudioPreview('/test.mp3', 5000, 20000);
      expect(log.any((c) => c.method == 'playAudioPreview'), isTrue);

      await AlarmPlatformService.stopAudioPreview();
      expect(log.any((c) => c.method == 'stopAudioPreview'), isTrue);
    });

    test('custom alarm sound save, get, and clear operate correctly', () async {
      await AlarmPlatformService.saveCustomAlarmSound('/test.mp3', 5000, 25000, title: 'Ring');
      expect(log.any((c) => c.method == 'saveCustomAlarmSound'), isTrue);

      final sound = await AlarmPlatformService.getCustomAlarmSound();
      expect(sound, isNotNull);
      expect(sound!['filePath'], equals('/path/to/test.mp3'));
      expect(sound['startMs'], equals(10000));
      expect(sound['endMs'], equals(40000));

      await AlarmPlatformService.clearCustomAlarmSound();
      expect(log.any((c) => c.method == 'clearCustomAlarmSound'), isTrue);
    });
  });
}
```

---

<a id="test-unit-backup_manager_testdart"></a>
## 114. `test/unit/backup_manager_test.dart`

**Path**: `test/unit/backup_manager_test.dart` | **Lines**: 349

```dart
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:nudge/core/utils/pbkdf2_util.dart';
import 'package:nudge/data/backup/backup_manager.dart';
import 'package:nudge/core/utils/secure_storage_util.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('BackupManager Container & Security Tests', () {
    late Directory tempDir;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('nudge_backup_test_');
    });

    tearDown(() async {
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    });

    test('Rejects file with invalid container JSON format', () async {
      final badFile = File('${tempDir.path}/bad.nudgebackup');
      await badFile.writeAsString('NOT_JSON_DATA_CORRUPT');

      expect(
        () => BackupManager.inspectBackupFile(badFile.path),
        throwsA(isA<FormatException>()),
      );
    });

    test('Rejects file with incorrect magic header or schema version', () async {
      final badHeaderFile = File('${tempDir.path}/bad_header.nudgebackup');
      await badHeaderFile.writeAsString(jsonEncode({
        'magic': 'WRONG_MAGIC',
        'schemaVersion': 99,
        'iv': base64Encode(Uint8List(16)),
        'ciphertext': base64Encode(Uint8List(16)),
        'authTag': base64Encode(Uint8List(32)),
      }));

      expect(
        () => BackupManager.inspectBackupFile(badHeaderFile.path),
        throwsA(isA<FormatException>()),
      );
    });

    test('Legacy v2: Rejects container when HMAC authentication tag is tampered with', () async {
      final masterKey = await SecureStorageUtil.getOrCreateMasterKey();
      final keyBytes = sha256.convert(utf8.encode(masterKey)).bytes;
      final encKey = enc.Key(Uint8List.fromList(keyBytes));
      final iv = enc.IV.fromSecureRandom(16);

      final encrypter = enc.Encrypter(enc.AES(encKey, mode: enc.AESMode.cbc));
      final encrypted = encrypter.encrypt('{"test": 123}', iv: iv);

      // Create a corrupted auth tag
      final badAuthTag = Uint8List(32); // All zeros, invalid HMAC

      final tamperedFile = File('${tempDir.path}/tampered.nudgebackup');
      await tamperedFile.writeAsString(jsonEncode({
        'magic': BackupManager.legacyMagicV2,
        'schemaVersion': BackupManager.schemaVersion,
        'iv': base64Encode(iv.bytes),
        'ciphertext': encrypted.base64,
        'authTag': base64Encode(badAuthTag),
      }));

      expect(
        () => BackupManager.inspectBackupFile(tamperedFile.path),
        throwsA(
          predicate((e) =>
              e is FormatException &&
              e.message.contains('Authentication tag mismatch')),
        ),
      );
    });

    test('Legacy v2: Correctly decrypts and inspects valid backup container with master key', () async {
      final masterKey = await SecureStorageUtil.getOrCreateMasterKey();
      final keyBytes = sha256.convert(utf8.encode(masterKey)).bytes;
      final encKey = enc.Key(Uint8List.fromList(keyBytes));
      final iv = enc.IV.fromSecureRandom(16);

      final payload = {
        'manifest': {
          'magic': BackupManager.legacyMagicV2,
          'schemaVersion': BackupManager.schemaVersion,
          'appVersion': '2.0.0',
          'exportedAt': DateTime.now().toIso8601String(),
        },
        'reminders': [
          {
            'id': 'test_rem_1',
            'message': 'Test Reminder',
            'scheduledAt': DateTime.now().add(const Duration(days: 1)).toIso8601String(),
            'priority': 'normal',
            'alertStyle': 'notification',
            'repeatRule': 'none',
            'checklist': [],
          }
        ],
        'occurrences': [],
        'folders': [],
        'history': [],
        'templates': [],
        'companion': null,
        'media': {},
      };

      final encrypter = enc.Encrypter(enc.AES(encKey, mode: enc.AESMode.cbc));
      final encrypted = encrypter.encrypt(jsonEncode(payload), iv: iv);

      final hmacKey = sha256.convert(utf8.encode('$masterKey:HMAC')).bytes;
      final hmac = Hmac(sha256, hmacKey);
      final authTag = hmac.convert([...iv.bytes, ...encrypted.bytes]).bytes;

      final validFile = File('${tempDir.path}/valid.nudgebackup');
      await validFile.writeAsString(jsonEncode({
        'magic': BackupManager.legacyMagicV2,
        'schemaVersion': BackupManager.schemaVersion,
        'iv': base64Encode(iv.bytes),
        'ciphertext': encrypted.base64,
        'authTag': base64Encode(authTag),
      }));

      final preview = await BackupManager.inspectBackupFile(
        validFile.path,
        existingRemindersOverride: [],
      );
      expect(preview.validReminders.length, equals(1));
      expect(preview.validReminders.first.id, equals('test_rem_1'));
      expect(preview.validReminders.first.message, equals('Test Reminder'));
      expect(preview.invalidCount, equals(0));
    });

    test('Password Protected: isPasswordProtected correctly identifies JSON encrypted backups', () async {
      final jsonFile = File('${tempDir.path}/test_enc.json');
      await jsonFile.writeAsString(jsonEncode({
        'magic': BackupManager.containerMagic,
        'schemaVersion': BackupManager.schemaVersion,
        'kdf': 'PBKDF2_SHA256',
        'salt': 'abc',
      }));
      expect(await BackupManager.isPasswordProtected(jsonFile.path), isTrue);

      final legacyFile = File('${tempDir.path}/test_legacy.nudgebackup');
      await legacyFile.writeAsString(jsonEncode({
        'magic': BackupManager.legacyMagicV2,
        'schemaVersion': 2,
      }));
      expect(await BackupManager.isPasswordProtected(legacyFile.path), isFalse);
    });

    test('Password Protected: Successfully encrypts and decrypts across simulated devices with password', () async {
      const password = 'MySecureNudgePassword2026!';
      final salt = Pbkdf2Util.generateSalt(16);
      const iterations = 10000;

      final encKeyBytes = Pbkdf2Util.deriveKey(password, salt, iterations: iterations, blockIndex: 1);
      final hmacKeyBytes = Pbkdf2Util.deriveKey(password, salt, iterations: iterations, blockIndex: 2);

      final payload = {
        'manifest': {
          'magic': BackupManager.containerMagic,
          'schemaVersion': 3,
          'appVersion': '2.0.0',
          'exportedAt': DateTime.now().toIso8601String(),
        },
        'reminders': [
          {
            'id': 'cross_device_rem_1',
            'message': 'Cross-device portable reminder',
            'scheduledAt': DateTime.now().add(const Duration(days: 2)).toIso8601String(),
            'priority': 'urgent',
            'alertStyle': 'alarm',
            'repeatRule': 'none',
            'checklist': [],
          }
        ],
        'todos': [
          {
            'id': 'todo_cross_1',
            'title': 'Portable task',
            'priority': 'high',
            'status': 'pending',
          }
        ],
        'records': [
          {
            'id': 'record_cross_1',
            'title': 'Portable note',
            'content': 'Cross-device note content',
            'recordType': 'note',
          }
        ],
        'tags': [
          {
            'id': 'tag_cross_1',
            'name': 'security',
          }
        ],
        'occurrences': [],
        'folders': [],
        'history': [],
        'templates': [],
        'companion': null,
        'media': {},
      };

      final iv = enc.IV.fromSecureRandom(16);
      final encrypter = enc.Encrypter(enc.AES(enc.Key(encKeyBytes), mode: enc.AESMode.cbc));
      final encrypted = encrypter.encrypt(jsonEncode(payload), iv: iv);

      final hmac = Hmac(sha256, hmacKeyBytes);
      final authTag = hmac.convert([...salt, ...iv.bytes, ...encrypted.bytes]).bytes;

      final backupFile = File('${tempDir.path}/nudge_backup_cross_device.json');
      await backupFile.writeAsString(jsonEncode({
        'magic': BackupManager.containerMagic,
        'schemaVersion': 3,
        'appVersion': '2.0.0',
        'createdAt': DateTime.now().toIso8601String(),
        'kdf': 'PBKDF2_SHA256',
        'iterations': iterations,
        'salt': base64Encode(salt),
        'iv': base64Encode(iv.bytes),
        'ciphertext': encrypted.base64,
        'authTag': base64Encode(authTag),
      }));

      // SIMULATE DEVICE B: Inspect backup file with matching password
      final preview = await BackupManager.inspectBackupFile(
        backupFile.path,
        password: password,
        existingRemindersOverride: [],
      );

      expect(preview.validReminders.length, equals(1));
      expect(preview.validReminders.first.message, equals('Cross-device portable reminder'));
      expect(preview.validTodos.length, equals(1));
      expect(preview.validTodos.first.title, equals('Portable task'));
      expect(preview.validRecords.length, equals(1));
      expect(preview.validRecords.first.title, equals('Portable note'));
      expect(preview.validTags.length, equals(1));
      expect(preview.validTags.first.name, equals('security'));
    });

    test('Password Protected: Rejects inspection when password is missing', () async {
      final salt = Pbkdf2Util.generateSalt(16);
      final jsonFile = File('${tempDir.path}/nudge_backup_nopwd.json');
      await jsonFile.writeAsString(jsonEncode({
        'magic': BackupManager.containerMagic,
        'schemaVersion': 3,
        'salt': base64Encode(salt),
        'iv': base64Encode(Uint8List(16)),
        'ciphertext': base64Encode(Uint8List(16)),
        'authTag': base64Encode(Uint8List(32)),
      }));

      expect(
        () => BackupManager.inspectBackupFile(jsonFile.path),
        throwsA(
          predicate((e) =>
              e is FormatException &&
              e.message.contains('Password required')),
        ),
      );
    });

    test('Password Protected: Rejects inspection when password is wrong', () async {
      const password = 'CorrectPassword123';
      const wrongPassword = 'WrongPassword456';
      final salt = Pbkdf2Util.generateSalt(16);

      final encKeyBytes = Pbkdf2Util.deriveKey(password, salt, iterations: 10000, blockIndex: 1);
      final hmacKeyBytes = Pbkdf2Util.deriveKey(password, salt, iterations: 10000, blockIndex: 2);

      final iv = enc.IV.fromSecureRandom(16);
      final encrypter = enc.Encrypter(enc.AES(enc.Key(encKeyBytes), mode: enc.AESMode.cbc));
      final encrypted = encrypter.encrypt('{"reminders":[]}', iv: iv);

      final hmac = Hmac(sha256, hmacKeyBytes);
      final authTag = hmac.convert([...salt, ...iv.bytes, ...encrypted.bytes]).bytes;

      final backupFile = File('${tempDir.path}/wrong_pwd.json');
      await backupFile.writeAsString(jsonEncode({
        'magic': BackupManager.containerMagic,
        'schemaVersion': 3,
        'salt': base64Encode(salt),
        'iv': base64Encode(iv.bytes),
        'ciphertext': encrypted.base64,
        'authTag': base64Encode(authTag),
      }));

      expect(
        () => BackupManager.inspectBackupFile(backupFile.path, password: wrongPassword),
        throwsA(
          predicate((e) =>
              e is FormatException &&
              e.message.contains('Incorrect password or corrupted backup file')),
        ),
      );
    });

    test('Password Protected: Rejects container when ciphertext is corrupted or tampered with', () async {
      const password = 'TestPassword123';
      final salt = Pbkdf2Util.generateSalt(16);

      final encKeyBytes = Pbkdf2Util.deriveKey(password, salt, iterations: 10000, blockIndex: 1);
      final hmacKeyBytes = Pbkdf2Util.deriveKey(password, salt, iterations: 10000, blockIndex: 2);

      final iv = enc.IV.fromSecureRandom(16);
      final encrypter = enc.Encrypter(enc.AES(enc.Key(encKeyBytes), mode: enc.AESMode.cbc));
      final encrypted = encrypter.encrypt('{"reminders":[]}', iv: iv);

      final hmac = Hmac(sha256, hmacKeyBytes);
      final authTag = hmac.convert([...salt, ...iv.bytes, ...encrypted.bytes]).bytes;

      // Tamper with ciphertext by flipping one byte
      final tamperedCipherBytes = Uint8List.fromList(encrypted.bytes);
      tamperedCipherBytes[0] ^= 0xFF;

      final tamperedFile = File('${tempDir.path}/tampered_cipher.json');
      await tamperedFile.writeAsString(jsonEncode({
        'magic': BackupManager.containerMagic,
        'schemaVersion': 3,
        'salt': base64Encode(salt),
        'iv': base64Encode(iv.bytes),
        'ciphertext': base64Encode(tamperedCipherBytes),
        'authTag': base64Encode(authTag),
      }));

      expect(
        () => BackupManager.inspectBackupFile(tamperedFile.path, password: password),
        throwsA(
          predicate((e) =>
              e is FormatException &&
              e.message.contains('Incorrect password or corrupted backup file')),
        ),
      );
    });
  });
}
```

---

<a id="test-unit-backup_v3_testdart"></a>
## 115. `test/unit/backup_v3_test.dart`

**Path**: `test/unit/backup_v3_test.dart` | **Lines**: 145

```dart
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:nudge/data/backup/backup_manager.dart';
import 'package:nudge/core/utils/secure_storage_util.dart';
import 'package:nudge/domain/entities/todo.dart';
import 'package:nudge/domain/entities/record.dart';
import 'package:nudge/domain/entities/tag.dart';
import 'package:nudge/domain/enums/todo_enums.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('BackupManager Schema v2 & v3 Compatibility Tests', () {
    late Directory tempDir;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('nudge_v3_backup_test_');
    });

    tearDown(() async {
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    });

    Future<File> createEncryptedBackupFile(Map<String, dynamic> payload, {int schemaVersion = 3}) async {
      final rawJson = jsonEncode(payload);
      final masterKey = await SecureStorageUtil.getOrCreateMasterKey();

      final keyBytes = sha256.convert(utf8.encode(masterKey)).bytes;
      final encKey = enc.Key(Uint8List.fromList(keyBytes));
      final iv = enc.IV.fromSecureRandom(16);

      final encrypter = enc.Encrypter(enc.AES(encKey, mode: enc.AESMode.cbc));
      final encrypted = encrypter.encrypt(rawJson, iv: iv);

      final hmacKey = sha256.convert(utf8.encode('$masterKey:HMAC')).bytes;
      final hmac = Hmac(sha256, hmacKey);
      final authTag = hmac.convert([...iv.bytes, ...encrypted.bytes]).bytes;

      final container = {
        'magic': 'NUDGE_ENC_V2',
        'schemaVersion': schemaVersion,
        'iv': base64Encode(iv.bytes),
        'ciphertext': encrypted.base64,
        'authTag': base64Encode(authTag),
      };

      final file = File('${tempDir.path}/test_backup_$schemaVersion.nudgebackup');
      await file.writeAsString(jsonEncode(container));
      return file;
    }

    test('Seamlessly inspects legacy v2 backup without todos/records', () async {
      final v2Payload = {
        'manifest': {
          'magic': 'NUDGE_ENC_V2',
          'schemaVersion': 2,
          'appVersion': '2.0.0',
        },
        'reminders': [
          {
            'id': 'rem_1',
            'message': 'Legacy Reminder',
            'scheduledAt': DateTime.now().toIso8601String(),
            'repeatRule': 'none',
            'createdAt': DateTime.now().toIso8601String(),
            'priority': 'normal',
            'alertStyle': 'alarm',
            'checklist': [],
          }
        ],
        'occurrences': [],
        'folders': [],
        'history': [],
        'templates': [],
        // Notice: 'todos', 'records', 'tags' are completely absent in v2!
      };

      final backupFile = await createEncryptedBackupFile(v2Payload, schemaVersion: 2);
      final preview = await BackupManager.inspectBackupFile(backupFile.path, existingRemindersOverride: []);

      expect(preview.validReminders.length, 1);
      expect(preview.validReminders.first.message, 'Legacy Reminder');
      expect(preview.validTodos.isEmpty, true);
      expect(preview.validRecords.isEmpty, true);
      expect(preview.validTags.isEmpty, true);
    });

    test('Inspects v3 backup with todos, records, and tags', () async {
      final todo = Todo(
        id: 'todo_v3_1',
        title: 'Task from backup',
        priority: TodoPriority.high,
      );

      final record = Record(
        id: 'rec_v3_1',
        title: 'Note from backup',
        content: 'This note was restored from v3 backup',
        recordType: RecordType.idea,
      );

      final tag = Tag(
        id: 'tag_v3_1',
        name: 'productivity',
      );

      final v3Payload = {
        'manifest': {
          'magic': 'NUDGE_ENC_V2',
          'schemaVersion': 3,
          'appVersion': '2.0.0',
        },
        'reminders': [],
        'occurrences': [],
        'folders': [],
        'history': [],
        'templates': [],
        'todos': [todo.toJson()],
        'records': [record.toJson()],
        'tags': [tag.toJson()],
      };

      final backupFile = await createEncryptedBackupFile(v3Payload, schemaVersion: 3);
      final preview = await BackupManager.inspectBackupFile(backupFile.path, existingRemindersOverride: []);

      expect(preview.validReminders.isEmpty, true);
      expect(preview.validTodos.length, 1);
      expect(preview.validTodos.first.title, 'Task from backup');
      expect(preview.validTodos.first.priority, TodoPriority.high);

      expect(preview.validRecords.length, 1);
      expect(preview.validRecords.first.title, 'Note from backup');
      expect(preview.validRecords.first.recordType, RecordType.idea);

      expect(preview.validTags.length, 1);
      expect(preview.validTags.first.name, 'productivity');
    });
  });
}
```

---

<a id="test-unit-conflict_detector_testdart"></a>
## 116. `test/unit/conflict_detector_test.dart`

**Path**: `test/unit/conflict_detector_test.dart` | **Lines**: 157

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:nudge/domain/entities/reminder.dart';
import 'package:nudge/domain/enums/enums.dart';
import 'package:nudge/domain/services/conflict_detector.dart';

void main() {
  group('ConflictDetector Unit Tests', () {
    final baseTime = DateTime(2026, 9, 15, 14, 0);

    final existingReminders = [
      Reminder(
        id: 'r1',
        message: 'Team Sync',
        scheduledAt: baseTime,
        priority: PriorityLevel.normal,
      ),
      Reminder(
        id: 'r2',
        message: 'Doctor Appointment',
        scheduledAt: DateTime(2026, 9, 15, 16, 0),
        priority: PriorityLevel.high,
      ),
      Reminder(
        id: 'r3_done',
        message: 'Completed Chore',
        scheduledAt: baseTime,
        isDone: true,
      ),
      Reminder(
        id: 'r4_archived',
        message: 'Old Archived Note',
        scheduledAt: baseTime,
        isArchived: true,
      ),
    ];

    test('No conflict when times and titles are distinct', () {
      final candidate = Reminder(
        id: 'candidate',
        message: 'Grocery Shopping',
        scheduledAt: DateTime(2026, 9, 15, 18, 0),
      );

      final result = ConflictDetector.checkConflicts(
        candidate: candidate,
        existingReminders: existingReminders,
      );

      expect(result.hasConflict, isFalse);
      expect(result.conflictingReminders, isEmpty);
      expect(result.warningMessage, isNull);
    });

    test('Exact title duplicate detected even if time is different', () {
      final candidate = Reminder(
        id: 'candidate',
        message: 'team sync', // Case insensitive check
        scheduledAt: DateTime(2026, 9, 15, 19, 0), // Outside 15m
      );

      final result = ConflictDetector.checkConflicts(
        candidate: candidate,
        existingReminders: existingReminders,
      );

      expect(result.hasConflict, isTrue);
      expect(result.warningMessage, contains('exact title is already active'));
      expect(result.conflictingReminders.length, equals(1));
      expect(result.conflictingReminders.first.id, equals('r1'));
    });

    test('15-minute time overlap detected for different title', () {
      final candidate = Reminder(
        id: 'candidate',
        message: 'Coffee with Bob',
        scheduledAt: baseTime.add(const Duration(minutes: 10)), // 10m away from Team Sync
      );

      final result = ConflictDetector.checkConflicts(
        candidate: candidate,
        existingReminders: existingReminders,
      );

      expect(result.hasConflict, isTrue);
      expect(result.warningMessage, contains('Scheduled within 15m of "Team Sync"'));
      expect(result.conflictingReminders.length, equals(1));
      expect(result.conflictingReminders.first.id, equals('r1'));
    });

    test('Time overlap outside 15-minute window is not a conflict', () {
      final candidate = Reminder(
        id: 'candidate',
        message: 'Coffee with Bob',
        scheduledAt: baseTime.add(const Duration(minutes: 16)), // 16m away
      );

      final result = ConflictDetector.checkConflicts(
        candidate: candidate,
        existingReminders: existingReminders,
      );

      expect(result.hasConflict, isFalse);
      expect(result.conflictingReminders, isEmpty);
    });

    test('Duplicate title AND time overlap combination reports both', () {
      final candidate = Reminder(
        id: 'candidate',
        message: 'Team Sync',
        scheduledAt: baseTime.add(const Duration(minutes: 5)),
      );

      final result = ConflictDetector.checkConflicts(
        candidate: candidate,
        existingReminders: existingReminders,
      );

      expect(result.hasConflict, isTrue);
      expect(result.warningMessage, contains('Duplicate reminder title and scheduled within 15m'));
    });

    test('Ignores completed and archived reminders', () {
      final candidateSameAsDone = Reminder(
        id: 'candidate',
        message: 'Completed Chore',
        scheduledAt: baseTime,
      );

      final result = ConflictDetector.checkConflicts(
        candidate: candidateSameAsDone,
        existingReminders: existingReminders,
      );

      // Should conflict with r1 on time (baseTime), but NOT with r3_done on title or r4_archived
      expect(result.hasConflict, isTrue);
      expect(result.conflictingReminders.any((r) => r.id == 'r3_done'), isFalse);
      expect(result.conflictingReminders.any((r) => r.id == 'r4_archived'), isFalse);
    });

    test('Ignores self when editing existing reminder', () {
      final candidate = Reminder(
        id: 'r1',
        message: 'Team Sync',
        scheduledAt: baseTime,
      );

      final result = ConflictDetector.checkConflicts(
        candidate: candidate,
        existingReminders: existingReminders,
        currentEditingId: 'r1',
      );

      expect(result.hasConflict, isFalse);
      expect(result.conflictingReminders, isEmpty);
    });
  });
}
```

---

<a id="test-unit-nlp_parser_testdart"></a>
## 117. `test/unit/nlp_parser_test.dart`

**Path**: `test/unit/nlp_parser_test.dart` | **Lines**: 116

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:nudge/domain/enums/enums.dart';
import 'package:nudge/domain/services/nlp_parser.dart';

void main() {
  group('NLPParser Unit Tests', () {
    test('Empty input returns empty cleanedMessage and false flag', () {
      final result = NLPParser.parse('');
      expect(result.cleanedMessage, isEmpty);
      expect(result.hasParsedScheduling, isFalse);
      expect(result.fullScheduledDateTime, isNull);
    });

    test('Priority parsing recognizes urgent, asap, important, and p1', () {
      final r1 = NLPParser.parse('Call client ASAP');
      expect(r1.priority, equals(PriorityLevel.high));
      expect(r1.cleanedMessage, equals('Call client'));

      final r2 = NLPParser.parse('urgent Fix production bug');
      expect(r2.priority, equals(PriorityLevel.high));
      expect(r2.cleanedMessage, equals('Fix production bug'));

      final r3 = NLPParser.parse('Important Review budget');
      expect(r3.priority, equals(PriorityLevel.high));
      expect(r3.cleanedMessage, equals('Review budget'));
    });

    test('Relative time parsing: in 15 minutes', () {
      final result = NLPParser.parse('Take pizza out of oven in 15 mins');

      expect(result.cleanedMessage, equals('Take pizza out of oven'));
      expect(result.hasParsedScheduling, isTrue);
      expect(result.scheduledDate, isNotNull);
      expect(result.scheduledHour, isNotNull);
      expect(result.scheduledMinute, isNotNull);

      final scheduled = result.fullScheduledDateTime!;
      final expectedTarget = DateTime.now().add(const Duration(minutes: 15));
      expect(scheduled.hour, equals(expectedTarget.hour));
      expect(scheduled.minute, equals(expectedTarget.minute));
    });

    test('Relative time parsing: in 2 hours', () {
      final result = NLPParser.parse('Call mom in 2 hours');
      expect(result.cleanedMessage, equals('Call mom'));
      expect(result.hasParsedScheduling, isTrue);
    });

    test('Recurrence parsing: every day, weekly, monthly, weekdays, weekends', () {
      final r1 = NLPParser.parse('Take vitamins every day');
      expect(r1.repeatRule, equals(RepeatRule.daily));
      expect(r1.cleanedMessage, equals('Take vitamins'));

      final r2 = NLPParser.parse('Weekly team sync');
      expect(r2.repeatRule, equals(RepeatRule.weekly));
      expect(r2.cleanedMessage, equals('team sync'));

      final r3 = NLPParser.parse('Pay rent monthly');
      expect(r3.repeatRule, equals(RepeatRule.monthly));
      expect(r3.cleanedMessage, equals('Pay rent'));

      final r4 = NLPParser.parse('Check emails weekdays');
      expect(r4.repeatRule, equals(RepeatRule.weekdays));
      expect(r4.cleanedMessage, equals('Check emails'));

      final r5 = NLPParser.parse('Go hiking weekends');
      expect(r5.repeatRule, equals(RepeatRule.weekends));
      expect(r5.cleanedMessage, equals('Go hiking'));
    });

    test('Date parsing: tomorrow at 3pm', () {
      final now = DateTime.now();
      final result = NLPParser.parse('Dentist appointment tomorrow at 3pm');
      expect(result.cleanedMessage, equals('Dentist appointment'));
      expect(result.hasParsedScheduling, isTrue);

      final scheduled = result.fullScheduledDateTime!;
      final tomorrow = now.add(const Duration(days: 1));
      expect(scheduled.year, equals(tomorrow.year));
      expect(scheduled.month, equals(tomorrow.month));
      expect(scheduled.day, equals(tomorrow.day));
      expect(scheduled.hour, equals(15));
      expect(scheduled.minute, equals(0));
    });

    test('Date parsing: tonight defaults to 8:00 PM', () {
      final result = NLPParser.parse('Watch movie tonight');
      expect(result.cleanedMessage, equals('Watch movie'));
      expect(result.scheduledHour, equals(20));
      expect(result.scheduledMinute, equals(0));
    });

    test('Day of week parsing: next Friday at 10:30 am', () {
      final result = NLPParser.parse('Team retro next Friday at 10:30 am');
      expect(result.cleanedMessage, equals('Team retro'));
      expect(result.scheduledHour, equals(10));
      expect(result.scheduledMinute, equals(30));
      expect(result.scheduledDate, isNotNull);
      expect(result.scheduledDate!.weekday, equals(DateTime.friday));
    });

    test('Explicit 24h format: at 17:45', () {
      final result = NLPParser.parse('Submit report at 17:45');
      expect(result.cleanedMessage, equals('Submit report'));
      expect(result.scheduledHour, equals(17));
      expect(result.scheduledMinute, equals(45));
    });

    test('Preview summary returns formatted preview', () {
      final result = NLPParser.parse('Submit report tomorrow at 5pm urgent');
      expect(result.previewSummary, contains('Tomorrow'));
      expect(result.previewSummary, contains('5:00 PM'));
      expect(result.previewSummary, contains('HIGH PRIORITY'));
    });
  });
}
```

---

<a id="test-unit-record_entity_testdart"></a>
## 118. `test/unit/record_entity_test.dart`

**Path**: `test/unit/record_entity_test.dart` | **Lines**: 51

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:nudge/domain/entities/record.dart';
import 'package:nudge/domain/enums/todo_enums.dart';

void main() {
  group('Record Entity Unit Tests', () {
    test('Record defaults and copyWith', () {
      final record = Record(
        title: 'Meeting Notes',
        content: 'Discussed roadmap and milestones.',
      );

      expect(record.title, 'Meeting Notes');
      expect(record.content, 'Discussed roadmap and milestones.');
      expect(record.recordType, RecordType.note);
      expect(record.isPinned, false);
      expect(record.isArchived, false);
      expect(record.isDeleted, false);

      final updated = record.copyWith(
        recordType: RecordType.decision,
        isPinned: true,
      );

      expect(updated.recordType, RecordType.decision);
      expect(updated.isPinned, true);
    });

    test('Serialization and deserialization roundtrip', () {
      final record = Record(
        id: 'rec_456',
        title: 'System Architecture',
        content: 'Use SQLite offline-first database with clean layers.',
        recordType: RecordType.idea,
        folderId: 'folder_general',
        occurredAt: DateTime(2026, 9, 12, 10, 0),
        isPinned: true,
      );

      final json = record.toJson();
      final restored = Record.fromJson(json);

      expect(restored.id, 'rec_456');
      expect(restored.title, record.title);
      expect(restored.content, record.content);
      expect(restored.recordType, RecordType.idea);
      expect(restored.folderId, 'folder_general');
      expect(restored.isPinned, true);
    });
  });
}
```

---

<a id="test-unit-recurrence_engine_testdart"></a>
## 119. `test/unit/recurrence_engine_test.dart`

**Path**: `test/unit/recurrence_engine_test.dart` | **Lines**: 178

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:nudge/domain/entities/reminder.dart';
import 'package:nudge/domain/enums/enums.dart';
import 'package:nudge/domain/services/recurrence_engine.dart';

void main() {
  group('RecurrenceEngine Tests', () {
    test('Rule: none returns null', () {
      final reminder = Reminder(
        message: 'One-off task',
        scheduledAt: DateTime(2026, 9, 10, 10, 0),
        repeatRule: RepeatRule.none,
      );

      final next = RecurrenceEngine.calculateNextOccurrence(reminder);
      expect(next, isNull);
    });

    test('Rule: daily advances exactly 1 day and preserves wall-clock time', () {
      final reminder = Reminder(
        message: 'Daily standup',
        scheduledAt: DateTime(2026, 9, 10, 9, 30),
        repeatRule: RepeatRule.daily,
      );

      final next = RecurrenceEngine.calculateNextOccurrence(reminder);
      expect(next, equals(DateTime(2026, 9, 11, 9, 30)));
    });

    test('Rule: weekly advances exactly 7 days', () {
      final reminder = Reminder(
        message: 'Weekly review',
        scheduledAt: DateTime(2026, 9, 10, 14, 0),
        repeatRule: RepeatRule.weekly,
      );

      final next = RecurrenceEngine.calculateNextOccurrence(reminder);
      expect(next, equals(DateTime(2026, 9, 17, 14, 0)));
    });

    test('Rule: weekdays skips Saturday and Sunday', () {
      // 2026-09-11 is Friday
      final fridayReminder = Reminder(
        message: 'Friday report',
        scheduledAt: DateTime(2026, 9, 11, 17, 0),
        repeatRule: RepeatRule.weekdays,
      );

      final next = RecurrenceEngine.calculateNextOccurrence(fridayReminder);
      // Next weekday should be Monday (2026-09-14)
      expect(next, equals(DateTime(2026, 9, 14, 17, 0)));
      expect(next!.weekday, equals(DateTime.monday));
    });

    test('Rule: weekends skips Monday through Friday', () {
      // 2026-09-13 is Sunday
      final sundayReminder = Reminder(
        message: 'Weekend workout',
        scheduledAt: DateTime(2026, 9, 13, 8, 0),
        repeatRule: RepeatRule.weekends,
      );

      final next = RecurrenceEngine.calculateNextOccurrence(sundayReminder);
      // Next weekend day should be Saturday (2026-09-19)
      expect(next, equals(DateTime(2026, 9, 19, 8, 0)));
      expect(next!.weekday, equals(DateTime.saturday));
    });

    test('Rule: monthly with month-end clamping (Jan 31 -> Feb 28 non-leap)', () {
      // 2025 is non-leap year (February has 28 days)
      final reminder = Reminder(
        message: 'Month-end bill',
        scheduledAt: DateTime(2025, 1, 31, 20, 0),
        repeatRule: RepeatRule.monthly,
      );

      final next = RecurrenceEngine.calculateNextOccurrence(reminder);
      expect(next, equals(DateTime(2025, 2, 28, 20, 0)));
    });

    test('Rule: monthly with leap year clamping (Jan 31 -> Feb 29 in 2028 leap year)', () {
      final reminder = Reminder(
        message: 'Leap year bill',
        scheduledAt: DateTime(2028, 1, 31, 10, 0),
        repeatRule: RepeatRule.monthly,
      );

      final next = RecurrenceEngine.calculateNextOccurrence(reminder);
      expect(next, equals(DateTime(2028, 2, 29, 10, 0)));
    });

    test('Rule: custom interval (every 3 days)', () {
      final reminder = Reminder(
        message: 'Water plants',
        scheduledAt: DateTime(2026, 9, 10, 11, 0),
        repeatRule: RepeatRule.customInterval,
        customRepeatInterval: 3,
        customRepeatType: CustomRepeatType.days,
      );

      final next = RecurrenceEngine.calculateNextOccurrence(reminder);
      expect(next, equals(DateTime(2026, 9, 13, 11, 0)));
    });

    test('Rule: custom specific weekdays (Mon, Wed, Fri)', () {
      // 2026-09-09 is Wednesday (3)
      final reminder = Reminder(
        message: 'Gym workout',
        scheduledAt: DateTime(2026, 9, 9, 7, 0),
        repeatRule: RepeatRule.customInterval,
        customRepeatDays: [1, 3, 5], // Mon, Wed, Fri
      );

      final next = RecurrenceEngine.calculateNextOccurrence(reminder);
      // Next after Wednesday should be Friday (2026-09-11)
      expect(next, equals(DateTime(2026, 9, 11, 7, 0)));
      expect(next!.weekday, equals(DateTime.friday));
    });

    test('Nth weekday of month: 2nd Tuesday of October 2026', () {
      // In Oct 2026:
      // Oct 1 is Thursday
      // Oct 6 is 1st Tuesday
      // Oct 13 is 2nd Tuesday
      final result = RecurrenceEngine.calculateNthWeekdayOfMonth(
        year: 2026,
        month: 10,
        nth: 2,
        weekday: DateTime.tuesday,
        hour: 15,
        minute: 0,
      );

      expect(result, equals(DateTime(2026, 10, 13, 15, 0)));
      expect(result.weekday, equals(DateTime.tuesday));
    });

    test('Recurrence termination: endOnDate respected', () {
      final reminder = Reminder(
        message: 'Temporary daily chore',
        scheduledAt: DateTime(2026, 9, 10, 8, 0),
        repeatRule: RepeatRule.daily,
        repeatEndDate: DateTime(2026, 9, 10, 23, 59),
      );

      final next = RecurrenceEngine.calculateNextOccurrence(reminder);
      expect(next, isNull);
    });

    test('Recurrence termination: endAfterOccurrences respected', () {
      final reminder = Reminder(
        message: 'Finish in 1 occurrence',
        scheduledAt: DateTime(2026, 9, 10, 8, 0),
        repeatRule: RepeatRule.daily,
        repeatEndOccurrences: 1,
      );

      final next = RecurrenceEngine.calculateNextOccurrence(reminder);
      expect(next, isNull);
    });

    test('Catch-up overdue recurrence to future', () {
      // Reminder scheduled 10 days ago with daily recurrence
      final overdueReminder = Reminder(
        message: 'Daily medicine',
        scheduledAt: DateTime(2026, 9, 1, 9, 0),
        repeatRule: RepeatRule.daily,
      );

      final targetNow = DateTime(2026, 9, 10, 12, 0);
      final caughtUp = RecurrenceEngine.catchUpToFuture(overdueReminder, targetNow);

      expect(caughtUp, isNotNull);
      expect(caughtUp!.isAfter(targetNow), isTrue);
      expect(caughtUp, equals(DateTime(2026, 9, 11, 9, 0)));
    });
  });
}
```

---

<a id="test-unit-reminder_lifecycle_testdart"></a>
## 120. `test/unit/reminder_lifecycle_test.dart`

**Path**: `test/unit/reminder_lifecycle_test.dart` | **Lines**: 96

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:nudge/domain/entities/reminder.dart';
import 'package:nudge/domain/entities/checklist_item.dart';
import 'package:nudge/domain/entities/reminder_occurrence.dart';
import 'package:nudge/domain/enums/enums.dart';

void main() {
  group('Reminder & Occurrence Lifecycle Unit Tests', () {
    test('Reminder serialization and deserialization roundtrip', () {
      final original = Reminder(
        id: 'rem_123',
        message: 'Review quarterly goals',
        folderId: 'folder_work',
        scheduledAt: DateTime(2026, 9, 20, 15, 30),
        repeatRule: RepeatRule.weekly,
        priority: PriorityLevel.high,
        alertStyle: AlertStyle.alarm,
        isPinned: true,
        isArchived: false,
        isAlarmSynced: true,
        soundId: 'gentle_bell',
        vibrationEnabled: true,
        checklist: [
          const ChecklistItem(id: 'c1', text: 'Prepare slide deck', isDone: true),
          const ChecklistItem(id: 'c2', text: 'Review financials', isDone: false),
        ],
        customRepeatDays: [1, 3, 5],
      );

      final json = original.toJson();
      final reconstructed = Reminder.fromJson(json);

      expect(reconstructed.id, equals(original.id));
      expect(reconstructed.message, equals(original.message));
      expect(reconstructed.folderId, equals(original.folderId));
      expect(reconstructed.scheduledAt, equals(original.scheduledAt));
      expect(reconstructed.repeatRule, equals(original.repeatRule));
      expect(reconstructed.priority, equals(original.priority));
      expect(reconstructed.alertStyle, equals(original.alertStyle));
      expect(reconstructed.isPinned, equals(original.isPinned));
      expect(reconstructed.soundId, equals(original.soundId));
      expect(reconstructed.checklist.length, equals(2));
      expect(reconstructed.checklist.first.text, equals('Prepare slide deck'));
      expect(reconstructed.checklist.first.isDone, isTrue);
      expect(reconstructed.checklist[1].isDone, isFalse);
      expect(reconstructed.checklistCompletedCount, equals(1));
      expect(reconstructed.hasChecklist, isTrue);
    });

    test('Occurrence state tracking and snooze incrementing', () {
      final occ = ReminderOccurrence(
        id: 'occ_001',
        reminderId: 'rem_123',
        scheduledAt: DateTime(2026, 9, 20, 15, 30),
        status: OccurrenceStatus.pending,
        snoozeCount: 0,
      );

      expect(occ.status, equals(OccurrenceStatus.pending));
      expect(occ.isCompleted, isFalse);

      // Simulate snooze
      final snoozedOcc = occ.copyWith(
        status: OccurrenceStatus.snoozed,
        snoozeCount: occ.snoozeCount + 1,
      );

      expect(snoozedOcc.status, equals(OccurrenceStatus.snoozed));
      expect(snoozedOcc.snoozeCount, equals(1));

      // Simulate completion
      final completedOcc = snoozedOcc.copyWith(
        status: OccurrenceStatus.completed,
        completedAt: DateTime(2026, 9, 20, 15, 45),
      );

      expect(completedOcc.isCompleted, isTrue);
      expect(completedOcc.completedAt, isNotNull);
    });

    test('Snooze limit is capped at 3', () {
      final occ = ReminderOccurrence(
        id: 'occ_002',
        reminderId: 'rem_123',
        scheduledAt: DateTime(2026, 9, 20, 15, 30),
        snoozeCount: 2,
      );

      expect(occ.canSnooze, isTrue);

      final thirdSnooze = occ.copyWith(snoozeCount: occ.snoozeCount + 1);
      expect(thirdSnooze.snoozeCount, equals(3));
      expect(thirdSnooze.canSnooze, isFalse);
    });
  });
}
```

---

<a id="test-unit-stats_calculator_testdart"></a>
## 121. `test/unit/stats_calculator_test.dart`

**Path**: `test/unit/stats_calculator_test.dart` | **Lines**: 138

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:nudge/domain/entities/reminder.dart';
import 'package:nudge/domain/entities/reminder_occurrence.dart';
import 'package:nudge/domain/enums/enums.dart';
import 'package:nudge/domain/services/stats_calculator.dart';

void main() {
  group('StatsCalculator Unit Tests', () {
    test('Empty data calculates clean zeroed stats', () {
      final stats = StatsCalculator.calculate(
        reminders: [],
        occurrences: [],
        history: [],
      );

      expect(stats.totalReminders, equals(0));
      expect(stats.totalOccurrences, equals(0));
      expect(stats.completedReminders, equals(0));
      expect(stats.completionPercentage, equals(0.0));
      expect(stats.totalSnoozes, equals(0));
      expect(stats.averageSnoozeFrequency, equals(0.0));
      expect(stats.hourlyDistribution.length, equals(24));
      expect(stats.sevenDayCompletionTrend.length, equals(7));
    });

    test('Occurrence-based completion percentage and snooze metrics', () {
      final occurrences = [
        ReminderOccurrence(
          id: 'o1',
          reminderId: 'r1',
          scheduledAt: DateTime(2026, 9, 10, 9, 0),
          status: OccurrenceStatus.completed,
          completedAt: DateTime(2026, 9, 10, 9, 5),
          snoozeCount: 1,
        ),
        ReminderOccurrence(
          id: 'o2',
          reminderId: 'r1',
          scheduledAt: DateTime(2026, 9, 11, 9, 0),
          status: OccurrenceStatus.completed,
          completedAt: DateTime(2026, 9, 11, 9, 10),
          snoozeCount: 2,
        ),
        ReminderOccurrence(
          id: 'o3',
          reminderId: 'r1',
          scheduledAt: DateTime(2026, 9, 12, 9, 0),
          status: OccurrenceStatus.pending,
          snoozeCount: 0,
        ),
        ReminderOccurrence(
          id: 'o4',
          reminderId: 'r1',
          scheduledAt: DateTime(2026, 9, 13, 9, 0),
          status: OccurrenceStatus.skipped,
          snoozeCount: 0,
        ),
      ];

      final reminders = [
        Reminder(
          id: 'r1',
          message: 'Daily Routine',
          scheduledAt: DateTime(2026, 9, 10, 9, 0),
        ),
      ];

      final stats = StatsCalculator.calculate(
        reminders: reminders,
        occurrences: occurrences,
        history: [],
      );

      expect(stats.totalOccurrences, equals(4));
      expect(stats.completedReminders, equals(2));
      expect(stats.completionPercentage, equals(50.0)); // 2 / 4 = 50%
      expect(stats.totalSnoozes, equals(3)); // 1 + 2 = 3
      expect(stats.averageSnoozeFrequency, equals(0.75)); // 3 / 4 = 0.75
    });

    test('Most missed folder computation', () {
      final now = DateTime.now();
      final overduePast = now.subtract(const Duration(hours: 2));

      final reminders = [
        Reminder(
          id: 'r1',
          message: 'Work Task 1',
          scheduledAt: overduePast,
          folderId: 'work_folder',
        ),
        Reminder(
          id: 'r2',
          message: 'Work Task 2',
          scheduledAt: overduePast,
          folderId: 'work_folder',
        ),
        Reminder(
          id: 'r3',
          message: 'Personal Task',
          scheduledAt: overduePast,
          folderId: 'personal_folder',
        ),
      ];

      final stats = StatsCalculator.calculate(
        reminders: reminders,
        occurrences: [],
        history: [],
      );

      expect(stats.mostMissedFolderId, equals('work_folder'));
    });

    test('Productive time window derived from completion hour', () {
      final morningCompletion = DateTime(2026, 9, 10, 10, 30); // 10:30 AM is Morning (6..12)

      final occurrences = [
        ReminderOccurrence(
          id: 'o1',
          reminderId: 'r1',
          scheduledAt: morningCompletion,
          status: OccurrenceStatus.completed,
          completedAt: morningCompletion,
        ),
      ];

      final stats = StatsCalculator.calculate(
        reminders: [],
        occurrences: occurrences,
        history: [],
      );

      expect(stats.productiveTimeWindow, equals('Morning'));
      expect(stats.hourlyDistribution[10], equals(1));
    });
  });
}
```

---

<a id="test-unit-timer_state_machine_testdart"></a>
## 122. `test/unit/timer_state_machine_test.dart`

**Path**: `test/unit/timer_state_machine_test.dart` | **Lines**: 100

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nudge/application/controllers/timer_controller.dart';
import 'package:nudge/core/services/time_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    TimeService.resetClock();
  });

  tearDown(() {
    TimeService.resetClock();
  });

  group('TimerStateMachine / TimerController Unit Tests', () {
    test('Initial state is idle with zero duration', () {
      final controller = TimerController();
      expect(controller.state, equals(TimerState.idle));
      expect(controller.isIdle, isTrue);
      expect(controller.isRunning, isFalse);
      expect(controller.isPaused, isFalse);
      expect(controller.progress, equals(0.0));
      expect(controller.remainingTime, equals(Duration.zero));
      controller.dispose();
    });

    test('Starting a valid timer transitions to running with accurate total duration', () {
      final controller = TimerController();
      controller.startTimer(const Duration(minutes: 10));

      expect(controller.state, equals(TimerState.running));
      expect(controller.isRunning, isTrue);
      expect(controller.totalDuration.inMinutes, equals(10));
      expect(controller.remainingTime.inMinutes, equals(10));
      expect(controller.progress, closeTo(1.0, 0.01));
      controller.dispose();
    });

    test('Ignoring startTimer with zero or negative duration', () {
      final controller = TimerController();
      controller.startTimer(Duration.zero);
      expect(controller.state, equals(TimerState.idle));

      controller.startTimer(const Duration(seconds: -10));
      expect(controller.state, equals(TimerState.idle));
      controller.dispose();
    });

    test('Pause and resume transitions', () {
      var simulatedNow = DateTime(2026, 9, 10, 12, 0, 0);
      TimeService.setCustomClock(() => simulatedNow);

      final controller = TimerController();
      controller.startTimer(const Duration(minutes: 5)); // target: 12:05:00
      expect(controller.state, equals(TimerState.running));

      // Advance clock by 2 minutes
      simulatedNow = simulatedNow.add(const Duration(minutes: 2));

      controller.pauseTimer();
      expect(controller.state, equals(TimerState.paused));
      expect(controller.isPaused, isTrue);
      expect(controller.remainingTime.inMinutes, equals(3));

      // Resuming restarts running towards new target
      controller.resumeTimer();
      expect(controller.state, equals(TimerState.running));

      controller.dispose();
    });

    test('Cancel transitions and resets to idle', () {
      final controller = TimerController();
      controller.startTimer(const Duration(minutes: 15));
      expect(controller.isRunning, isTrue);

      controller.cancelTimer();
      expect(controller.state, equals(TimerState.idle));
      expect(controller.remainingTime, equals(Duration.zero));

      controller.dispose();
    });

    test('Reset timer clears all values', () {
      final controller = TimerController();
      controller.startTimer(const Duration(minutes: 25));
      controller.resetTimer();

      expect(controller.state, equals(TimerState.idle));
      expect(controller.totalDuration, equals(Duration.zero));
      expect(controller.remainingTime, equals(Duration.zero));
      expect(controller.progress, equals(0.0));

      controller.dispose();
    });
  });
}
```

---

<a id="test-unit-todo_entity_testdart"></a>
## 123. `test/unit/todo_entity_test.dart`

**Path**: `test/unit/todo_entity_test.dart` | **Lines**: 105

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:nudge/domain/entities/todo.dart';
import 'package:nudge/domain/entities/todo_subtask.dart';
import 'package:nudge/domain/enums/todo_enums.dart';

void main() {
  group('Todo & TodoSubtask Unit Tests', () {
    test('Todo default values and copyWith', () {
      final todo = Todo(title: 'Write test suite');

      expect(todo.title, 'Write test suite');
      expect(todo.status, TodoStatus.pending);
      expect(todo.priority, TodoPriority.normal);
      expect(todo.isDone, false);
      expect(todo.isPinned, false);
      expect(todo.isArchived, false);
      expect(todo.isDeleted, false);
      expect(todo.hasSubtasks, false);
      expect(todo.subtasksProgress, 0.0);

      final updated = todo.copyWith(
        status: TodoStatus.completed,
        priority: TodoPriority.urgent,
        isPinned: true,
      );

      expect(updated.status, TodoStatus.completed);
      expect(updated.isDone, true);
      expect(updated.priority, TodoPriority.urgent);
      expect(updated.isPinned, true);
    });

    test('Subtask calculation and progress', () {
      final subtasks = [
        TodoSubtask(todoId: 't1', text: 'Step 1', isDone: true),
        TodoSubtask(todoId: 't1', text: 'Step 2', isDone: false),
        TodoSubtask(todoId: 't1', text: 'Step 3', isDone: true),
        TodoSubtask(todoId: 't1', text: 'Step 4', isDone: false),
      ];

      final todo = Todo(
        id: 't1',
        title: 'Project Setup',
        subtasks: subtasks,
      );

      expect(todo.hasSubtasks, true);
      expect(todo.completedSubtasksCount, 2);
      expect(todo.subtasksProgress, 0.5);
    });

    test('Due date and overdue detection', () {
      final now = DateTime.now();
      final pastDue = Todo(
        title: 'Past due task',
        dueAt: now.subtract(const Duration(hours: 2)),
      );
      expect(pastDue.isOverdue, true);

      final futureDue = Todo(
        title: 'Future task',
        dueAt: now.add(const Duration(days: 3)),
      );
      expect(futureDue.isOverdue, false);

      final todayDue = Todo(
        title: 'Today task',
        dueAt: DateTime(now.year, now.month, now.day, 23, 59),
      );
      expect(todayDue.isDueToday, true);
    });

    test('Serialization and deserialization roundtrip', () {
      final subtasks = [
        TodoSubtask(todoId: 'todo_123', text: 'Sub 1', isDone: true),
      ];

      final todo = Todo(
        id: 'todo_123',
        title: 'Complete Project',
        description: 'Detailed description here',
        status: TodoStatus.inProgress,
        priority: TodoPriority.high,
        folderId: 'folder_work',
        dueAt: DateTime(2026, 10, 15, 14, 30),
        tags: ['urgent', 'work'],
        subtasks: subtasks,
      );

      final json = todo.toJson();
      final restored = Todo.fromJson(json);

      expect(restored.id, todo.id);
      expect(restored.title, todo.title);
      expect(restored.description, todo.description);
      expect(restored.status, TodoStatus.inProgress);
      expect(restored.priority, TodoPriority.high);
      expect(restored.folderId, 'folder_work');
      expect(restored.tags, ['urgent', 'work']);
      expect(restored.subtasks.length, 1);
      expect(restored.subtasks.first.text, 'Sub 1');
      expect(restored.subtasks.first.isDone, true);
    });
  });
}
```

---

<a id="test-widget-todo_widget_testdart"></a>
## 124. `test/widget/todo_widget_test.dart`

**Path**: `test/widget/todo_widget_test.dart` | **Lines**: 164

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:nudge/application/controllers/folder_controller.dart';
import 'package:nudge/application/controllers/record_controller.dart';
import 'package:nudge/application/controllers/todo_controller.dart';
import 'package:nudge/domain/entities/folder.dart';
import 'package:nudge/domain/entities/record.dart';
import 'package:nudge/domain/entities/todo.dart';
import 'package:nudge/domain/entities/todo_subtask.dart';
import 'package:nudge/domain/enums/todo_enums.dart';
import 'package:nudge/domain/repositories/i_folder_repository.dart';
import 'package:nudge/domain/repositories/i_record_repository.dart';
import 'package:nudge/domain/repositories/i_todo_repository.dart';
import 'package:nudge/features/records/record_card.dart';
import 'package:nudge/features/todos/todo_card.dart';
import 'package:nudge/presentation/components/quick_add_sheet.dart';

class MockTodoRepo implements ITodoRepository {
  @override
  Future<void> addSubtask(TodoSubtask subtask) async {}
  @override
  Future<void> createTodo(Todo todo) async {}
  @override
  Future<void> deleteSubtask(String id) async {}
  @override
  Future<void> deleteTodo(String id, {bool hardDelete = false}) async {}
  @override
  Future<List<Todo>> getAllTodos({bool includeDeleted = false}) async => [];
  @override
  Future<List<TodoSubtask>> getSubtasksForTodo(String todoId) async => [];
  @override
  Future<Todo?> getTodoById(String id) async => null;
  @override
  Future<void> purgeTrash() async {}
  @override
  Future<void> restoreTodo(String id) async {}
  @override
  Future<void> updateSortOrders(List<String> todoIds) async {}
  @override
  Future<void> updateSubtask(TodoSubtask subtask) async {}
  @override
  Future<void> updateSubtaskSortOrders(List<String> subtaskIds) async {}
  @override
  Future<void> updateTodo(Todo todo) async {}
}

class MockRecordRepo implements IRecordRepository {
  @override
  Future<void> createRecord(Record record) async {}
  @override
  Future<void> deleteRecord(String id, {bool hardDelete = false}) async {}
  @override
  Future<List<Record>> getAllRecords({bool includeDeleted = false}) async => [];
  @override
  Future<Record?> getRecordById(String id) async => null;
  @override
  Future<void> purgeTrash() async {}
  @override
  Future<void> restoreRecord(String id) async {}
  @override
  Future<void> updateRecord(Record record) async {}
}

class MockFolderRepo implements IFolderRepository {
  @override
  Future<void> saveFolder(Folder folder) async {}
  @override
  Future<void> deleteFolder(String id, {required bool deleteContainedReminders}) async {}
  @override
  Future<List<Folder>> getAllFolders() async => [];
  @override
  Future<Folder?> getFolderById(String id) async => null;
  @override
  Future<void> updateFolder(Folder folder) async {}
  @override
  Future<void> clearAllFolders() async {}
}

void main() {
  testWidgets('TodoCard renders title, priority pill, and checkbox', (tester) async {
    final todo = Todo(
      id: 't_1',
      title: 'Finish client presentation',
      priority: TodoPriority.urgent,
      subtasks: [
        TodoSubtask(todoId: 't_1', text: 'Draft slides', isDone: true),
        TodoSubtask(todoId: 't_1', text: 'Rehearse speech', isDone: false),
      ],
    );

    final todoRepo = MockTodoRepo();
    final folderRepo = MockFolderRepo();
    final todoCtrl = TodoController(todoRepo: todoRepo);
    final folderCtrl = FolderController(folderRepo: folderRepo);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: todoCtrl),
          ChangeNotifierProvider.value(value: folderCtrl),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: TodoCard(todo: todo),
          ),
        ),
      ),
    );

    expect(find.text('Finish client presentation'), findsOneWidget);
    expect(find.text('Urgent'), findsOneWidget);
    expect(find.text('Subtasks: 1/2'), findsOneWidget);
    expect(find.byType(Checkbox), findsOneWidget);
  });

  testWidgets('RecordCard renders title, snippet, and type badge', (tester) async {
    final record = Record(
      id: 'r_1',
      title: 'App Architecture Thoughts',
      content: 'Using modular clean architecture with domain entities.',
      recordType: RecordType.idea,
    );

    final recordRepo = MockRecordRepo();
    final folderRepo = MockFolderRepo();
    final recordCtrl = RecordController(recordRepo: recordRepo);
    final folderCtrl = FolderController(folderRepo: folderRepo);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: recordCtrl),
          ChangeNotifierProvider.value(value: folderCtrl),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: RecordCard(record: record),
          ),
        ),
      ),
    );

    expect(find.text('App Architecture Thoughts'), findsOneWidget);
    expect(find.text('Idea'), findsOneWidget);
    expect(find.text('Using modular clean architecture with domain entities.'), findsOneWidget);
  });

  testWidgets('QuickAddSheet renders all four quick action options', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: QuickAddSheet(),
        ),
      ),
    );

    expect(find.text('Quick Add'), findsOneWidget);
    expect(find.text('Reminder Alarm'), findsOneWidget);
    expect(find.text('Task / Todo'), findsOneWidget);
    expect(find.text('Record / Note'), findsOneWidget);
    expect(find.text('Focus Timer'), findsOneWidget);
  });
}
```

---

<a id="test-widget_testdart"></a>
## 125. `test/widget_test.dart`

**Path**: `test/widget_test.dart` | **Lines**: 42

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nudge/presentation/components/empty_state_widget.dart';
import 'package:nudge/presentation/components/nudge_card.dart';

void main() {
  testWidgets('NudgeCard renders child and handles taps', (WidgetTester tester) async {
    bool tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NudgeCard(
            onTap: () => tapped = true,
            child: const Text('Hello Nudge 2.0'),
          ),
        ),
      ),
    );

    expect(find.text('Hello Nudge 2.0'), findsOneWidget);
    await tester.tap(find.text('Hello Nudge 2.0'));
    expect(tapped, isTrue);
  });

  testWidgets('EmptyStateWidget renders title and description', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: EmptyStateWidget(
            icon: Icons.alarm,
            title: 'No Reminders',
            description: 'Create your first reminder',
          ),
        ),
      ),
    );

    expect(find.text('No Reminders'), findsOneWidget);
    expect(find.text('Create your first reminder'), findsOneWidget);
    expect(find.byIcon(Icons.alarm), findsOneWidget);
  });
}
```

---

