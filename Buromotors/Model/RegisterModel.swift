//
//  RegisterModel.swift
//  Buromotors
//
//  Created by Anton Redkozubov on 28.10.2020.
//  Copyright © 2020 Anton Redkozubov. All rights reserved.
//

import Foundation
import ObjectMapper

class RegisterModel: Mappable {
    
    var firstName = ""
    var lastName = ""
    var middleName = ""
    var name = ""
    var address = ""
    var email = ""
    var phone = ""
    var inn = ""
    var password = ""
    var rePassword = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        firstName <- map["firstName"]
        lastName <- map["lastName"]
        middleName <- map["middleName"]
        name <- map["name"]
        address <- map["address"]
        email <- map["email"]
        phone <- map["phone"]
        inn <- map["inn"]
        password <- map["password"]
        rePassword <- map["rePassword"]
    }
}

