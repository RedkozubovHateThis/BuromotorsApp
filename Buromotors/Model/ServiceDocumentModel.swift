//
//  ServiceDocumentModel.swift
//  Buromotors
//
//  Created by Anton Redkozubov on 27.09.2020.
//  Copyright © 2020 Anton Redkozubov. All rights reserved.
//

import Foundation
import ObjectMapper

class ServiceDocumentModel: Mappable {
    
    var id = ""
    var type = ""
    var number = ""
    var reason = ""
    var masterFio = ""
    var cost = 0.0
    var endDate = ""
    var startDate = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        id <- map["id"]
        type <- map["type"]
        number <- map["number"]
        reason <- map["reason"]
        masterFio <- map["masterFio"]
        cost <- map["cost"]
        endDate <- map["endDate"]
        startDate <- map["startDate"]
    }
}
