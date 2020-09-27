//
//  VehicleMileageModel.swift
//  Buromotors
//
//  Created by Anton Redkozubov on 27.09.2020.
//  Copyright © 2020 Anton Redkozubov. All rights reserved.
//

import Foundation
import ObjectMapper

class VehicleMileageModel: Mappable {
    var id = ""
    var type = ""
    var mileage = 0
    
    required convenience init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        id <- map["id"]
        type <- map["type"]
        mileage <- map["mileage"]
    }
}

