//
//  BeBraveUser+CoreDataClass.swift
//  BeBrave
//
//  Created by Alaeldin Tirba on 2/20/20.
//  Copyright © 2020 Alaeldin Tirba. All rights reserved.
//
//

import Foundation
import CoreData
import Firebase

public class BeBraveUser: NSManagedObject {
    convenience init (fullName: String, email: String, phoneNumber: String ){
        self.init()
        //self.fullName = fullName
        self.email = email
        self.phoneNumber = phoneNumber
        setFirstAndLastFrom(fullName: fullName)
    }
    
    convenience init(firebaseUser: FirebaseAuth.User) {
        self.init(context: CoreDataManager.shared.persistentContainer.viewContext)
        self.fullName = firebaseUser.displayName
        self.email = firebaseUser.email
        self.phoneNumber = firebaseUser.phoneNumber
        setFirstAndLastFrom(fullName: fullName)
    }
    
    convenience init(firstName: String, lastName: String, email: String, phoneNumber: String) {
        self.init(context: CoreDataManager.shared.persistentContainer.viewContext)
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phoneNumber = phoneNumber
    }
    
    func setFirstAndLastFrom(fullName: String?){
        let fullNameArray = fullName?.components(separatedBy: " ")
        self.firstName = fullNameArray?[0]
        self.lastName = fullNameArray?[1]
    }
}
