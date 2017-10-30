//
//  Constants.swift
//  Assault Prevention
//
//  Created by Alaeldin Tirba on 7/8/17.
//  Copyright © 2017 Alaeldin Tirba. All rights reserved.
//

import Foundation
import FirebaseAuth


class Constants: NSObject {
    
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

}

extension AuthErrorCode {
    var errorMessage: String {
        switch self {
        case .emailAlreadyInUse:
            return "The email is already in use with another account."
        case .invalidEmail, .invalidSender, .invalidRecipientEmail, .internalError:
            return "Please enter a valid email."
        case .networkError:
            return "Network error. Please try again."
        case .weakPassword:
            return "Your password is too weak."
        case .wrongPassword:
            return "Wrong password/username please try again."
        case .userNotFound:
            return "This account does not exist."
        default:
            return "Unknown error occurred"
        }
    }
}
