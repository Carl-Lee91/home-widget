package com.example.home_widget

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.Intent
import android.widget.RemoteViews

class HomeWidgetProvider : AppWidgetProvider() {

    companion object {
        const val PREFS_NAME = "home_widget_prefs"
        const val INACTIVITY_THRESHOLD_MS = 60_000L

        fun updateWidgets(
            context: Context,
            appWidgetManager: AppWidgetManager,
            appWidgetIds: IntArray,
        ) {
            for (appWidgetId in appWidgetIds) {
                updateSingleWidget(context, appWidgetManager, appWidgetId)
            }
        }

        private fun updateSingleWidget(
            context: Context,
            appWidgetManager: AppWidgetManager,
            appWidgetId: Int,
        ) {
            val prefs = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
            val actionDone = prefs.getBoolean("action_done", false)
            val lastAccessMs = prefs.getLong("last_access_timestamp", 0L)
            val nowMs = System.currentTimeMillis()

            // Risk mitigation: timestamp=0 means app never opened, don't mark as inactive
            val isInactive = lastAccessMs > 0 && (nowMs - lastAccessMs) >= INACTIVITY_THRESHOLD_MS

            val views = RemoteViews(context.packageName, R.layout.home_widget_layout)

            when {
                isInactive -> {
                    views.setTextViewText(R.id.widget_title, "Come back!")
                    views.setTextViewText(R.id.widget_message, "We miss you!")
                    views.setImageViewResource(R.id.widget_image, R.drawable.ic_come_back)
                }
                actionDone -> {
                    val title = prefs.getString("widget_title", "Action Complete!") ?: "Action Complete!"
                    val message = prefs.getString("widget_message", "You did it!") ?: "You did it!"
                    views.setTextViewText(R.id.widget_title, title)
                    views.setTextViewText(R.id.widget_message, message)
                    views.setImageViewResource(R.id.widget_image, R.drawable.ic_action_done)
                }
                else -> {
                    val title = prefs.getString("widget_title", "Welcome") ?: "Welcome"
                    val message = prefs.getString("widget_message", "Open the app to get started") ?: "Open the app"
                    views.setTextViewText(R.id.widget_title, title)
                    views.setTextViewText(R.id.widget_message, message)
                    views.setImageViewResource(R.id.widget_image, R.drawable.ic_action_done)
                }
            }

            val intent = Intent(context, MainActivity::class.java)
            val pendingIntent = PendingIntent.getActivity(
                context, 0, intent,
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
            )
            views.setOnClickPendingIntent(R.id.widget_root, pendingIntent)

            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
    ) {
        updateWidgets(context, appWidgetManager, appWidgetIds)
    }
}
