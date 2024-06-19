//
//  TodoModel.swift
//  Checklist
//
//  Created by JUN SEOK LEE on 17/6/2024.
//
import Foundation

///  Defines Todo task
struct Todo: Hashable, Codable {
    /// ID generated via UUID()
    var id = UUID()
    /// Task name
    var task: String
    /// Time tag for todo task (enum Day)
    var time: Day
    /// Status of todo task
    var isDone: Bool
    /// Previous status of todo task
    var previouIsDone: Bool?
}

/// Selection of day for the time tag in Todo
enum Day: String, CaseIterable, Identifiable, Codable {
    case none, mon, tue, wed, thu, fri, sat, sun
    var id: Self { self }
    
    
    
}
