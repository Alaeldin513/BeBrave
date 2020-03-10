//
//  ConstantStrings.swift
//  BeBrave
//
//  Created by Alaeldin Tirba on 2/13/20.
//  Copyright © 2020 Alaeldin Tirba. All rights reserved.
//

import Foundation
import ATGValidator

extension String {
    static let genericErrorMessage = "An error has occured, please try again later."
    static let genericServerErrorMessage = "Couldn't interact with servers."
    static let fillInRequiredFieldsErrorMessage = "Please fill in all required the field(s)."
    static let enterValidPhoneNumberErrorMessage = "Please enter a valid phone number."
    static let passwordDontMatchErrorMessage = "Passwords don't match please try again"
    static let emailInUseErrorMessage = "This email is already in use, please try again."
    static let invalidEmailErrorMessage = "Please enter a valid email address."
    static let emailAndPasswordMissmatchErrorMessage = "The username and password do not match, please try again."
    static let paymentTypeNotSupportedErrorMessage  = "This payment type is not supported"
    static let passwordTooShortErrorMessage  = "Password must be at least 8 characters long"
    static let nameFieldTooShortErrorMessage = "Please enter a name that's at least 1 character long."
    static let invalidTypeErrorMessage = "The type is incorrect."
    static let genericFormMultipleFieldsErrorMessage = "Validation error please check all the fields. Then try again."
    
    
}

extension ValidationError {
    
    func errorMessage(textFieldType: UITextField?) -> String {
        switch (self, textFieldType) {
        case (.notEqual,textFieldType as? PhoneNumberTextField):
            return "Phone number must be at least ten digits."
        case (.notEqual,textFieldType as? PasswordTextField):
            return "Passwords don't match please try again."
        case (.invalidType,textFieldType as? PhoneNumberTextField):
            return "Please enter a valid phone number. Enter digits only."
        case (.invalidEmail,textFieldType as? EmailTextField):
            return String.invalidEmailErrorMessage
        case (.shorterThanMinimumLength,textFieldType as? NameTextField):
            return "Please enter a name."
        case (.shorterThanMinimumLength,textFieldType as? PasswordTextField):
            return "Password must be at least 8 characters long."
        default:
            return String.genericErrorMessage
        }
    }
    
    func getO(){
        
    }
}

enum textFieldTypes {
    typealias RawValue = UITextField
    case PhoneNumberTextField
}
