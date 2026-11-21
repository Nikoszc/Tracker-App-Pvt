import SwiftUI

struct SummaryCard: View {
    let section: TrackerSection
    let value: String
    let caption: String
    var action: () -> Void = {}

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                section.label
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(section.tint)

                Text(value)
                    .font(.system(.title, design: .rounded, weight: .bold))
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.6)

                Text(caption)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 16))
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    SummaryCard(section: .gym, value: "1h 15m", caption: "2 workouts")
        .padding()
        .background(Color(.systemGroupedBackground))
}
