//
//  UserInformationFormViewController.swift
//  BeBrave
//
//  Created by Alaeldin Tirba on 3/12/19.
//  Copyright © 2019 Alaeldin Tirba. All rights reserved.
//

import UIKit
import CoreData

class UserInformationFormViewController: UIViewController {

    @IBOutlet weak var genderSegmentControl: UISegmentedControl!
    @IBOutlet weak var firstNameTextfield: UITextField!
    @IBOutlet weak var lastNameTextfield: UITextField!
    @IBOutlet weak var phoneNumberTextfield: UITextField!
    @IBOutlet weak var heightFeetTextfield: UITextField!
    @IBOutlet weak var heightInchesTextfield: UITextField!
    @IBOutlet weak var weightTextfield: UITextField!
    @IBOutlet weak var eyeColorTextField: UITextField!
    @IBOutlet weak var hairColorTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    func configure() {
        firstNameTextfield.text = AccountManager.shared.currentUser?.firstName
        lastNameTextfield.text = AccountManager.shared.currentUser?.lastName
        phoneNumberTextfield.text = AccountManager.shared.currentUser?.phoneNumber
    }
    
    @IBAction func submitUserInformation(_ sender: Any) {
        
    }
    
    func persistCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
        let user = NSManagedObject(entity: entity, insertInto: managedContext)
        
        user.setValue(uname, forKeyPath: "name")
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}
