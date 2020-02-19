//
//  BeBraveUser+CoreDataProperties.swift
//  
//
//  Created by Alaeldin Tirba on 2/18/20.
//
//

import Foundation
import CoreData
import Firebase

extension BeBraveUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BeBraveUser> {
        return NSFetchRequest<BeBraveUser>(entityName: "BeBraveUser")
    }

    @NSManaged public var birthday: Int16
    @NSManaged public var email: String?
    @NSManaged public var eyeColor: String?
    @NSManaged public var firebaseAccount: User?
    @NSManaged public var firstName: String?
    @NSManaged public var fullName: String?
    @NSManaged public var gender: String?
    @NSManaged public var hairColor: String?
    @NSManaged public var height: String?
    @NSManaged public var lastName: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var weight: Int16

}
