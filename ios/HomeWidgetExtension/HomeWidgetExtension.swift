import WidgetKit
import SwiftUI

@main
struct HomeWidgetExtensionBundle: WidgetBundle {
    var body: some Widget {
        HomeWidget()
    }
}

struct HomeWidget: Widget {
    let kind: String = "HomeWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: HomeWidgetTimelineProvider()) { entry in
            HomeWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Home Widget")
        .description("Shows app status and reminders.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}
