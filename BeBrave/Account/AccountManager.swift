//
//  AccountManager.swift
//  BeBrave
//
//  Created by Alaeldin Tirba on 2/17/20.
//  Copyright © 2020 Alaeldin Tirba. All rights reserved.
//

import Foundation

class AccountManager {
    
    static let shared = AccountManager()
    var currentUser: User? = nil

    // Initialization

    private init() {
        
    }
}
