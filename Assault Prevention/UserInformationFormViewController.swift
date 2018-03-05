//
//  UserInformationFormViewController.swift
//  Assault Prevention
//
//  Created by Alaeldin Tirba on 12/25/17.
//  Copyright © 2017 Alaeldin Tirba. All rights reserved.
//

import UIKit

class UserInformationFormViewController: UIViewController ,UITextFieldDelegate{

    @IBOutlet weak var userFirstName: UITextField!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var userLastName: UITextField!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var userPhoneNumber: UITextField!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var userHeightFeet: UITextField!
    @IBOutlet weak var  heightLabel: UILabel!
    @IBOutlet weak var userHeightInches: UITextField!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var userWeight: UITextField!
    @IBOutlet weak var userEyeColor: UITextField!
    @IBOutlet weak var userHairColor: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }

  
    @IBAction func submitForm(_ sender: Any) {
        guard let firstName = userFirstName.text else {
            return
        }
        
        guard let lastName = userLastName.text else {
            return
        }
        guard let phoneNumber = userPhoneNumber.text else {
            return
        }
        guard let heightFeet = userHeightFeet.text else {
            return

        }
        guard let heightInches = userHeightInches.text else {
            return

        }
        guard let weight = userWeight.text else {
            return

        }
        guard let eyeColor = userEyeColor.text else {
            return

        }
        guard let hairColor = userHairColor.text else {
            return
        }
        
        //check for empty fields
    }

    // MARK: - TextField Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == userPhoneNumber{
            guard textField.text?.count == 10 else {
                phoneLabel.textColor = UIColor.red
                return false
            }
            return true
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == userFirstName || textField == userLastName {
            let newText = textField.text! + string
            guard newText.count < 14 else {
                return false
            }
            let allowedCharacters = CharacterSet.letters
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        
        if textField == userPhoneNumber {
            let newText = textField.text! + string
           
            guard newText.count < 11 else {
                return false
            }
            
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        
        if textField == userHeightFeet {
            let newText = userHeightFeet.text! + string
            guard newText.count < 2, 3 < Int(newText)!, Int(newText)! < 8 else {
                return false
            }
            
        }
        
        if textField == userHeightInches {
            let newText = userHeightInches.text! + string
            guard newText.count < 3, 0 <= Int(newText)!, Int(newText)! < 12 else {
                return false
            }
            
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
            
        if textField == userWeight {
            let newText = textField.text! + string
            guard newText.count < 4, 0 <= Int(newText)!, Int(newText)! < 400 else {
                return false
            }
            
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
}
