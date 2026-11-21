import Foundation
import SwiftData

/// In-memory store with sample data, used only by SwiftUI previews.
@MainActor
enum PreviewData {
    static let container: ModelContainer = {
        do {
            let container = try ModelContainer(
                for: Schema(AppSchema.models),
                configurations: [ModelConfiguration(isStoredInMemoryOnly: true)]
            )
            insertSamples(into: container.mainContext)
            return container
        } catch {
            fatalError("Failed to create preview container: \(error)")
        }
    }()

    private static func insertSamples(into context: ModelContext) {
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: .now) ?? .now

        context.insert(Workout(name: "Push day", durationMinutes: 60, notes: "Bench 3x8, OHP 3x10"))
        context.insert(Workout(date: yesterday, name: "5k run", durationMinutes: 28))

        context.insert(Meal(name: "Oats & banana", mealType: .breakfast, calories: 420, proteinGrams: 14))
        context.insert(Meal(name: "Chicken rice bowl", mealType: .lunch, calories: 650, proteinGrams: 45))
        context.insert(Meal(date: yesterday, name: "Paneer wrap", mealType: .dinner, calories: 580, proteinGrams: 28))

        context.insert(StudySession(subject: "Data Structures", durationMinutes: 90, notes: "Heaps and priority queues"))
        context.insert(StudySession(date: yesterday, subject: "System Design", durationMinutes: 45))

        let done = TodoItem(title: "Pay electricity bill")
        done.toggle()
        context.insert(done)
        context.insert(TodoItem(title: "Buy groceries"))
        context.insert(TodoItem(title: "Call mom"))
    }
}
