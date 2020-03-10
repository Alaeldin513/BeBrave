//
//  GoogleButton.swift
//  Assault Prevention
//
//  Created by Alaeldin Tirba on 8/16/17.
//  Copyright © 2017 Alaeldin Tirba. All rights reserved.
//

import UIKit
import GoogleSignIn
import FacebookLogin
@IBDesignable class GoogleButton: GIDSignInButton {
    

    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet{
            self.layer.borderWidth = CGFloat(borderWidth)
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var buttonStyle: GIDSignInButtonStyle = GIDSignInButtonStyle.iconOnly {
        didSet{
            self.style = buttonStyle
        }
    }

}

