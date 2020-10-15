//
//  AdEntityModel.swift
//  Buromotors
//
//  Created by Anton Redkozubov on 13.10.2020.
//  Copyright © 2020 Anton Redkozubov. All rights reserved.
//

import Foundation
import ObjectMapper

class AdEntityModel: Mappable {
    
    var id = ""
    var type = ""
    var attributes : AdEntityAttributes!

    
    required convenience init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        id <- map["id"]
        type <- map["type"]
        attributes <- map["attributes"]
    }
}


class AdEntityAttributes : Mappable {
    var current: Bool = false
    var deleted: Bool = false
    var phone = ""
    var name = ""
    var description = ""
    var active: Bool = false
    var url = ""
    var email = ""
    var sideOffer: Bool = false
    var createDate = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        current <- map["current"]
        deleted <- map["deleted"]
        phone <- map["phone"]
        name <- map["name"]
        description <- map["description"]
        active <- map["active"]
        url <- map["url"]
        email <- map["email"]
        sideOffer <- map["sideOffer"]
        createDate <- map["createDate"]
    }
}

