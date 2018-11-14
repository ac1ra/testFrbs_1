//
//  ViewController.swift
//  testFrbs_1
//
//  Created by 0I00II on 12/11/2018.
//  Copyright © 2018 0I00II. All rights reserved.
//

import UIKit
import Firebase

class MainViewController: UIViewController {

    static let kUserLoggedInSegueIdentifier = "userLoggedIn"
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    weak var currentUser: User?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Auth.auth().addStateDidChangeListener({(auth,user) in
            if user != nil && user != self.currentUser{
                self.currentUser = user
                self.performSegue(withIdentifier: MainViewController.kUserLoggedInSegueIdentifier, sender: self)
            }
        })
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        Auth.auth().removeStateDidChangeListener(self)
    }
    
    @IBAction func login(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!)
    }
    
    let alert = UIAlertController(title: "Error", message: "Wrong input", preferredStyle: .alert)
    
    @IBAction func register(_ sender: UIButton) {
        Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!){
            user, error in
            if error != nil {
                
                self.present(self.alert, animated: true, completion: nil)
            }
        }
    }
    @IBAction func signOut(segue: UIStoryboardSegue){
        do{
            try Auth.auth().signOut()
        }catch{
            self.present(self.alert, animated: true, completion: nil)
        }
    }
}

