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
    
    var phoneNumber: String?
    var firstName: String?
    var lastName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    func configure() {
        firstNameTextfield.text = firstName
        lastNameTextfield.text = lastName
        phoneNumberTextfield.text = phoneNumber
    }
    @IBAction func submitUserInformation(_ sender: Any) {
        
    }
    
}
