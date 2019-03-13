//
//  FirebaseAuthController.swift
//  BeBrave
//
//  Created by Alaeldin Tirba on 2/10/19.
//  Copyright © 2019 Alaeldin Tirba. All rights reserved.
//

import Foundation
import FirebaseAuth

enum Result {
    case success(AuthDataResult)
    case failure(Error)
}
class FirbaseAuth {
    
    static func signUpUser(email: String, password: String, completion: @escaping (Result) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult,error) in
            if error == nil {
                Auth.auth().currentUser?.sendEmailVerification()
                completion(.success(authResult!))
                
            } else {
                AuthErrorCode(rawValue: (error?._code)!)
                completion(.failure(error!))
            }
            
        }
    }
}
