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
        var name: String
        var email: String
        var firstName: String?
        var lastName: String?
        var phoneNumber: String?
        var height: String?
        var weight: String?
        var hairColor: String?
        var eyeColor: String?
        
    
        
        init (name: String, email: String, phoneNumber: String ){
            self.name = name
            self.email = email
            self.phoneNumber = phoneNumber
            return
        }
        
//        init(firstName:String, lastName: String, phoneNumber: String, height: String, weight: String, hairColor: String, eyeColor: String) {
//            self.firstName = firstName
//            self.lastName = lastName
//            self.phoneNumber = phoneNumber
//            
//        }
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
