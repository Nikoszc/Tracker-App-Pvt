import SwiftUI

/// The trackable areas of the app. Central place for each section's name, icon and color.
enum TrackerSection: String, CaseIterable, Identifiable {
    case gym
    case diet
    case studies
    case todo

    var id: String { rawValue }

    var title: String {
        switch self {
        case .gym: "Gym"
        case .diet: "Diet"
        case .studies: "Studies"
        case .todo: "To-Do"
        }
    }

    var systemImage: String {
        switch self {
        case .gym: "dumbbell.fill"
        case .diet: "fork.knife"
        case .studies: "book.fill"
        case .todo: "checklist"
        }
    }

    var tint: Color {
        switch self {
        case .gym: .orange
        case .diet: .green
        case .studies: .blue
        case .todo: .purple
        }
    }

    var label: Label<Text, Image> {
        Label(title, systemImage: systemImage)
    }
}
