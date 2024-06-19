//
//  ChecklistView.swift
//  Checklist
//
//  Created by JUN SEOK LEE on 17/6/2024.
//

import SwiftUI

/// Detail view listing Todo of a selected Checklist with Edit button
struct ChecklistView: View {
    /// Subscribes to an observable object checklist
    @ObservedObject var checklist: Checklist
    /// Empty task value for new todo item
    @State var newTodoTask = ""
    /// Manage state to check undo can be shown
    @State var canUndo = false
    /// Environment property for edit mode
    @Environment(\.editMode) private var editMode
    
    /// List of Todo items and buttons for uncheck all, and undo with Edit button
    var body: some View {
        VStack {
            TitleEditView(title: $checklist.title)
                .onChange(of: checklist.title) {
                    _ in
                    saveData()
                }
            List {
                Section(){
                    ForEach($checklist.todos, id:\.id) {
                        $todo in
                        ListRowView(todo: $todo)
                            .onChange(of: todo) {
                                _ in
                                saveData()
                            }
                    }
                    .onDelete{
                        index in
                        checklist.todos.remove(atOffsets: index)
                        saveData()
                    }
                    .onMove{
                        index, i in
                        checklist.todos.move(fromOffsets: index, toOffset: i)
                        saveData()
                    }
                    /// Add new Todo by hit enter
                    HStack {
                        Image(systemName: "plus.circle")
                        TextField("New task", text: $newTodoTask)
                            .onSubmit {
                                let newTodo = Todo(task: newTodoTask, time: .none, isDone: false)
                                // Add new Todo
                                checklist.todos.append(newTodo)
                                saveData()
                                // Reset the textfield value
                                newTodoTask = ""
                            }
                    }
                }
                // Items to show in Edit mode
                if editMode?.wrappedValue.isEditing == true {
                    Button(action: {
                        // Change all isDone to false
                        checklist.resetStatuses()
                        saveData()
                        // Change state to show Undo
                        canUndo = true
                    }) {
                        Label("Uncheck All", systemImage: "circle.dotted")
                    }
                    if canUndo {
                        Button(action: {
                            // revert isDone state to previous
                            checklist.undoStatus()
                            saveData()
                            // Change state to hide Undo
                            canUndo = false
                        }) {
                            Label("Undo Checks", systemImage: "arrow.uturn.backward.circle")
                        }
                    }
                }
            }
        }
        .navigationBarItems(trailing: EditButton())
        .navigationTitle(checklist.title)
            .font(.custom("Futura", size: 17)) // 폰트 설정
    }
}
