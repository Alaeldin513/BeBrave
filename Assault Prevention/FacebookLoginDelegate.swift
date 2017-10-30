//
//  FacebookLogin.swift
//  Assault Prevention
//
//  Created by Alaeldin Tirba on 8/17/17.
//  Copyright © 2017 Alaeldin Tirba. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit

extension LoginViewController: FBSDKLoginButtonDelegate {
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        guard error == nil else {print("The following error has occur: ", error); return}
        guard let accessToken = FBSDKAccessToken.current()?.tokenString else {return}
        
        let credential = FacebookAuthProvider.credential(withAccessToken: accessToken)
        Auth.auth().signIn(with: credential, completion: { (user,err) in

            guard err == nil else {
                self.errorMessage.text = "Facebook firebase auth error with acces token! \n \(err.debugDescription)"
                return
            }
            
            FBSDKGraphRequest(graphPath: "/me" , parameters: ["fields":"id,name,email"]).start( completionHandler: { (connection, result, graphError) in
                guard graphError == nil else{
                   self.errorMessage.text = "failed graph request"
                    return
                }
                print(result ?? "no results found from facebook login")
            })
            self.performSegue(withIdentifier: "appMainPage", sender: self)
            
        })

        
    }
 
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!){
        
    }
    
    func authorizeWithFirbase(accessToken: String){
       
        let credential = FacebookAuthProvider.credential(withAccessToken: accessToken)
        Auth.auth().signIn(with: credential, completion: { (user,err) in
            guard err == nil else {
                print("Facebook firebase auth error with acces token! ", err!)
                return
            }
            
            user?.link(with: credential) { (user, error) in
                if error != nil {
                    print(error)
                }
                
            }
        })
    }
}

