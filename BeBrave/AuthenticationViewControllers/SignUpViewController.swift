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
import FirebaseDatabase


class SignUpViewcontroller: UIViewController, UITextFieldDelegate {
    
    var ref: DatabaseReference!
    
    var email: String?
    var password: String?
    var confirmPassword: String?
    var name: String?
    var phoneNumber: String?
    
   
   

    @IBOutlet weak var submitButton: UIButton!

    override func viewDidLoad() {
        ref = Database.database().reference()
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
        
        guard let email = self.email, let password = self.password, let name = self.name else {
            //errorMessage.text = "Please fill all the fields"
            return
        }
        
        guard let phoneNumber = self.phoneNumber, self.phoneNumber?.count == 10 else {
            //errorMessage.text = "Please enter a valid phone number"
            return
        }
        
        guard confirmPassword == password else {
           // errorMessage.text = "Passwords don't match please try again"
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            if error == nil {
                let newUser = User(firstName: name, lastName: name, email: email, phoneNumber: phoneNumber )
//                self.ref.child("users").child((user?.uid)!).setValue(["Name": newUser.name,
//                                                                      "phone": newUser.phoneNumber,
//                                                                      "Email": newUser.email])
                Auth.auth().currentUser?.sendEmailVerification { (error) in}
                self.performSegue(withIdentifier: "appMainPage", sender: self)
            } else {
                let error = error as NSError?
                let errorCode = AuthErrorCode(rawValue: error!.code)
                //self.errorMessage.text = errorCode!.errorMessage
                    
            }
            
        }
       
    }
    
    @IBAction func returnToSignIn(_ sender: UIButton) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "loginViewController") as! LoginViewController
        
        self.present(viewController, animated: true, completion: nil)
    }
    
}





