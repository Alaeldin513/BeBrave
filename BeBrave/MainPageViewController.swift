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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentUser()
    }

    func getCurrentUser(){
        let user = Auth.auth().currentUser
        if let user = user {
            let uid = user.uid
            let email = user.email
            let photoURL = user.photoURL
        }

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
