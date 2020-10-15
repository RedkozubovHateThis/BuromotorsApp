//
//  ServiceAddonModel.swift
//  Buromotors
//
//  Created by Anton Redkozubov on 27.09.2020.
//  Copyright © 2020 Anton Redkozubov. All rights reserved.
//

import Foundation
import ObjectMapper

class ServiceAddonModel: Mappable {
    
    var id = ""
    var type = ""
    var attributes : ServiceAddonAttributes!

    
    required convenience init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        id <- map["id"]
        type <- map["type"]
        attributes <- map["attributes"]
    }
}

class ServiceAddonAttributes : Mappable {
    var count = 0
    var cost = 0.0
    var name = ""
    var number = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        count <- map["count"]
        cost <- map["cost"]
        name <- map["name"]
        number <- map["number"]
    }
}
