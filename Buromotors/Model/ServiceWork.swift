//
//  ServiceWork.swift
//  Buromotors
//
//  Created by Anton Redkozubov on 27.09.2020.
//  Copyright © 2020 Anton Redkozubov. All rights reserved.
//

import Foundation

class ServiceWork {
    var id = ""
    var type = ""
    var count = 0
    var priceNorm = 0.0
    var price = 0.0
    var timeValue = 0.0
    var number = ""
    var name = ""
    
    init(serviceWorkModel: ServiceWorkModel) {
        id = serviceWorkModel.id
        type = serviceWorkModel.type
        number = serviceWorkModel.attributes.number
        count = serviceWorkModel.attributes.count
        priceNorm = serviceWorkModel.attributes.priceNorm
        price = serviceWorkModel.attributes.price
        timeValue = serviceWorkModel.attributes.timeValue
        name = serviceWorkModel.attributes.name
    }
}
