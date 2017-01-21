//
//  RegistrationController.swift
//  BeeKey
//
//  Created by Влад Бирюков on 18.01.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import UIKit
import RealmSwift

class RegistrationController: UIViewController{
    
    @IBOutlet private weak var userName: UITextField!
    @IBOutlet private weak var userSurname: UITextField!
    @IBOutlet private weak var userLogin: UITextField!
    @IBOutlet private weak var userPassword: UITextField!
    @IBOutlet private weak var userConfirmPassword: UITextField!
    
    private var users: Users!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //расположение файла с бд
        //print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction private func registerNewUser(_ sender: UIButton) {
        if validateFields() {
            addNewUser()
        }
    }
    
    private func addNewUser() {
        let realm = try! Realm()
        
        try! realm.write {
            let newUser = Users()
            
            newUser.name = self.userName.text!
            newUser.surname = self.userSurname.text!
            newUser.login = self.userLogin.text!
            newUser.password = self.userPassword.text!
            
            realm.add(newUser)
            self.users = newUser
        }
    }
    
    private func validateFields() -> Bool {
        
        if userName.text!.isEmpty || userSurname.text!.isEmpty ||
            userLogin.text!.isEmpty || userPassword.text!.isEmpty ||
            userConfirmPassword.text!.isEmpty {
            
            let alertController = UIAlertController(title: "Validation Error", message: "All fields must be filled", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.destructive) { alert in
                alertController.dismiss(animated: true, completion: nil)
            }
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
            
            return false
            
        } else {
            return true
        }
    }
}

