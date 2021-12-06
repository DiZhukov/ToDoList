//
//  TypeTaskController.swift
//  LoDoList2
//
//  Created by Dima Zhukov on 6.12.21.
//

import UIKit

class TypeTaskController: UITableViewController {
    
    // обработчик выбора типа
    var doAfterTypeSelected: ((PriorityTask) -> Void)?
    
    // кортеж, описывающий тип задачи
    typealias TypeCellDescription = (type: PriorityTask, title: String, description: String)
    
    // коллекция доступных типов задач с их описанием
    private var taskTypesInformation: [TypeCellDescription] = [
        (type: .veryImportant, title: "Важная", description: "Задач наиболее приоритетная для выполнения."),
        (type: .normal, title: "Текущая", description: "Задача с обычным приоритетом")]
    
    // выбранный приоритет
    var selectedType: PriorityTask = .normal
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // получение значение типа UINib, соответствующее xib-файлу кастомной ячейки
        let cellTypeNib = UINib(nibName: "TypeTaskCell", bundle: nil)
        
        // регистрация кастомной ячейки в табличном представлении
        tableView.register(cellTypeNib, forCellReuseIdentifier: "TypeTaskCell")
        }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  taskTypesInformation.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        // получение переиспользуемой кастомной ячейки по ее идентификатору
        let cell = tableView.dequeueReusableCell(withIdentifier: "TypeTaskCell", for: indexPath) as! TypeTaskCell
        
        // получаем текущий элемент, информация о котором должна быть выведена в строке
        let typeDescription = taskTypesInformation[indexPath.row]
        
        // заполняем ячейку данными
        cell.typeTitle.text = typeDescription.title
        cell.typeDescription.text = typeDescription.description
        
        // если тип является выбранным, то отмечаем галочкой
        if selectedType == typeDescription.type {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // получаем выбранный тип
        let selectedType = taskTypesInformation[indexPath.row].type
        
        // вызов обработчика
        doAfterTypeSelected?(selectedType)
        
        // переход к предыдущему экрану
        navigationController?.popViewController(animated: true)

    }
}
