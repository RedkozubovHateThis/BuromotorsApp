//
//  Vehicle.swift
//  Buromotors
//
//  Created by Anton Redkozubov on 27.09.2020.
//  Copyright © 2020 Anton Redkozubov. All rights reserved.
//

import Foundation

class Vehicle {
    var id = ""
    var type = ""
    var modelName = ""
    var regNumber = ""
    var year = 0
    var vinNumber = ""
    
    init(vehicleModel: VehicleModel) {
        id = vehicleModel.id
        type = vehicleModel.type
        if let attributes = vehicleModel.attributes {
            modelName = attributes.modelName
            regNumber = attributes.regNumber
            year = attributes.year
            vinNumber = attributes.vinNumber
        }
    }
}
