import Foundation
import SwiftData

@Model
final class StudySession {
    var date: Date
    var subject: String
    var durationMinutes: Int
    var notes: String

    init(date: Date = .now, subject: String, durationMinutes: Int, notes: String = "") {
        self.date = date
        self.subject = subject
        self.durationMinutes = durationMinutes
        self.notes = notes
    }
}

extension StudySession: Dated {}
