//
//  MainPageViewController.swift
//  Assault Prevention
//
//  Created by Alaeldin Tirba on 7/8/17.
//  Copyright © 2017 Alaeldin Tirba. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class MainPageViewController: UIViewController {

    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var eyeColorLabel: UILabel!
    @IBOutlet weak var hairColorLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupText()
    }
   
    
    func setupText() {
        displayName.text = AccountManager.shared.currentUser?.fullName ?? ""
        genderLabel.text = AccountManager.shared.currentUser?.gender ?? ""
        height.text = AccountManager.shared.currentUser?.height ?? ""
        weightLabel.text = String(describing: AccountManager.shared.currentUser?.weight ?? 0)
        eyeColorLabel.text = AccountManager.shared.currentUser?.eyeColor ?? ""
        hairColorLabel.text = AccountManager.shared.currentUser?.hairColor ?? ""
        birthdayLabel.text = AccountManager.shared.currentUser?.birthday
    }
    
    @IBAction func signOut(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "loginViewController") as! LoginViewController
        self.present(controller, animated: true, completion: nil)
    }

    
}
