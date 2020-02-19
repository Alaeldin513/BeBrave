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
import FirebaseAuth


class SignUpViewcontroller: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    var ref: DatabaseReference!

    override func viewDidLoad() {
        ref = Database.database().reference()
    }
    
    @IBAction func signUp(_ sender: Any) {
        if validateTextFields() {
            FirebaseAccountManager.signUpUserWith(email: emailTextField.text!, password: passwordTextField.text!){ [weak self] (result) in
                switch result {
                case .success(let firebaseUser):
                    AccountManager.shared.currentUser?.firebaseAccount = firebaseUser
                    self?.performSegue(withIdentifier:"UserInformationSegue" , sender: self)
                case .failure(let error):
                    self?.showErrorHud(FirebaseAccountManager.getStringDescriptionFor(error: error as NSError))
                }
            }
        }
    }
    
    @IBAction func returnToSignIn(_ sender: UIButton) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "loginViewController") as! LoginViewController
        self.present(viewController, animated: true, completion: nil)
    }
    
    func validateTextFields() -> Bool {
        guard let email = self.emailTextField.text ,
            let password = self.passwordTextField.text,
            let confirmPassword = self.confirmPasswordTextField.text,
            let firstName = self.firstNameTextField.text,
            let lastName = self.lastNameTextField.text else {
                self.showErrorHud(String.fillInRequiredFieldsErrorMessage)
                return false
        }
        
        guard let phoneNumber = self.phoneNumberTextField.text,
            phoneNumber.count == 10 else {
                self.showErrorHud(String.enterValidPhoneNumberErrorMessage)
                return false
        }
        
        guard password.count > 10,
            password == confirmPassword else {
                self.showErrorHud(String.passwordDontMatchErrorMessage)
                return false
        }
        AccountManager.shared.currentUser = BeBraveUser(firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber)
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UserInformationSegue" {
            let userInformationVC = segue.destination as! UserInformationFormViewController
        }
    }
    
}

extension SignUpViewcontroller: UITextFieldDelegate {
   
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("editing")
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}





