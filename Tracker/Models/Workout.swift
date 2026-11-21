import Foundation
import SwiftData

@Model
final class Workout {
    var date: Date
    var name: String
    var durationMinutes: Int
    var notes: String

    init(date: Date = .now, name: String, durationMinutes: Int, notes: String = "") {
        self.date = date
        self.name = name
        self.durationMinutes = durationMinutes
        self.notes = notes
    }
}

extension Workout: Dated {}
