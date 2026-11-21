# Tracker

An iOS app for tracking daily progress across four areas: **Gym**, **Diet**, **Studies** and **To-Do**.

Built with SwiftUI + SwiftData. Requires **Xcode 16+** and targets **iOS 17+**.

## Running it

1. Open `Tracker.xcodeproj` in Xcode.
2. Select the **Tracker** target → *Signing & Capabilities* → pick your Team, and change the
   bundle identifier (`com.example.Tracker`) to something unique, e.g. `com.yourname.Tracker`.
3. Pick an iPhone simulator (or your device) and press **⌘R**.

## What's in the skeleton

| Tab      | What it does now |
|----------|------------------|
| Today    | Dashboard of today's totals per section and how many areas you've tracked; tap a card to jump to that tab |
| Gym      | Log workouts (name, duration, date, notes); grouped by day with daily minutes |
| Diet     | Log meals (type, calories, protein); grouped by day with daily kcal |
| Studies  | Log study sessions (subject, duration, notes); grouped by day with daily time |
| To-Do    | Quick-add tasks, tick off, swipe to delete; split into To Do / Done |

All data is stored on-device with SwiftData. Swipe left on any row to delete it.

## Project layout

```
Tracker/
├── App/            App entry point and tab bar (RootView)
├── Core/           Shared config: TrackerSection (name/icon/color), AppSchema, helpers
├── Models/         SwiftData models: Workout, Meal, StudySession, TodoItem
├── Features/
│   ├── Today/      Dashboard + SummaryCard
│   ├── Gym/        List + add sheet
│   ├── Diet/       List + add sheet
│   ├── Studies/    List + add sheet
│   └── Todo/       Checklist
├── Preview/        Sample data for SwiftUI previews
└── Assets.xcassets
```

The project uses Xcode's folder-synced groups, so any new `.swift` file you drop into `Tracker/`
is compiled automatically — no need to add it to the project manually.

## Adding a new section

1. Add a case to `TrackerSection` (title, icon, color).
2. Create its model in `Models/` and register it in `AppSchema.models`.
3. Add a view under `Features/` and a tab in `RootView`.
4. Add a `SummaryCard` for it in `TodayView`.

## Ideas for add-ons

- Goals per section (calorie target, weekly gym minutes, study hours) with progress rings
- Streaks and a weekly/monthly history view with Swift Charts
- Exercise library with sets / reps / weight per workout
- Study timer (Pomodoro) and subjects with colors
- To-do due dates, priorities and reminders (notifications)
- Home-screen widgets, HealthKit sync, iCloud sync
