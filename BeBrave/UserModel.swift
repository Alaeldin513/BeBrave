//
//  UserModel.swift
//  BeBrave
//
//  Created by Alaeldin Tirba on 1/30/19.
//  Copyright © 2019 Alaeldin Tirba. All rights reserved.
//

import Foundation

struct User {
    var firstName: String
    var lastName: String
    var email: String
    var phoneNumber: String
    
    init (firstName: String, lastName: String, email: String, phoneNumber: String){
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phoneNumber = phoneNumber
    }
}
