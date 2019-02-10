//
//  FirebaseAuthController.swift
//  BeBrave
//
//  Created by Alaeldin Tirba on 2/10/19.
//  Copyright © 2019 Alaeldin Tirba. All rights reserved.
//

import Foundation
import FirebaseAuth

class FirbaseAuth {
    
    func signUpUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error == nil {
                Auth.auth().currentUser?.sendEmailVerification { (error) in}
            } else {
                
            }
            
        }
    }
}
