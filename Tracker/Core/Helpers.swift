import Foundation

/// Anything logged against a date, so lists can be grouped by day.
protocol Dated {
    var date: Date { get }
}

struct DayGroup<Item>: Identifiable {
    let day: Date
    let items: [Item]
    var id: Date { day }
}

extension Array where Element: Dated {
    /// Groups entries by calendar day, newest day first.
    func groupedByDay(calendar: Calendar = .current) -> [DayGroup<Element>] {
        let grouped = Dictionary(grouping: self) { entry in
            calendar.startOfDay(for: entry.date)
        }
        return grouped
            .map { day, items in
                DayGroup(day: day, items: items.sorted { lhs, rhs in lhs.date > rhs.date })
            }
            .sorted { lhs, rhs in lhs.day > rhs.day }
    }
}

extension Date {
    var isToday: Bool { Calendar.current.isDateInToday(self) }

    /// "Today", "Yesterday", or e.g. "Monday, 18 Nov".
    var dayTitle: String {
        let calendar = Calendar.current
        if calendar.isDateInToday(self) { return "Today" }
        if calendar.isDateInYesterday(self) { return "Yesterday" }
        return formatted(.dateTime.weekday(.wide).day().month(.abbreviated))
    }
}

extension Int {
    /// 95 -> "1h 35m", 40 -> "40m".
    var minutesFormatted: String {
        let hours = self / 60
        let minutes = self % 60
        if hours == 0 { return "\(minutes)m" }
        return minutes == 0 ? "\(hours)h" : "\(hours)h \(minutes)m"
    }
}

extension String {
    var trimmed: String { trimmingCharacters(in: .whitespacesAndNewlines) }
}
