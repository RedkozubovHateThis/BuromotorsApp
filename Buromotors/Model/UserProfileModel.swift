//
//  UserProfileModel.swift
//  Buromotors
//
//  Created by Anton Redkozubov on 25.09.2020.
//  Copyright © 2020 Anton Redkozubov. All rights reserved.
//

import Foundation
import ObjectMapper

class UserProfileModel: Mappable {
    var id = ""
    var type = ""
    var firstName = ""
    var lastName = ""
    var middleName = ""
    var inn = ""
    var address = ""
    var phone = ""
    var email = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        id <- map["id"]
        type <- map["type"]
        firstName <- map["firstName"]
        lastName <- map["lastName"]
        middleName <- map["middleName"]
        inn <- map["inn"]
        address <- map["address"]
        phone <- map["phone"]
        email <- map["email"]
    }
}


