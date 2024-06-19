//
//  ChecklistApp.swift
//  Checklist
//
//  Created by JUN SEOK LEE on 17/6/2024.
//

import SwiftUI

@main
/// Base view of the app
struct ChecklistApp: App {
    /// Inisialise a data model with a sample data
    @StateObject var data:DataModel = DataModel.getDataModel()
    init() {
        /// Change color of navigation bar title
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.systemRed]
        }
    var body: some Scene {
        WindowGroup {
            if (data.loadingCompleted) {
                ContentView(model: data)
            } else {
                LoadingView()
            }
        }
    }
}
