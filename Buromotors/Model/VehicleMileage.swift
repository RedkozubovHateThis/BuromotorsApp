//
//  VehicleMileage.swift
//  Buromotors
//
//  Created by Anton Redkozubov on 27.09.2020.
//  Copyright © 2020 Anton Redkozubov. All rights reserved.
//

import Foundation

class VehicleMileage {
    
    var id = ""
    var type = ""
    var mileage = 0
    var deleted = true
    
    init(vehicleMileageModel: VehicleMileageModel) {
        id = vehicleMileageModel.id
        type = vehicleMileageModel.type
        if let attributes = vehicleMileageModel.attributes {
            mileage = attributes.mileage
            deleted = attributes.deleted
        }
    }
}
