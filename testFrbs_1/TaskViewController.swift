//
//  TaskViewController.swift
//  testFrbs_1
//
//  Created by ac1ra on 12/11/2018.
//  Copyright © 2018 0I00II. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController {

    var taskTitle: String?
    var taskCompleted: Bool?
    
    @IBOutlet var titleField: UITextField!
    @IBOutlet var completedSwitch: UISwitch!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.titleField.text = self.taskTitle ?? ""
        self.completedSwitch.setOn(taskCompleted ?? false, animated: false)
    }
    func updateValues(){
        self.taskTitle = self.titleField.text
        self.taskCompleted = self.completedSwitch.isOn
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
