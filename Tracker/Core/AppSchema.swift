import SwiftData

/// Every SwiftData model the app persists. Add new models here when adding a section.
enum AppSchema {
    static let models: [any PersistentModel.Type] = [
        Workout.self,
        Meal.self,
        StudySession.self,
        TodoItem.self,
    ]
}
