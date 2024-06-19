//
//  ChecklistTests.swift
//  ChecklistTests
//
//  Created by JUN SEOK LEE on 17/6/2024.
//

import XCTest
@testable import Checklist

/// Unit tests
final class ChecklistTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /// Test model Todo by creting Todo instance via constructor and comparing with original values
    func testTodoModel() throws {
        let task = "task exmaple"
        let time = Day.mon
        let isDone = false
        let todo = Todo(task: task, time: time, isDone: isDone)
        XCTAssertEqual(todo.task, task)
        XCTAssertEqual(todo.time, time)
        XCTAssertEqual(todo.isDone, isDone)
    }
    
    /// Test enumeration Day by assigning case from the enumeration and comparing values
    func testEnumDay() throws {
        let day1: Day = .mon
        let result = day1
        XCTAssertEqual(result, .mon)
    }
    
    /// Test model Checklist by creating Checklist model via constuctor and comparing with original values
    func testChecklist() throws {
        let title = "Test title"
        let todo1 = Todo(task: "Read Swift book", time: .mon, isDone: true)
        let todo2 = Todo(task: "Some task", time: .tue, isDone: false)
        let todos = [todo1, todo2]
        let checklist = Checklist(title: title, todos: todos)
        XCTAssertEqual(checklist.title, title)
        XCTAssertEqual(checklist.todos[0], todo1)
        XCTAssertEqual(checklist.todos[1], todo2)
        XCTAssertEqual(checklist.todos.count, 2)
    }
    
    /// Test data model by inserting sample data and compare between data model and sample data
    func testDataModel() throws {
        var model:DataModel = DataModel.getDataModel()
        model.checklists = testChecklists
        XCTAssertEqual(model.checklists[0].title, testChecklists[0].title)
        XCTAssertEqual(model.checklists[0].todos[0].task, testChecklists[0].todos[0].task)
        XCTAssertEqual(model.checklists.count, testChecklists.count)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
