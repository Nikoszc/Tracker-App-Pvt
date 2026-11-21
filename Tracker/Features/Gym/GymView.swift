import SwiftUI
import SwiftData

struct GymView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Workout.date, order: .reverse) private var workouts: [Workout]
    @State private var isAdding = false

    var body: some View {
        NavigationStack {
            Group {
                if workouts.isEmpty {
                    ContentUnavailableView(
                        "No workouts yet",
                        systemImage: TrackerSection.gym.systemImage,
                        description: Text("Tap + to log your first workout.")
                    )
                } else {
                    List {
                        ForEach(workouts.groupedByDay()) { group in
                            Section {
                                ForEach(group.items) { WorkoutRow(workout: $0) }
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
            .navigationTitle(TrackerSection.gym.title)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button { isAdding = true } label: { Label("Add Workout", systemImage: "plus") }
                }
            }
            .sheet(isPresented: $isAdding) { AddWorkoutView() }
        }
    }
}

private struct WorkoutRow: View {
    let workout: Workout

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(workout.name).font(.headline)
                Spacer()
                Text(workout.durationMinutes.minutesFormatted)
                    .foregroundStyle(TrackerSection.gym.tint)
                    .monospacedDigit()
            }
            if !workout.notes.isEmpty {
                Text(workout.notes)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
        }
        .padding(.vertical, 2)
    }
}

#Preview {
    GymView()
        .modelContainer(PreviewData.container)
}
