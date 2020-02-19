//
//  UserModel.swift
//  BeBrave
//
//  Created by Alaeldin Tirba on 1/30/19.
//  Copyright © 2019 Alaeldin Tirba. All rights reserved.
//

import Foundation
import Firebase

extension BeBraveUser {
    convenience init (fullName: String, email: String, phoneNumber: String ){
        self.init()
        self.fullName = fullName
        self.email = email
        self.phoneNumber = phoneNumber
    }
    
    convenience init(firebaseUser: FirebaseAuth.User) {
        self.init()
        self.fullName = firebaseUser.displayName
        self.email = firebaseUser.email
        self.phoneNumber = firebaseUser.phoneNumber
    }
    
    convenience init(firstName: String, lastName: String, email: String, phoneNumber: String) {
        self.init()
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phoneNumber = phoneNumber
    }

}

