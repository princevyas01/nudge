package com.personal.nudge.nudge

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
