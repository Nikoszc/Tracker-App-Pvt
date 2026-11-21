import SwiftUI

/// The tabs shown at the bottom of the app.
enum AppTab: Hashable {
    case today
    case section(TrackerSection)
}

struct RootView: View {
    @State private var selection: AppTab = .today

    var body: some View {
        TabView(selection: $selection) {
            TodayView(selection: $selection)
                .tabItem { Label("Today", systemImage: "sun.max.fill") }
                .tag(AppTab.today)

            GymView()
                .tabItem { TrackerSection.gym.label }
                .tag(AppTab.section(.gym))

            DietView()
                .tabItem { TrackerSection.diet.label }
                .tag(AppTab.section(.diet))

            StudiesView()
                .tabItem { TrackerSection.studies.label }
                .tag(AppTab.section(.studies))

            TodoView()
                .tabItem { TrackerSection.todo.label }
                .tag(AppTab.section(.todo))
        }
    }
}

#Preview {
    RootView()
        .modelContainer(PreviewData.container)
}
