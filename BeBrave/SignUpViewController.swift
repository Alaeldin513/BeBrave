//
//  SignUpViewController.swift
//  Assault Prevention
//
//  Created by Alaeldin Tirba on 7/4/17.
//  Copyright © 2017 Alaeldin Tirba. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

class SignUpViewcontroller: UIViewController, UITextFieldDelegate {
    
    struct User {
        var user = Auth.auth().currentUser
        var email: String
        var password: String
        var name: String
        var phoneNumber: String
        
        init (name: String, password: String, email: String, phoneNumber: String){
            self.name = name
            self.email = email
            self.password = password
            self.phoneNumber = phoneNumber
        }
    }
    
    var email: String?
    var password: String?
    var confirmPassword: String?
    var name: String?
    var phoneNumber: String?
    
    @IBOutlet weak var errorMessage: UILabel!
    @IBAction func returnToSignIn(_ sender: UIButton) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "loginViewController") as! LoginViewController
        
        self.present(viewController, animated: true, completion: nil)
    }

    @IBOutlet weak var submitButton: UIButton!

    override func viewDidLoad() {
        submitButton.layer.borderWidth = 5
        submitButton.layer.cornerRadius = 15
    }
    
    
    // MARK: - TextField Delegate
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {

        switch textField.tag{
        case 0:
            self.name = textField.text
        case 1:
            self.phoneNumber = textField.text
        case 2:
            self.email = textField.text
        case 3:
            self.password = textField.text
        default:
            self.confirmPassword = textField.text
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Mark: - Firebase Sign Up
    @IBAction func signUpContinue(_ sender: Any) {
        
        guard let email = self.email, let password = self.password, let phoneNumber = self.phoneNumber, let name = self.name else{
            errorMessage.text = "Please fill all the fields"
            return
        }
        
        guard confirmPassword == password else {
            errorMessage.text = "Passwords don't match please try again"
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            if error == nil {
                let newUser = User(name: name, password: password, email: email, phoneNumber: phoneNumber )
                print(newUser.email, newUser.name, newUser.phoneNumber)
                
                Auth.auth().currentUser?.sendEmailVerification { (error) in
                    // ...
                }
                self.performSegue(withIdentifier: "appMainPage", sender: self)
            } else {
                let error = error as NSError?
                let errorCode = AuthErrorCode(rawValue: error!.code)
                self.errorMessage.text = errorCode!.errorMessage
                    
            }
            
        }
       
    }
    
}





