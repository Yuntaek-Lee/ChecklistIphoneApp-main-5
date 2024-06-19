//
//  ContentView.swift
//  Checklist
//
//  Created by JUN SEOK LEE on 17/6/2024.
//

import SwiftUI

/// Main view of the app listing checklists with Add and Edit buttons
struct ContentView: View {
    /// Subscribes to an observable object data model
    @ObservedObject var model: DataModel
    /// Master list with navigation
    var body: some View {
        NavigationView {
            List {
                ForEach(model.checklists, id: \.id) { checklist in
                    NavigationLink(destination: ChecklistView(checklist: checklist)) {
                        MasterListRowView(checklist: checklist)
                    }
                }
                .onDelete { index in
                    // Delete item
                    model.checklists.remove(atOffsets: index)
                    saveData()
                }
                .onMove { index, i in
                    // Move item
                    model.checklists.move(fromOffsets: index, toOffset: i)
                    saveData()
                }
            }
            .navigationBarItems(
                leading: EditButton(),
                trailing: Button(action: {
                    // Add new item
                    let newChecklist = Checklist(title: "New item", todos: [])
                    model.checklists.append(newChecklist)
                    saveData()
                }) {
                    Image(systemName: "plus.circle")
                }
            )
            .navigationTitle("Checklists")
            .font(.custom("Futura", size: 17)) // 폰트 설정
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @StateObject static var data = DataModel.getDataModel()
    static var previews: some View {
        ContentView(model: data)
    }
}
