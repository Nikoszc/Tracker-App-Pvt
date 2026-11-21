import SwiftUI
import SwiftData

struct AddWorkoutView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var durationMinutes = 45
    @State private var date = Date.now
    @State private var notes = ""

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Workout (e.g. Push day, 5k run)", text: $name)
                    Stepper("Duration: \(durationMinutes.minutesFormatted)", value: $durationMinutes, in: 5...300, step: 5)
                    DatePicker("When", selection: $date)
                }
                Section("Notes") {
                    TextField("Sets, weights, how it felt…", text: $notes, axis: .vertical)
                        .lineLimit(3...6)
                }
            }
            .navigationTitle("New Workout")
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
        context.insert(Workout(date: date, name: name.trimmed, durationMinutes: durationMinutes, notes: notes.trimmed))
        dismiss()
    }
}

#Preview {
    AddWorkoutView()
        .modelContainer(PreviewData.container)
}
