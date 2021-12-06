//
//  EditTaskController.swift
//  LoDoList2
//
//  Created by Dima Zhukov on 6.12.21.
//

import UIKit

class EditTaskController: UITableViewController {

    @IBOutlet var taskTitle: UITextField!
    @IBOutlet var taskTypeLabel: UILabel!
    @IBOutlet var taskStatusSwitch: UISwitch!
    
   
    // параметры задачи
    var textTask: String = ""
    var typeTask: PriorityTask = .normal
    var taskStatus: StatusTask = .planned
    var doAfterEdit: ((String, PriorityTask, StatusTask) -> Void)?
    
    
    @IBAction func saveTask(_ sender: UIBarButtonItem) {
        // получаем актуальные значения
        let title = taskTitle?.text ?? ""
        let type = typeTask
        let status: StatusTask = taskStatusSwitch.isOn ? .completed : .planned
        // вызываем обработчик
        doAfterEdit?(title, type, status)
        
        // возвращаемся к предыдущему экран
        navigationController?.popViewController(animated: true)
    }
    
    
    private var taskTitles: [PriorityTask: String] = [.veryImportant: "Важная", .normal: "Текущая" ]

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // обновление текстового поля с названием задачи
        taskTitle?.text = textTask
        
        // обновление метки в соответствии текущим типом
        taskTypeLabel?.text = taskTitles[typeTask]
        
        // обновляем статус задачи
        if taskStatus == .completed {
            taskStatusSwitch.isOn = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTaskTypeScreen" {
        // ссылка на контроллер назначения
        let destination = segue.destination as! TypeTaskController
            
        // передача выбранного типа
        destination.selectedType = typeTask
            
        // передача обработчика выбора типа
        destination.doAfterTypeSelected = { [unowned self] selectedType in typeTask = selectedType
            
            // обновляем метку с текущим типом
            taskTypeLabel?.text = taskTitles[self.typeTask]
        }
    }
}
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

}

