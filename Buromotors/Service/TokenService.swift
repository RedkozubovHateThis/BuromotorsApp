//
//  TokenService.swift
//  Buromotors
//
//  Created by Ахмед Фокичев on 23.09.2020.
//  Copyright © 2020 Anton Redkozubov. All rights reserved.
//

import Foundation
import SwiftyJSON


class TokenService {
    
    static let shared = TokenService()
    
    var access_token = ""
    var refresh_token = ""
    var expires_in = 0
    var scope = ""
    
    func config(value: JSON) {
        access_token = value["access_token"].stringValue
        refresh_token = value["refresh_token"].stringValue
        scope = value["scope"].stringValue
        expires_in = value["expires_in"].intValue
        
        print("access_token>", access_token)
    }
}

