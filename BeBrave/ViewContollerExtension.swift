//
//  AppAlerts.swift
//  BeBrave
//
//  Created by Alaeldin Tirba on 2/10/19.
//  Copyright © 2019 Alaeldin Tirba. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

extension UIViewController {
    
    func showErrorHud(_ message: String) {
        DispatchQueue.main.async {
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.mode = .text
            hud.minSize = CGSize(width: self.view.frame.size.width-20, height: 100)
            hud.label.text = "Error"
            hud.detailsLabel.text = message
            hud.bezelView.color = UIColor(red: 250, green: 20, blue: 20, alpha: 1)
            hud.detailsLabel.textColor = .red
            hud.label.textColor = .red
            hud.isUserInteractionEnabled = false
            hud.hide(animated: true, afterDelay: 3)
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func keyboardPushesViewUpWhenTapped() {
        NotificationCenter.default.addObserver(self, selector: #selector(UIViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(UIViewController.keyboardWillHide), name: UIResponder.keyboardDidHideNotification, object: nil)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height * 17/32
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            UIView.animate(withDuration: 0.3, animations: {
                self.view.frame.origin.y = 0
            })
        }
    }
    
}
