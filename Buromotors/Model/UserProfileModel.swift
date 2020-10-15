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
    var attributes: UserAttributes!
    
    required convenience init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        id <- map["id"]
        type <- map["type"]
        attributes <- map["attributes"]
    }
}



class UserAttributes : Mappable {
    var firstName = ""
    var lastName = ""
    var middleName = ""
    var name = ""
    var inn = ""
    var address = ""
    var phone = ""
    var email = ""
    var enable = true
    var balance = 0
    var serviceWorkPrice = 0.0
    var serviceGoodsCost = 0.0
    var fio = ""
    
    
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        firstName <- map["firstName"]
        lastName <- map["lastName"]
        middleName <- map["middleName"]
        name <- map["name"]
        inn <- map["inn"]
        address <- map["address"]
        phone <- map["phone"]
        email <- map["email"]
        serviceWorkPrice <- map["serviceWorkPrice"]
        serviceGoodsCost <- map["serviceGoodsCost"]
        fio <- map["fio"]
    }
}


