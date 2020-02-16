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
            hud.label.text = "Error"
            hud.detailsLabel.text = message
            hud.bezelView.color = .red
            hud.detailsLabel.textColor = .white
            hud.label.textColor = UIColor(red: 150 , green: 47, blue: 46, alpha: 1)
            hud.isUserInteractionEnabled = false
            hud.hide(animated: true, afterDelay: 5)
        }
    }
    
}
