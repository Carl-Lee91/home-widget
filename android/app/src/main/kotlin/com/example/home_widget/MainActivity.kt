package com.example.home_widget

import android.appwidget.AppWidgetManager
import android.content.ComponentName
import android.content.Context
import androidx.work.ExistingWorkPolicy
import androidx.work.OneTimeWorkRequestBuilder
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.util.concurrent.TimeUnit

class MainActivity : FlutterActivity() {
    companion object {
        private const val CHANNEL = "com.example.home_widget/widget"
        const val PREFS_NAME = "home_widget_prefs"
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "updateWidget" -> handleUpdateWidget(call.arguments as? Map<*, *>, result)
                    "updateLastAccess" -> handleUpdateLastAccess(call.arguments as? Map<*, *>, result)
                    "forceRefresh" -> handleForceRefresh(result)
                    else -> result.notImplemented()
                }
            }
    }

    private fun handleUpdateWidget(args: Map<*, *>?, result: MethodChannel.Result) {
        if (args == null) {
            result.error("INVALID_ARGS", "Arguments required", null)
            return
        }

        val prefs = getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
        prefs.edit()
            .putBoolean("action_done", args["action_done"] as? Boolean ?: false)
            .putString("widget_title", args["widget_title"] as? String ?: "")
            .putString("widget_message", args["widget_message"] as? String ?: "")
            .putString("widget_image_name", args["widget_image_name"] as? String ?: "")
            .apply()

        refreshWidget()
        result.success(true)
    }

    private fun handleUpdateLastAccess(args: Map<*, *>?, result: MethodChannel.Result) {
        if (args == null) {
            result.error("INVALID_ARGS", "Arguments required", null)
            return
        }

        val timestamp = (args["timestamp"] as? Number)?.toLong() ?: 0L
        val prefs = getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
        prefs.edit()
            .putLong("last_access_timestamp", timestamp)
            .apply()

        enqueueInactivityWorker()
        refreshWidget()
        result.success(true)
    }

    private fun handleForceRefresh(result: MethodChannel.Result) {
        refreshWidget()
        result.success(true)
    }

    private fun refreshWidget() {
        val appWidgetManager = AppWidgetManager.getInstance(this)
        val widgetComponent = ComponentName(this, HomeWidgetProvider::class.java)
        val widgetIds = appWidgetManager.getAppWidgetIds(widgetComponent)
        if (widgetIds.isNotEmpty()) {
            HomeWidgetProvider.updateWidgets(this, appWidgetManager, widgetIds)
        }
    }

    private fun enqueueInactivityWorker() {
        val workRequest = OneTimeWorkRequestBuilder<HomeWidgetWorker>()
            .setInitialDelay(1, TimeUnit.MINUTES)
            .addTag("home_widget_inactivity")
            .build()

        androidx.work.WorkManager.getInstance(this).enqueueUniqueWork(
            "home_widget_inactivity_check",
            ExistingWorkPolicy.REPLACE,
            workRequest,
        )
    }
}
