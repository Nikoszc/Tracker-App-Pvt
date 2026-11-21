import SwiftUI
import SwiftData

struct StudiesView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \StudySession.date, order: .reverse) private var sessions: [StudySession]
    @State private var isAdding = false

    var body: some View {
        NavigationStack {
            Group {
                if sessions.isEmpty {
                    ContentUnavailableView(
                        "No study sessions yet",
                        systemImage: TrackerSection.studies.systemImage,
                        description: Text("Tap + to log time spent studying.")
                    )
                } else {
                    List {
                        ForEach(sessions.groupedByDay()) { group in
                            Section {
                                ForEach(group.items) { StudySessionRow(session: $0) }
                                    .onDelete { offsets in
                                        offsets.forEach { context.delete(group.items[$0]) }
                                    }
                            } header: {
                                Text("\(group.day.dayTitle) · \(group.items.reduce(0) { $0 + $1.durationMinutes }.minutesFormatted)")
                            }
                        }
                    }
                }
            }
            .navigationTitle(TrackerSection.studies.title)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button { isAdding = true } label: { Label("Add Session", systemImage: "plus") }
                }
            }
            .sheet(isPresented: $isAdding) { AddStudySessionView() }
        }
    }
}

private struct StudySessionRow: View {
    let session: StudySession

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(session.subject).font(.headline)
                Spacer()
                Text(session.durationMinutes.minutesFormatted)
                    .foregroundStyle(TrackerSection.studies.tint)
                    .monospacedDigit()
            }
            if !session.notes.isEmpty {
                Text(session.notes)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
        }
        .padding(.vertical, 2)
    }
}

#Preview {
    StudiesView()
        .modelContainer(PreviewData.container)
}
