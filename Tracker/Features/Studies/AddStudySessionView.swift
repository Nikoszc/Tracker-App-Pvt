import SwiftUI
import SwiftData

struct AddStudySessionView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @State private var subject = ""
    @State private var durationMinutes = 60
    @State private var date = Date.now
    @State private var notes = ""

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Subject (e.g. Algorithms)", text: $subject)
                    Stepper("Duration: \(durationMinutes.minutesFormatted)", value: $durationMinutes, in: 5...600, step: 5)
                    DatePicker("When", selection: $date)
                }
                Section("Notes") {
                    TextField("Topics covered…", text: $notes, axis: .vertical)
                        .lineLimit(3...6)
                }
            }
            .navigationTitle("New Study Session")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save", action: save).disabled(subject.trimmed.isEmpty)
                }
            }
        }
    }

    private func save() {
        context.insert(StudySession(date: date, subject: subject.trimmed, durationMinutes: durationMinutes, notes: notes.trimmed))
        dismiss()
    }
}

#Preview {
    AddStudySessionView()
        .modelContainer(PreviewData.container)
}
