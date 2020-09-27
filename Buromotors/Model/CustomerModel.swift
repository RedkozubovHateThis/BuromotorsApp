//
//  CustomerModel.swift
//  Buromotors
//
//  Created by Anton Redkozubov on 27.09.2020.
//  Copyright © 2020 Anton Redkozubov. All rights reserved.
//

import Foundation
import ObjectMapper

class CustomerModel: Mappable {
    var id = ""
    var type = ""
    var address = ""
    var phone = ""
    var name = ""
    var inn = ""
    var email = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        id <- map["id"]
        type <- map["type"]
        address <- map["address"]
        phone <- map["phone"]
        name <- map["name"]
        inn <- map["inn"]
        email <- map["email"]
    }
}

