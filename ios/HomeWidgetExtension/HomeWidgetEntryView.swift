import SwiftUI
import WidgetKit

struct HomeWidgetEntryView: View {
    var entry: HomeWidgetEntry

    var body: some View {
        ZStack {
            backgroundGradient

            VStack(alignment: .leading, spacing: 8) {
                Image(systemName: iconName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 36, height: 36)
                    .foregroundColor(.white)

                Text(entry.title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .lineLimit(1)

                Text(entry.message)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.8))
                    .lineLimit(2)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
    }

    private var backgroundGradient: LinearGradient {
        if entry.isInactive {
            return LinearGradient(
                gradient: Gradient(colors: [.orange, .red]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        } else if entry.actionDone {
            return LinearGradient(
                gradient: Gradient(colors: [.green, .blue]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        } else {
            return LinearGradient(
                gradient: Gradient(colors: [.purple, .blue]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }

    private var iconName: String {
        if entry.isInactive {
            return "exclamationmark.circle.fill"
        } else if entry.actionDone {
            return "checkmark.circle.fill"
        } else {
            return "hand.tap.fill"
        }
    }
}
