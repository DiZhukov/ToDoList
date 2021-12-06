//
//  Task.swift
//  LoDoList2
//
//  Created by Dima Zhukov on 5.12.21.
//

import Foundation

// тип задачи
enum PriorityTask {
    case normal
    case veryImportant
}

// состояние задачи
enum StatusTask: Int {
    case planned
    case completed
}

// требования к типу, описывающему сущность "задача"
protocol ProtocolTask {
    var title: String { get set }
    var type: PriorityTask { get set }
    var status: StatusTask { get set }
}

struct Task: ProtocolTask {
    var title: String
    var type: PriorityTask
    var status: StatusTask
}
