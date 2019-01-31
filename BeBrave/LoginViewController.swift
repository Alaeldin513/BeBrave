//
//  ViewController.swift
//  Assault Prevention
//
//  Created by Alaeldin Tirba on 7/3/17.
//  Copyright © 2017 Alaeldin Tirba. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit

class LoginViewController: UIViewController, GIDSignInUIDelegate {
    
    var handle: AuthStateDidChangeListenerHandle?
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorMessage: UILabel!
   
    
    @IBOutlet weak var facebookLoginButton: FBSDKLoginButton!
    @IBOutlet weak var googleLogin: GIDSignInButton!
    
    
    override func viewDidLoad() {
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        facebookLoginButton.delegate = self
        facebookLoginButton.readPermissions = ["email", "public_profile"]
        customizeGoogleSignInButton()
    }
    

    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            print(auth.currentUser?.uid)
//            if let user = user {
//                self.performSegue(withIdentifier: "appMainPage", sender: self)
//            }
            
        }
    }
    
    func customizeGoogleSignInButton(){
        googleLogin.colorScheme = .light
        googleLogin.style = .wide
    }
    
    @IBAction func firbaseEmailLogin(_ sender: UIButton) {
    
        guard let email = self.usernameTextField.text, let password = self.passwordTextField.text else {
            errorMessage.text = "Please fill in all fields"
            return
        }
        
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            guard error == nil else {
                let nsError = error! as NSError
                self.errorMessage.text = AuthErrorCode(rawValue: nsError.code)?.errorMessage
                return
            }            
           
            user?.link(with: credential) { (user, error) in
                if error != nil {
                    print(error)
                }

            }
           self.performSegue(withIdentifier: "appMainPage", sender: self)
        }
    }
    

    
    @IBAction func signUp(_ sender: UIButton) {
        performSegue(withIdentifier: "signUpSegue", sender: self)
    }

}

