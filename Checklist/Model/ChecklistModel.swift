//
//  ChecklistModel.swift
//  Checklist
//
//  Created by JUN SEOK LEE on 17/6/2024.
//
import Foundation

/// Defines checklist model
class Checklist: Codable, ObservableObject {
    /// ID generated via UUID()
    var id = UUID()
    /// Checklist title name
    @Published var title: String
    /// Array to store todos
    @Published var todos: [Todo]
    
    /// Keys for encoding and decoding
    enum CodingKeys: CodingKey {
        case title
        case todos
    }
    
    /// Encode properties in container paired with keys
    ///
    /// - parameter type: The key type to use for the container.
    /// - returns: A new keyed encoding container.
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(todos, forKey: .todos)
    }
    required init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        todos = try container.decode([Todo].self, forKey: .todos)
        
    }
    init(title: String, todos: [Todo]) {
        self.title = title
        self.todos = todos
    }
    
    /// Function to change all isDone statues to false
    func resetStatuses() {
        for i in todos.indices {
            todos[i].previouIsDone = todos[i].isDone
            todos[i].isDone = false
        }
    }
    /// Function to revert  all isDone statues to previous ones
    func undoStatus() {
        for i in todos.indices {
            // Check if previouIsDone exists
            if let previous = todos[i].previouIsDone {
                todos[i].isDone = previous
            }
        }
    }
}

