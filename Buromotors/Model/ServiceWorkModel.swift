//
//  ServiceWorkModel.swift
//  Buromotors
//
//  Created by Anton Redkozubov on 27.09.2020.
//  Copyright © 2020 Anton Redkozubov. All rights reserved.
//

import Foundation
import ObjectMapper

class ServiceWorkModel: Mappable {
    
    var id = ""
    var type = ""
    var count = 0
    var priceNorm = 0.0
    var price = 0.0
    var timeValue = 0.0
    var number = ""

    
    required convenience init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        id <- map["id"]
        type <- map["type"]
        count <- map["count"]
        priceNorm <- map["priceNorm"]
        price <- map["price"]
        timeValue <- map["timeValue"]
        number <- map["number"]

    }
}
