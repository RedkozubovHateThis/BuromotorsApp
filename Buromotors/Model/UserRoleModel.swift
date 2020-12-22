//
//  UserRoleModel.swift
//  Buromotors
//
//  Created by Anton Redkozubov on 22.10.2020.
//  Copyright © 2020 Anton Redkozubov. All rights reserved.
//

import Foundation
import ObjectMapper

class UserRoleModel: Mappable {
    var id = ""
    var type = ""
    var attributes : UserRoleAttributes!

    
    required convenience init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        id <- map["id"]
        type <- map["type"]
        attributes <- map["attributes"]
    }
}


class UserRoleAttributes : Mappable {
    var nameRus = ""
    var name = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        nameRus <- map["nameRus"]
        name <- map["name"]
    }
}
