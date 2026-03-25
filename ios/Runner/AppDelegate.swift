import Flutter
import UIKit
import WidgetKit

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(
            name: "com.example.home_widget/widget",
            binaryMessenger: controller.binaryMessenger
        )

        channel.setMethodCallHandler { [weak self] (call, result) in
            switch call.method {
            case "updateWidget":
                self?.handleUpdateWidget(call: call, result: result)
            case "updateLastAccess":
                self?.handleUpdateLastAccess(call: call, result: result)
            case "forceRefresh":
                self?.handleForceRefresh(result: result)
            default:
                result(FlutterMethodNotImplemented)
            }
        }

        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func handleUpdateWidget(call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? [String: Any] else {
            result(FlutterError(code: "INVALID_ARGS", message: "Invalid arguments", details: nil))
            return
        }

        let defaults = UserDefaults(suiteName: "group.com.example.homeWidget")
        defaults?.set(args["action_done"] as? Bool ?? false, forKey: "action_done")
        defaults?.set(args["widget_title"] as? String ?? "", forKey: "widget_title")
        defaults?.set(args["widget_message"] as? String ?? "", forKey: "widget_message")
        defaults?.set(args["widget_image_name"] as? String ?? "", forKey: "widget_image_name")

        if #available(iOS 14.0, *) {
            WidgetCenter.shared.reloadAllTimelines()
        }

        result(true)
    }

    private func handleUpdateLastAccess(call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? [String: Any],
              let timestamp = args["timestamp"] as? Int else {
            result(FlutterError(code: "INVALID_ARGS", message: "Invalid arguments", details: nil))
            return
        }

        let defaults = UserDefaults(suiteName: "group.com.example.homeWidget")
        defaults?.set(timestamp, forKey: "last_access_timestamp")

        if #available(iOS 14.0, *) {
            WidgetCenter.shared.reloadAllTimelines()
        }

        result(true)
    }

    private func handleForceRefresh(result: @escaping FlutterResult) {
        if #available(iOS 14.0, *) {
            WidgetCenter.shared.reloadAllTimelines()
        }
        result(true)
    }
}
