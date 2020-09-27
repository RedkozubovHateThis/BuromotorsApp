//
//  VehicleModel.swift
//  Buromotors
//
//  Created by Anton Redkozubov on 27.09.2020.
//  Copyright © 2020 Anton Redkozubov. All rights reserved.
//

import Foundation
import ObjectMapper

class VehicleModel: Mappable {
    
    var id = ""
    var type = ""
    var modelName = ""
    var regNumber = ""
    var year = 0
    var vinNumber = ""

    
    required convenience init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        id <- map["id"]
        type <- map["type"]
        modelName <- map["modelName"]
        regNumber <- map["regNumber"]
        year <- map["year"]
        vinNumber <- map["vinNumber"]
    }
}
