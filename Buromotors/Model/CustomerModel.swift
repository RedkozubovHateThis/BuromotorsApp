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
    var attributes : CustomerAttributes!
    var relationships : CustomerRelationships!

    
    required convenience init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        id <- map["id"]
        type <- map["type"]
        attributes <- map["attributes"]
        relationships <- map["relationships"]
    }
}


class CustomerAttributes : Mappable {
    var address = ""
    var phone = ""
    var name = ""
    var inn = ""
    var email = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        address <- map["address"]
        phone <- map["phone"]
        name <- map["name"]
        inn <- map["inn"]
        email <- map["email"]
    }
}

class CustomerRelationships: Mappable {
    var id = ""
    var type = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        type <- map["type"]
    }
}
