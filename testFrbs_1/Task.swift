//
//  Task.swift
//  testFrbs_1
//
//  Created by 0I00II on 12/11/2018.
//  Copyright © 2018 0I00II. All rights reserved.
//

import Foundation
import Firebase

struct Task {
    static let kTaskTitleKey = "title"
    static let kTaskCompletedKey = "complete"
    static let kTaskUserKey = "user"

    let title: String
    let user: String
    var completed: Bool
    
    let firebaseReference: DatabaseReference?
    
    init(title:String, user: String,completed: Bool, id: String = "") {
        self.title = title
        self.user = user
        self.completed = completed
        self.firebaseReference = nil
    }
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: Any]
        self.title = snapshotValue[Task.kTaskTitleKey] as! String
        self.user = snapshotValue[Task.kTaskUserKey] as! String
        self.completed = snapshotValue[Task.kTaskCompletedKey] as! Bool
        self.firebaseReference = snapshot.ref
        
    }
    func toDictionary() -> Any {
        return[
            Task.kTaskTitleKey: self.title,
            Task.kTaskUserKey: self.user,
            Task.kTaskCompletedKey: self.completed
        ]
    }
    
    
}
