//
//  TasksTableViewController.swift
//  testFrbs_1
//
//  Created by 0I00II on 12/11/2018.
//  Copyright © 2018 0I00II. All rights reserved.
//

import UIKit
import Firebase

class TasksTableViewController: UITableViewController {

    static let kTasksListPath = "tasks-path"
    static let kTaskViewControllerSegueIdentifier = "TaskViewController"
    
    let tasksReference = Database.database().reference(withPath: kTasksListPath)
    var tasks = [Task]()
    var selectedTask: Task? = nil
    weak var currentUser = Auth.auth().currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tasksReference.queryOrdered(byChild: Task.kTaskCompletedKey).observe(.value, with:{
            snapshot in
            var items: [Task] = []
            
            for item in snapshot.children{
                let task = Task(snapshot: item as! DataSnapshot)
                items.append(task)
            }
            self.tasks = items
            self.tableView.reloadData()
        })
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == TasksTableViewController.kTaskViewControllerSegueIdentifier{
            if let taskViewController = segue.destination as? TaskViewController{
                taskViewController.taskTitle = self.selectedTask?.title
                taskViewController.taskCompleted = self.selectedTask?.completed
            }
        }
    }

    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){
        if let taskViewController = segue.source as? TaskViewController{
            taskViewController.updateValues()
            
            if let task = self.selectedTask{
                
                if let title = taskViewController.taskTitle,
                    let completed = taskViewController.taskCompleted,
                    let email = self.currentUser?.email{
                    
                    let taskFirebasePath = task.firebaseReference
                    taskFirebasePath?.updateChildValues([
                        Task.kTaskTitleKey: title,
                        Task.kTaskUserKey: email,
                        Task.kTaskCompletedKey: completed
                        ])
                }
            } else{
                if let title = taskViewController.taskTitle,
                    let completed = taskViewController.taskCompleted,
                    let email = self.currentUser?.email{
                    let task = Task(title: title, user: email, completed: completed)
                    let taskFirebasePath = self.tasksReference.ref.child(title.lowercased())
                    taskFirebasePath.setValue(task.toDictionary())
                }
            }
        }
        self.selectedTask = nil
    }
    @IBAction func addTask(){
        self.performSegue(withIdentifier: TasksTableViewController.kTaskViewControllerSegueIdentifier, sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.tasks.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TasksTableViewCell", for: indexPath)
        if let c = cell as? TasksTableViewCell{
            let task = self.tasks[indexPath.row]
            c.titleLabel.text = task.title
            c.completedSwitch.setOn(task.completed, animated: true)
        }
        // Configure the cell...
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = self.tasks[indexPath.row]
        
        self.selectedTask = task
        self.performSegue(withIdentifier: TasksTableViewController.kTaskViewControllerSegueIdentifier, sender: self)
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let task = self.tasks[indexPath.row]
            task.firebaseReference?.removeValue()
            
//            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
