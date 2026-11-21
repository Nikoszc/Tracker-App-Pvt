import Foundation
import SwiftData

@Model
final class TodoItem {
    var title: String
    var isDone: Bool
    var createdAt: Date
    var completedAt: Date?

    init(title: String, createdAt: Date = .now) {
        self.title = title
        self.isDone = false
        self.createdAt = createdAt
        self.completedAt = nil
    }

    func toggle() {
        isDone.toggle()
        completedAt = isDone ? .now : nil
    }
}
