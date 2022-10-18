//
//  ViewController.swift
//  Timely
//
//  Created by cole stevens on 9/25/22.
//

import UIKit
import RealmSwift

class TasksViewController: UITableViewController {

    let realm = try! Realm()
    
    var itemArray: Results<Task>?
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTasks()
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
        
    }

//MARK: - Tableview Datasource Methods
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = itemArray?[indexPath.row].title ?? "No Goals Added Yet"
        
        return cell
    }

    
//MARK: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToTimer", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TimerViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedTask = itemArray?[indexPath.row]
        }
    }
    
    
//MARK: - Add New Tasks
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Task", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Task", style: .default) { (action) in
            //what happens when add item is pressed
            
            let newTask = Task()
            newTask.title = textField.text!
    
            self.saveTasks(task: newTask)

        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
//MARK: - Model Maniplulation Methods
    
    func saveTasks(task: Task) {
        
        do {
            try realm.write {
                realm.add(task)
            }
        } catch {
            print("Error saving context, \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadTasks() {
        
        itemArray = realm.objects(Task.self)

        tableView.reloadData()
        
    }
    
    func updateModel(at indexPath: IndexPath) {
        if let taskForDeletion = self.itemArray?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(taskForDeletion)
                }
            } catch {
                print("Error deleting category, \(error)")
            }
        }
    }
    
}
