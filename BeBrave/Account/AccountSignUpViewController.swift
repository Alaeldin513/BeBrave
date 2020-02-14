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
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!

    override func viewDidLoad() {
        ref = Database.database().reference()
    }
    
    @IBAction func signUp(_ sender: Any) {
        if validateTextFields() {
            FirbaseAuth.signUpUser(email: emailTextField.text!, password: passwordTextField.text!) {(result) in
                switch result {
                case .success(let authresult):
                    self.performSegue(withIdentifier:"UserInformationSegue" , sender: self)
                case .failure(let error):
                    self.showErrorMessage(error: error)
                }
            }
        }
        return
    }
    func validateTextFields() -> Bool {
        guard self.emailTextField.text != nil,
            let password = self.passwordTextField.text,
            let confirmPassword = self.confirmPasswordTextField.text,
            self.firstNameTextField.text != nil,
            self.lastNameTextField.text != nil else {
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
        return true
    }
    func showErrorMessage(error: Error) {
        switch AuthErrorCode(rawValue: (error._code))! {
        case .emailAlreadyInUse:
            self.showErrorHud(String.emailInUseErrorMessage)
        case .invalidEmail:
            self.showErrorHud(String.invalidEmailErrorMessage)
        default:
            self.showErrorHud(String.genericErrorMessage)
        }
    }
    
    @IBAction func returnToSignIn(_ sender: UIButton) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "loginViewController") as! LoginViewController
        
        self.present(viewController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UserInformationSegue" {
            let userInformationVC = segue.destination as! UserInformationFormViewController
            userInformationVC.firstName = self.firstNameTextField.text
            userInformationVC.lastName = self.lastNameTextField.text
            userInformationVC.phoneNumber = self.phoneNumberTextField.text
        }
    }
    
}

extension SignUpViewcontroller: UITextFieldDelegate {
   
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("editing")
        return true
    }
    
//    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//        switch textField.tag {
//        case 0:
//            self.firstName = textField.text
//        case 1:
//            self.lastName = textField.text
//        case 2:
//            self.phoneNumber = textField.text
//        case 3:
//            self.email = textField.text
//        case 4:
//            self.password = textField.text
//        default:
//            self.confirmPassword = textField.text
//        }
//        return true
//    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}





