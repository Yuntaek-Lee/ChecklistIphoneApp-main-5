//
//  DataModel.swift
//  Checklist
//
//  Created by JUN SEOK LEE on 17/6/2024.
//
import Foundation

/// Model to store user's checklists.
class DataModel: Codable, ObservableObject {
    /// Array of Checklist
    @Published var checklists: [Checklist]
    /// Status of loading completion
    @Published var loadingCompleted = false
    /// static model of DataModel
    static var model: DataModel?
    /// Coding keys for encoding and decoding
    enum CodingKeys: CodingKey {
        case checklists
    }
    /// Initialisation to assign empty array and load data.
    private init() {
        checklists = []
        load()
    }
    
    /// Create DataModel model within the class to restrict creation outside.
    ///
    /// - returns: DataModel model object
    static func getDataModel()->DataModel {
        guard let model = DataModel.model else {
            let model = DataModel()
            DataModel.model = model
            return model
        }
        return model
    }
    
    /// Encode DataModel properties in container paired with a key.
    ///
    /// - parameter encoder: destination encoder
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(checklists, forKey: .checklists)
    }
    
    /// Initialisation required to decode paired with a key.
    ///
    /// - parameter decoder: origin of decoder
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        checklists = try container.decode([Checklist].self, forKey: .checklists)
    }
    
    /// Find location of document directory and return URL.
    ///
    /// - returns: URL of document file
    func getFile()->URL {
        let filename = "checklist.json"
        let fm = FileManager.default
        let url = fm.urls(for: .documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first!
        return url.appendingPathComponent(filename)
    }
    
    /// Encode data and save it to JSON file.
    func save() {
        do{
            let url = getFile()
            let data = try JSONEncoder().encode(self)
            try data.write(to: url)
        } catch {
            print("Saving failed: \(error)")
        }
    }
    
    /// Asunc function to load data by decoding JSON file from document directory.
    ///
    ///  - returns: Optional decoded DataModel or nil if fails
    private func asyLoad() async ->DataModel? {
        do{
            let url = getFile()
            let datastr = try Data(contentsOf: url)
            let data = try JSONDecoder().decode(DataModel.self, from: datastr)
            return data
        }
        catch {
            print("Loading failed: \(error)")
        }
        return nil
    }
    
    /// Load saved data and assign it to model and change loading status to complete. If there is no saved data then change status of loading to complete.
    func load() {
        Task {
            guard let data = await asyLoad() else {
                /// When there is no saved data just change the loading status in the main thread.
                DispatchQueue.main.async {
                    self.loadingCompleted = true
                }
                return
            }
            /// For debugging purpose, delay the task processing to make loading visible.
            try? await Task.sleep(nanoseconds: 1000_000_000)
            DispatchQueue.main.async {
                self.checklists = data.checklists
                self.loadingCompleted = true
            }
        }
    }
}

/// Save model data from any view in the app.
func saveData() {
    let model = DataModel.getDataModel()
    model.save()
}

/// Sample array of Checklist containing an array of Todo for testing purpose.
var testChecklists = [
    Checklist(title: "MAD tasks", todos: [
        Todo(task: "Read Swift book", time: .mon, isDone: true),
        Todo(task: "Review lecture slides", time: .tue, isDone: true),
        Todo(task: "Do workshop tasks", time: .wed, isDone: true),
        Todo(task: "Attend workshop", time: .thu, isDone: false),
        Todo(task: "Read additional readings", time: .fri, isDone: false)
    ])
]
