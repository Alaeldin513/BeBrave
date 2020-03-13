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
    
    var textFieldValidator: FormValidator?
    var textFieldsToValidate:[UITextField]?
    var isFormValid = false
    
    override func viewDidLoad() {
        keyboardPushesViewUpWhenTapped()
        hideKeyboardWhenTappedAround()
        confirmPasswordTextField.validationRules? = [StringValueMatchRule(base: passwordTextField)]
        self.textFieldsToValidate = [firstNameTextField,
                                     lastNameTextField,
                                     emailTextField,
                                     phoneNumberTextField,
                                     passwordTextField,
                                     confirmPasswordTextField]
        self.textFieldValidator = FormValidator(itemsToValidate: textFieldsToValidate ?? [] )
        self.errorLabel.isHidden = true
    }
    
    @IBAction func signUp(_ sender: Any) {
        if self.isFormValid {
            FirebaseAccountManager.signUpUserWith(email: emailTextField.text!, password: passwordTextField.text!){ [weak self] (result) in
                switch result {
                case .success(let firebaseUser):
                    AccountManager.shared.currentUser?.firebaseAccount = firebaseUser
                    self?.performSegue(withIdentifier:"UserInformationSegue" , sender: self)
                case .failure(let error):
                    self?.showErrorHud(FirebaseAccountManager.getStringDescriptionFor(error: error as NSError))
                }
            }
        } else {
            self.showErrorHud(String.genericServerErrorMessage)
        }
    }
    
    @IBAction func returnToSignIn(_ sender: UIButton) {
//        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "loginViewController") as! LoginViewController
//        self.present(viewController, animated: true, completion: nil)
        self.presentingViewController?.dismiss(animated: true)
    }
    
    func createUser() -> Bool {
        guard self.phoneNumberTextField.text?.isEmpty ?? false,
            self.emailTextField.text?.isEmpty ?? false,
            self.passwordTextField.text?.isEmpty ?? false,
            self.confirmPasswordTextField.text?.isEmpty ?? false,
            self.firstNameTextField.text?.isEmpty ?? false,
            self.lastNameTextField.text?.isEmpty ?? false else {
//                AccountManager.shared.currentUser = BeBraveUser(firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber)
                return true
        }
        return false
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UserInformationSegue" {
            _ = segue.destination as! UserInformationFormViewController
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
        textFieldValidator?.validateForm {[weak self] (result) in
            if textField.validValue == nil {
                let textFieldError = textField.getTextfieldErrorFrom(formValidatorErrors: (result.errors as? [ValidationError] ?? []))
                if let textFieldErrorMessage = textFieldError?.errorMessage(textFieldType: textField) {
                    textField.changeTextFieldTo(color: UIColor.red)
                    self?.isFormValid =  self?.errorLabelShow(errorString: textFieldErrorMessage) ?? false
                    return
                }
            } else {
                textField.changeTextFieldTo(color: .white)
                self?.checkForEmptyTextField(before: textField)
                self?.isFormValid = result.errors?.count != 0 ? self?.errorLabelHide() ?? true:false
            }
        }
    }
    
    func errorLabelShow(errorString: String) -> Bool {
        self.errorLabel.text = errorString
        self.errorLabel.isHidden = false
        return false
    }
    
    func errorLabelHide() -> Bool {
        self.errorLabel.text = nil
        self.errorLabel.isHidden = true
        return true
    }
    
    func checkForEmptyTextField(before currentTextField: UITextField) {
        var numOfEmptyBeforeCurrentTextField = 0
        for textField in textFieldsToValidate ?? [] where textField.tag < currentTextField.tag {
            if textField.text?.isEmpty ?? true {
                textField.changeTextFieldTo(color: UIColor.red)
                numOfEmptyBeforeCurrentTextField += 1
            }
        }
        if numOfEmptyBeforeCurrentTextField > 0 {self.errorLabelShow(errorString: String.multipleInvalidFormFieldsErrorMessage)}
    }
    
}

extension FormValidator {
    convenience init( itemsToValidate: [ValidatableInterface]) {
        self.init()
        addItemsToForm(itemsToValidate: itemsToValidate as! [UITextField])
    }
    
    private func addItemsToForm(itemsToValidate: [UITextField]){
        for item in itemsToValidate {
            self.add(item)
        }
    }
        
}

    

