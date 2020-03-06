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
import ATGValidator
import NotificationCenter

class SignUpViewcontroller: UIViewController {
    
    @IBOutlet weak var firstNameTextField: NameTextField!
    @IBOutlet weak var lastNameTextField: NameTextField!
    @IBOutlet weak var phoneNumberTextField: PhoneNumberTextField!
    @IBOutlet weak var emailTextField: EmailTextField!
    @IBOutlet weak var passwordTextField: PasswordTextField!
    @IBOutlet weak var confirmPasswordTextField: PasswordTextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    var ref: DatabaseReference!
    var formValidation: FormValidation?
    
    override func viewDidLoad() {
        ref = Database.database().reference()
        firstNameTextField.delegate = self
        confirmPasswordTextField.validationRules? = [StringValueMatchRule(base: passwordTextField)]
        self.formValidation = FormValidation(itemsToValidate: [firstNameTextField,
                                                               lastNameTextField,
                                                               emailTextField,
                                                               phoneNumberTextField,
                                                               passwordTextField,
                                                               confirmPasswordTextField])
        self.errorLabel.isHidden = true
    }
    
    @IBAction func signUp(_ sender: Any) {
        if validateTextFields() {
            FirebaseAccountManager.signUpUserWith(email: emailTextField.text!, password: passwordTextField.text!){ [weak self] (result) in
                switch result {
                case .success(let firebaseUser):
                    AccountManager.shared.currentUser?.firebaseAccount = firebaseUser
                    self?.performSegue(withIdentifier:"UserInformationSegue" , sender: self)
                case .failure(let error):
                    self?.errorLabel.text = FirebaseAccountManager.getStringDescriptionFor(error: ((error as! NSError)))
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
        
        guard password == confirmPassword else {
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
        textField.validValue = nil
        //textField.layer.sublayers?[1].borderColor = UIColor.white.cgColor
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        formValidation?.formValidator.validateForm {[weak self] (result) in
            guard textField.validValue == nil else {
                if result.errors != nil {
                    textField.layer.sublayers?[0].borderColor = UIColor.white.cgColor
                    self?.errorLabel.isHidden = true
                    return
                }
                return
            }
            let textFieldError = textField.getTextfieldErrorFrom(formValidatorErrors: (result.errors as? [ValidationError] ?? []))
            if let textFieldError = textFieldError {
                self?.errorLabel.text = textFieldError.errorMessage(textFieldType: textField)
                self?.errorLabel.textColor = .yellow
                self?.errorLabel.isHidden = false
                DispatchQueue.main.async {
                    textField.layer.sublayers?.filter{$0.name == "line"}.first?.borderColor = UIColor.yellow.cgColor
                }
            }
        }
    }
    
    
    func getNameOf(textField: UITextField) -> String {
        
        switch textField.tag {
        case 0:
            return "First name"
        case 1:
            return "Last name"
        case 2:
            return  "Phone number"
        case 3:
            return "Email"
        case 4:
            return  "Password"
        case 5:
            return  "Confirm password"
        default:
            return ""
        }
    }
    
}

class FormValidation {
    var formValidator = FormValidator()
    
    init( itemsToValidate: [ValidatableInterface]) {
        self.addItemsToForm(itemsToValidate: itemsToValidate as! [UITextField])
    }
    
    private func addItemsToForm(itemsToValidate: [UITextField]){
        for item in itemsToValidate {
            formValidator.add(item)
        }
    }
    
}

    

