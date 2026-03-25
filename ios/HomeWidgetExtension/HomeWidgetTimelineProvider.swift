import WidgetKit
import SwiftUI

struct HomeWidgetEntry: TimelineEntry {
    let date: Date
    let actionDone: Bool
    let title: String
    let message: String
    let imageName: String
    let isInactive: Bool
}

struct HomeWidgetTimelineProvider: TimelineProvider {

    private let appGroupId = "group.com.example.homeWidget"
    private let inactivityThresholdMs: Int = 60_000

    func placeholder(in context: Context) -> HomeWidgetEntry {
        HomeWidgetEntry(
            date: Date(),
            actionDone: false,
            title: "Home Widget",
            message: "Loading...",
            imageName: "default",
            isInactive: false
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (HomeWidgetEntry) -> Void) {
        let entry = createEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<HomeWidgetEntry>) -> Void) {
        let now = Date()
        let entry = createEntry(date: now)

        let defaults = UserDefaults(suiteName: appGroupId)
        let lastAccessMs = defaults?.integer(forKey: "last_access_timestamp") ?? 0

        var entries: [HomeWidgetEntry] = [entry]

        // Risk mitigation: only schedule inactivity entry if timestamp > 0
        // (timestamp=0 means app never opened, don't show "come back")
        if !entry.isInactive && lastAccessMs > 0 {
            let lastAccessDate = Date(timeIntervalSince1970: Double(lastAccessMs) / 1000.0)
            let inactivityDate = lastAccessDate.addingTimeInterval(Double(inactivityThresholdMs) / 1000.0)

            if inactivityDate > now {
                let inactiveEntry = HomeWidgetEntry(
                    date: inactivityDate,
                    actionDone: entry.actionDone,
                    title: "Come back!",
                    message: "We miss you!",
                    imageName: "come_back",
                    isInactive: true
                )
                entries.append(inactiveEntry)
            }
        }

        let refreshDate = Calendar.current.date(byAdding: .minute, value: 15, to: now)!
        let timeline = Timeline(entries: entries, policy: .after(refreshDate))
        completion(timeline)
    }

    private func createEntry(date: Date) -> HomeWidgetEntry {
        let defaults = UserDefaults(suiteName: appGroupId)
        let actionDone = defaults?.bool(forKey: "action_done") ?? false
        let title = defaults?.string(forKey: "widget_title") ?? "Welcome"
        let message = defaults?.string(forKey: "widget_message") ?? "Open the app"
        let imageName = defaults?.string(forKey: "widget_image_name") ?? "default"
        let lastAccessMs = defaults?.integer(forKey: "last_access_timestamp") ?? 0

        // Risk mitigation: timestamp=0 means never opened, skip inactivity check
        let nowMs = Int(date.timeIntervalSince1970 * 1000)
        let isInactive = lastAccessMs > 0 && (nowMs - lastAccessMs) >= inactivityThresholdMs

        if isInactive {
            return HomeWidgetEntry(
                date: date,
                actionDone: actionDone,
                title: "Come back!",
                message: "We miss you!",
                imageName: "come_back",
                isInactive: true
            )
        }

        return HomeWidgetEntry(
            date: date,
            actionDone: actionDone,
            title: title,
            message: message,
            imageName: imageName,
            isInactive: false
        )
    }
}
