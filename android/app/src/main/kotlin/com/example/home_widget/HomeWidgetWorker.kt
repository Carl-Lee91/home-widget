package com.example.home_widget

import android.appwidget.AppWidgetManager
import android.content.ComponentName
import android.content.Context
import androidx.work.ExistingWorkPolicy
import androidx.work.OneTimeWorkRequestBuilder
import androidx.work.Worker
import androidx.work.WorkerParameters
import java.util.concurrent.TimeUnit

class HomeWidgetWorker(
    context: Context,
    workerParams: WorkerParameters,
) : Worker(context, workerParams) {

    override fun doWork(): Result {
        val prefs = applicationContext.getSharedPreferences(
            HomeWidgetProvider.PREFS_NAME,
            Context.MODE_PRIVATE,
        )
        val lastAccessMs = prefs.getLong("last_access_timestamp", 0L)
        val nowMs = System.currentTimeMillis()

        // Risk mitigation: timestamp=0 means app never opened, skip inactivity check
        if (lastAccessMs <= 0) return Result.success()

        val isInactive = (nowMs - lastAccessMs) >= HomeWidgetProvider.INACTIVITY_THRESHOLD_MS

        if (isInactive) {
            prefs.edit()
                .putString("widget_title", "Come back!")
                .putString("widget_message", "We miss you!")
                .putString("widget_image_name", "come_back")
                .apply()
        }

        // Refresh widget
        val appWidgetManager = AppWidgetManager.getInstance(applicationContext)
        val widgetComponent = ComponentName(applicationContext, HomeWidgetProvider::class.java)
        val widgetIds = appWidgetManager.getAppWidgetIds(widgetComponent)
        if (widgetIds.isNotEmpty()) {
            HomeWidgetProvider.updateWidgets(applicationContext, appWidgetManager, widgetIds)
        }

        // If not yet inactive, re-enqueue for another check
        if (!isInactive) {
            val remainingMs = HomeWidgetProvider.INACTIVITY_THRESHOLD_MS - (nowMs - lastAccessMs)
            val delayMs = if (remainingMs > 0) remainingMs else 0

            val nextWork = OneTimeWorkRequestBuilder<HomeWidgetWorker>()
                .setInitialDelay(delayMs, TimeUnit.MILLISECONDS)
                .addTag("home_widget_inactivity")
                .build()

            androidx.work.WorkManager.getInstance(applicationContext).enqueueUniqueWork(
                "home_widget_inactivity_check",
                ExistingWorkPolicy.REPLACE,
                nextWork,
            )
        }

        return Result.success()
    }
}
