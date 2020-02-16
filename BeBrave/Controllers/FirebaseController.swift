//
//  FirebaseAuthController.swift
//  BeBrave
//
//  Created by Alaeldin Tirba on 2/10/19.
//  Copyright © 2019 Alaeldin Tirba. All rights reserved.
//

import Foundation
import FirebaseAuth

enum Result<Value> {
    case success(Value)
    case failure(Error)
}

class FirebaseAccountManager {
    
    //Signup user using email and password
    static func signUpUserWith(email: String, password: String, completion: @escaping (Result<FirebaseAuth.User>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult,authError) in
            guard authError == nil else {
                completion(.failure(authError!))
            }
            if let result = authResult {
                completion(.success(result.user))
            }
            
        }
    }
    
    //Sign in user using email and password
    static func signInUserWith(email: String, password: String, completion: @escaping (Result<FirebaseAuth.User>) -> Void) {
        _ = EmailAuthProvider.credential(withEmail: email, password: password)
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, authError) in
            guard authError == nil else {
                completion(.failure(authError!))
            }
            if let result = authResult {
                completion(.success(result.user))
            }
        }
    }
    
    //sign in user using credentials
    
    static func signInUserWith(credential: AuthCredential, completion: @escaping (Result<FirebaseAuth.User>) -> Void) {
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult,authError) in
            guard authError == nil else {
                completion(.failure(authError!))
            }
            
            if let result = authResult {
                completion(.success(result.user))
            }
        }
    }
    
    static func linkProviderAccountToFirbase(user: FirebaseAuth.User, credential: AuthCredential) {
        user.linkAndRetrieveData(with: credential) { (user, error) in
            if error != nil {
                return
            }
        }
    }
    
    static func getStringDescriptionFor(error: NSError) -> String {
        var errorString: String
        
        switch AuthErrorCode(rawValue: (error._code))! {
        case .invalidCredential:
            errorString = "The credential entered are invalid."
        case .operationNotAllowed:
            errorString = "The credential you've entered are not allowed."
        case .accountExistsWithDifferentCredential:
            errorString = "This email is already in use by an existing account."
        case .userDisabled:
            errorString = "This account is disabled."
        case .wrongPassword:
            errorString = "The password and email do not match."
        case .missingVerificationID:
            errorString = "The verification code is missing."
        case .invalidVerificationID:
            errorString = "The verification code is invalid."
        case .sessionExpired:
            errorString = "The session has expired."
        case .emailAlreadyInUse:
            errorString = "The email is already in use with another account."
        case .invalidEmail, .invalidSender, .invalidRecipientEmail:
            errorString = "Invalid email."
        case .networkError:
            errorString = "Network error."
        case .weakPassword:
            errorString = "Your password is weak."
        case .userNotFound:
            errorString = "This account does not exist."
        default:
            errorString = "An error has occured."
        }
        return errorString + " Please try again."
    }
}

/*
FIRAuthErrorCodeInvalidCredential` - Indicates the supplied credential is invalid.
This could happen if it has expired or it is malformed.
+ `FIRAuthErrorCodeOperationNotAllowed` - Indicates that accounts
with the identity provider represented by the credential are not enabled.
Enable them in the Auth section of the Firebase console.
+ `FIRAuthErrorCodeAccountExistsWithDifferentCredential` - Indicates the email asserted
by the credential (e.g. the email in a Facebook access token) is already in use by an
existing account, that cannot be authenticated with this sign-in method. Call
fetchProvidersForEmail for this user’s email and then prompt them to sign in with any of
the sign-in providers returned. This error will only be thrown if the "One account per
email address" setting is enabled in the Firebase console, under Auth settings.
+ `FIRAuthErrorCodeUserDisabled` - Indicates the user's account is disabled.
+ `FIRAuthErrorCodeWrongPassword` - Indicates the user attempted sign in with an
incorrect password, if credential is of the type EmailPasswordAuthCredential.
+ `FIRAuthErrorCodeInvalidEmail` - Indicates the email address is malformed.
+ `FIRAuthErrorCodeMissingVerificationID` - Indicates that the phone auth credential was
created with an empty verification ID.
+ `FIRAuthErrorCodeMissingVerificationCode` - Indicates that the phone auth credential
was created with an empty verification code.
+ `FIRAuthErrorCodeInvalidVerificationCode` - Indicates that the phone auth credential
was created with an invalid verification Code.
+ `FIRAuthErrorCodeInvalidVerificationID` - Indicates that the phone auth credential was
created with an invalid verification ID.
+ `FIRAuthErrorCodeSessionExpired` - Indicates that the SMS code has expired.
*/

