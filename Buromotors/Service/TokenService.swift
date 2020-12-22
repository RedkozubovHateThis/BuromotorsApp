//
//  TokenService.swift
//  Buromotors
//
//  Created by Anton Redkozubov on 23.09.2020.
//  Copyright © 2020 Anton Redkozubov. All rights reserved.
//

import Foundation
import SwiftyJSON


class TokenService {
    
    static let shared = TokenService()
    
    var expires_in = 0
    var scope = ""
    
    var access_token: String {
        get {
            return getString(key: "access_token")
        }
        set(token) {
            setString(key: "access_token", token)
        }
    }
    
    var refresh_token: String {
        get {
            return getString(key: "refresh_token")
        }
        set(token) {
            setString(key: "refresh_token", token)
        }
    }
    
    func config(value: JSON) {
        access_token = value["access_token"].stringValue
        refresh_token = value["refresh_token"].stringValue
        scope = value["scope"].stringValue
        expires_in = value["expires_in"].intValue
        
        print("access_token>", access_token)
    }
    
    
    private func getString(key: String) -> String {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: key) ?? ""
    }
    
    private func setString(key: String, _ value: String) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    
}

