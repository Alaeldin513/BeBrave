//
//  GoogleLoginDelegate.swift
//  Assault Prevention
//
//  Created by Alaeldin Tirba on 8/17/17.
//  Copyright © 2017 Alaeldin Tirba. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

extension LoginViewController: GIDSignInDelegate {

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error {
            print("\(error.localizedDescription)")
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil {
                print("Google Account login Authenication on firebase failed ")
                return
            }
            user?.link(with: credential) { (user, error) in
                if (error != nil) {
                    print(error)
                }
            }
            guard let uid = user?.uid else { return }
            print("Succesly login", uid)
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
