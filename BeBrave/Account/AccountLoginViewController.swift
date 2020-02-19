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

@objc class LoginViewController: UIViewController {
    
    var handle: AuthStateDidChangeListenerHandle?
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var facebookLoginButton: FBLoginButton!
    @IBOutlet weak var googleLogin: GIDSignInButton!
    
    override func viewDidLoad() {
        setupFacebookSigninButton()
        setupGoogleSigninButton()
    }
    

    override func viewWillAppear(_ animated: Bool) {
    }
    
    @IBAction func login(_ sender: UIButton) {
        guard let email = self.usernameTextField.text, let password = self.passwordTextField.text else {
            self.showErrorHud(String.fillInRequiredFieldsErrorMessage)
            return
        }
        
        FirebaseAccountManager.signInUserWith(email: email, password: password){ (result) in
            switch result {
            case .success(let firebaseUser):
                AccountManager.shared.currentUser = BeBraveUser(firebaseUser: firebaseUser)
                self.performSegue(withIdentifier: "appMainPage", sender: self)
            case .failure(let error):
                self.showErrorHud(FirebaseAccountManager.getStringDescriptionFor(error: error as NSError))
            }
        }
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        performSegue(withIdentifier: "signUpSegue", sender: self)
    }
    
    func setupGoogleSigninButton(){
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        googleLogin.colorScheme = .light
        googleLogin.style = .wide
    }
    
    func setupFacebookSigninButton(){
        facebookLoginButton.delegate = self
        facebookLoginButton.permissions = ["email", "public_profile"]
    }

}

extension LoginViewController: LoginButtonDelegate {
    
    func loginButton(_ loginButton: FBLoginButton!, didCompleteWith result: LoginManagerLoginResult!, error: Error?) {
        guard error == nil else {
            self.showErrorHud(FirebaseAccountManager.getStringDescriptionFor(error: error! as NSError))
            return
        }
        
        guard let accessToken = AccessToken.current?.tokenString else {
            return
        }
        
        let credential = FacebookAuthProvider.credential(withAccessToken: accessToken)
        
        FirebaseAccountManager.signInUserWith(credential: credential) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.showErrorHud(FirebaseAccountManager.getStringDescriptionFor(error: error as NSError))
            case .success(let firebaseUser):
                FirebaseAccountManager.linkProviderAccountToFirbase(user: firebaseUser, credential: credential)
                AccountManager.shared.currentUser = BeBraveUser(firebaseUser: firebaseUser)
                self?.performSegue(withIdentifier: "appMainPage", sender: self)
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton){
        
    }
    
    func getUserInfoFromFacebook() -> [String:String] {
        GraphRequest(graphPath: "/me" , parameters: ["fields":"id,name,email"]).start( completionHandler: { (connection, result, graphError) in
            guard graphError == nil else{
                return
            }
            print(result!)
        })
        return [:]
    }
    
}

extension LoginViewController: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error {
            print("\(error.localizedDescription)")
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        
        FirebaseAccountManager.signInUserWith(credential: credential) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.showErrorHud(FirebaseAccountManager.getStringDescriptionFor(error: error as NSError))
            case .success(let firebaseUser):
                AccountManager.shared.currentUser = BeBraveUser(firebaseUser: firebaseUser)
                FirebaseAccountManager.linkProviderAccountToFirbase(user: firebaseUser, credential: credential)
                self?.performSegue(withIdentifier: "appMainPage", sender: self)
            }
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // [START_EXCLUDE]
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: "ToggleAuthUINotification"),
            object: nil,
            userInfo: ["statusText": "User has disconnected."])
        // [END_EXCLUDE]
    }
}




