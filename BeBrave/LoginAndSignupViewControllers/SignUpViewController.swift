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


class SignUpViewcontroller: UIViewController {
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var confirmPasswordLabel: UILabel!
    
    var email: String?
    var password: String?
    var confirmPassword: String?
    var name: String?
    var phoneNumber: String?
    

    @IBOutlet weak var submitButton: UIButton!

    override func viewDidLoad() {
        ref = Database.database().reference()
    }
    
    @IBAction func signUpContinue(_ sender: Any) {
        
        guard let email = self.email, let password = self.password, let name = self.name else {
            self.showHud("Please fill all the fields")
            return
        }
        
        guard let phoneNumber = self.phoneNumber, self.phoneNumber?.count == 10 else {
            self.showHud("Please enter a valid phone number")
            return
        }
        
        guard confirmPassword == password else {
            self.showHud("Passwords don't match please try again")
            return
        }
        
        FirbaseAuth.signUpUser(email: email, password: password) {(result) in
            switch result {
            case .success(let authresult):
                self.performSegue(withIdentifier:"appMainPage" , sender: self)
            case .failure(let error):
                self.showErrorMessage(error: error)
            }
        }
        
       
    }
    func showErrorMessage(error: Error) {
        switch AuthErrorCode(rawValue: (error._code))! {
        case .emailAlreadyInUse:
            self.showHud("This email is already in use, please try again.")
            self.emailLabel.textColor = .red
        case .invalidEmail:
            self.showHud("This email is invalid, please try again")
        default:
            self.showHud("An error has occured, please try again later.")
        }
    }
    
    @IBAction func returnToSignIn(_ sender: UIButton) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "loginViewController") as! LoginViewController
        
        self.present(viewController, animated: true, completion: nil)
    }
    

    
}

extension SignUpViewcontroller: UITextFieldDelegate {
   
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("editing")
        return true
    }
    
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
}





