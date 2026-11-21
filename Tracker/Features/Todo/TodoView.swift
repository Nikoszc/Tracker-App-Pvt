import SwiftUI
import SwiftData

struct TodoView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \TodoItem.createdAt, order: .reverse) private var items: [TodoItem]
    @State private var newTitle = ""
    @FocusState private var isInputFocused: Bool

    private var openItems: [TodoItem] { items.filter { !$0.isDone } }
    private var doneItems: [TodoItem] { items.filter { $0.isDone } }

    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        TextField("Add a task", text: $newTitle)
                            .focused($isInputFocused)
                            .submitLabel(.done)
                            .onSubmit(addItem)
                        Button(action: addItem) {
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                        }
                        .buttonStyle(.borderless)
                        .disabled(newTitle.trimmed.isEmpty)
                    }
                }

                if items.isEmpty {
                    Section {
                        Text("Nothing on your list. Add a task above.")
                            .foregroundStyle(.secondary)
                    }
                }

                if !openItems.isEmpty {
                    Section("To Do · \(openItems.count)") {
                        ForEach(openItems) { TodoRow(item: $0) }
                            .onDelete { delete($0, from: openItems) }
                    }
                }

                if !doneItems.isEmpty {
                    Section("Done · \(doneItems.count)") {
                        ForEach(doneItems) { TodoRow(item: $0) }
                            .onDelete { delete($0, from: doneItems) }
                    }
                }
            }
            .navigationTitle(TrackerSection.todo.title)
        }
    }

    private func addItem() {
        let title = newTitle.trimmed
        guard !title.isEmpty else { return }
        withAnimation {
            context.insert(TodoItem(title: title))
        }
        newTitle = ""
        isInputFocused = true
    }

    private func delete(_ offsets: IndexSet, from list: [TodoItem]) {
        offsets.forEach { context.delete(list[$0]) }
    }
}

private struct TodoRow: View {
    let item: TodoItem

    var body: some View {
        Button {
            withAnimation { item.toggle() }
        } label: {
            HStack(spacing: 12) {
                Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                    .imageScale(.large)
                    .foregroundStyle(item.isDone ? TrackerSection.todo.tint : Color.secondary)
                Text(item.title)
                    .strikethrough(item.isDone)
                    .foregroundStyle(item.isDone ? Color.secondary : Color.primary)
                Spacer()
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    TodoView()
        .modelContainer(PreviewData.container)
}
