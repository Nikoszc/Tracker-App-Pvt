import Foundation
import SwiftData

enum MealType: String, CaseIterable, Identifiable {
    case breakfast
    case lunch
    case dinner
    case snack

    var id: String { rawValue }
    var title: String { rawValue.capitalized }
}

@Model
final class Meal {
    var date: Date
    var name: String
    var calories: Int
    var proteinGrams: Int
    /// Stored as a string so SwiftData can filter/sort on it easily.
    var mealTypeRaw: String

    var mealType: MealType {
        get { MealType(rawValue: mealTypeRaw) ?? .snack }
        set { mealTypeRaw = newValue.rawValue }
    }

    init(date: Date = .now, name: String, mealType: MealType, calories: Int, proteinGrams: Int = 0) {
        self.date = date
        self.name = name
        self.mealTypeRaw = mealType.rawValue
        self.calories = calories
        self.proteinGrams = proteinGrams
    }
}

extension Meal: Dated {}
