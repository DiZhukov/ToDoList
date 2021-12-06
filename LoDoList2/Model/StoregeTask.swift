//
//  StoregeTask.swift
//  LoDoList2
//
//  Created by Dima Zhukov on 5.12.21.
//

import Foundation

// Сущность "xранилище задач"
class TasksStorage: StorageTaskProtocol{
    
    // Ссылка на хранилище
    private var storage = UserDefaults.standard
    
    // Ключ, по которому будет происходить сохранение и загрузка хранилища из User Defaults
    var storageKey: String = "tasks"
    
    // Перечисление с ключами для записи в User Defaults
    private enum TaskKey: String {
        case title
        case type
        case status
    }
    
    func loadTasks() -> [ProtocolTask] {
        var resultTasks: [ProtocolTask] = []
        let tasksFromStorage = storage.array(forKey: storageKey) as? [[String:String]] ?? []
        for task in tasksFromStorage {
            guard let title = task[TaskKey.title.rawValue],
                  let typeRaw = task[TaskKey.type.rawValue],
                  let statusRaw = task[TaskKey.status.rawValue] else {
                continue
                  }
            let type: PriorityTask = typeRaw == "important" ? .veryImportant : .normal
            let status: StatusTask = statusRaw == "planned" ? .planned : .completed
            resultTasks.append(Task(title: title, type: type, status: status))
        }
        return resultTasks
    }
    
    
    func saveTasks(_ tasks: [ProtocolTask]) {
        var arrayForStorage: [[String:String]] = []
        tasks.forEach { task in
            var newElementForStorage: Dictionary<String, String> = [:]
            newElementForStorage[TaskKey.title.rawValue] = task.title
            newElementForStorage[TaskKey.type.rawValue] = (task.type == .veryImportant) ? "important" : "normal"
            newElementForStorage[TaskKey.status.rawValue] = (task.status == .planned) ? "planned" : "completed"
            arrayForStorage.append(newElementForStorage)
        }
            storage.set(arrayForStorage, forKey: storageKey)
    }
}
    func saveTasks(_ tasks: [ProtocolTask]) {}



protocol StorageTaskProtocol {
    func loadTasks() -> [ProtocolTask]
    func saveTasks(_ tasks: [ProtocolTask])
}
