import SwiftUI
import SwiftData

struct AddMealView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var mealType: MealType = .lunch
    @State private var calories = ""
    @State private var protein = ""
    @State private var date = Date.now

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("What did you eat?", text: $name)
                    Picker("Meal", selection: $mealType) {
                        ForEach(MealType.allCases) { Text($0.title).tag($0) }
                    }
                    DatePicker("When", selection: $date)
                }
                Section("Nutrition") {
                    LabeledContent("Calories (kcal)") {
                        TextField("0", text: $calories)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                    }
                    LabeledContent("Protein (g)") {
                        TextField("0", text: $protein)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                    }
                }
            }
            .navigationTitle("New Meal")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save", action: save).disabled(name.trimmed.isEmpty)
                }
            }
        }
    }

    private func save() {
        let meal = Meal(
            date: date,
            name: name.trimmed,
            mealType: mealType,
            calories: Int(calories.trimmed) ?? 0,
            proteinGrams: Int(protein.trimmed) ?? 0
        )
        context.insert(meal)
        dismiss()
    }
}

#Preview {
    AddMealView()
        .modelContainer(PreviewData.container)
}
