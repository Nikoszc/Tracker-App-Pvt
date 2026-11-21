import SwiftUI
import SwiftData

/// Dashboard: a snapshot of today across every section. Tap a card to jump to that tab.
struct TodayView: View {
    @Binding var selection: AppTab

    @Query private var workouts: [Workout]
    @Query private var meals: [Meal]
    @Query private var studySessions: [StudySession]
    @Query private var todos: [TodoItem]

    private let columns = [GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 16)]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    progressHeader

                    LazyVGrid(columns: columns, spacing: 16) {
                        SummaryCard(
                            section: .gym,
                            value: todaysWorkoutMinutes.minutesFormatted,
                            caption: "\(todaysWorkouts.count) workout\(todaysWorkouts.count == 1 ? "" : "s")"
                        ) { selection = .section(.gym) }

                        SummaryCard(
                            section: .diet,
                            value: "\(todaysCalories)",
                            caption: "kcal · \(todaysMeals.count) meal\(todaysMeals.count == 1 ? "" : "s")"
                        ) { selection = .section(.diet) }

                        SummaryCard(
                            section: .studies,
                            value: todaysStudyMinutes.minutesFormatted,
                            caption: "\(todaysStudySessions.count) session\(todaysStudySessions.count == 1 ? "" : "s")"
                        ) { selection = .section(.studies) }

                        SummaryCard(
                            section: .todo,
                            value: "\(todosDoneToday)/\(todosDoneToday + openTodos)",
                            caption: "tasks done"
                        ) { selection = .section(.todo) }
                    }
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Today")
        }
    }

    // MARK: - Header

    private var progressHeader: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(Date.now.formatted(date: .complete, time: .omitted))
                .font(.subheadline)
                .foregroundStyle(.secondary)

            ProgressView(value: Double(sectionsActiveToday), total: Double(TrackerSection.allCases.count)) {
                Text("\(sectionsActiveToday) of \(TrackerSection.allCases.count) areas tracked today")
                    .font(.headline)
            }
            .tint(.accentColor)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 16))
    }

    // MARK: - Today's numbers

    private var todaysWorkouts: [Workout] { workouts.filter { $0.date.isToday } }
    private var todaysMeals: [Meal] { meals.filter { $0.date.isToday } }
    private var todaysStudySessions: [StudySession] { studySessions.filter { $0.date.isToday } }

    private var todaysWorkoutMinutes: Int { todaysWorkouts.reduce(0) { $0 + $1.durationMinutes } }
    private var todaysCalories: Int { todaysMeals.reduce(0) { $0 + $1.calories } }
    private var todaysStudyMinutes: Int { todaysStudySessions.reduce(0) { $0 + $1.durationMinutes } }

    private var openTodos: Int { todos.filter { !$0.isDone }.count }
    private var todosDoneToday: Int { todos.filter { $0.completedAt?.isToday ?? false }.count }

    private var sectionsActiveToday: Int {
        [
            !todaysWorkouts.isEmpty,
            !todaysMeals.isEmpty,
            !todaysStudySessions.isEmpty,
            todosDoneToday > 0,
        ]
        .filter { $0 }
        .count
    }
}

#Preview {
    TodayView(selection: .constant(.today))
        .modelContainer(PreviewData.container)
}
