import SwiftUI
import SwiftData

struct DietView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Meal.date, order: .reverse) private var meals: [Meal]
    @State private var isAdding = false

    var body: some View {
        NavigationStack {
            Group {
                if meals.isEmpty {
                    ContentUnavailableView(
                        "No meals logged",
                        systemImage: TrackerSection.diet.systemImage,
                        description: Text("Tap + to log what you ate.")
                    )
                } else {
                    List {
                        ForEach(meals.groupedByDay()) { group in
                            Section {
                                ForEach(group.items) { MealRow(meal: $0) }
                                    .onDelete { offsets in
                                        offsets.forEach { context.delete(group.items[$0]) }
                                    }
                            } header: {
                                Text("\(group.day.dayTitle) · \(group.items.reduce(0) { $0 + $1.calories }) kcal")
                            }
                        }
                    }
                }
            }
            .navigationTitle(TrackerSection.diet.title)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button { isAdding = true } label: { Label("Add Meal", systemImage: "plus") }
                }
            }
            .sheet(isPresented: $isAdding) { AddMealView() }
        }
    }
}

private struct MealRow: View {
    let meal: Meal

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(meal.name).font(.headline)
                Text(meal.mealType.title)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 4) {
                Text("\(meal.calories) kcal")
                    .foregroundStyle(TrackerSection.diet.tint)
                if meal.proteinGrams > 0 {
                    Text("\(meal.proteinGrams) g protein")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .monospacedDigit()
        }
        .padding(.vertical, 2)
    }
}

#Preview {
    DietView()
        .modelContainer(PreviewData.container)
}
