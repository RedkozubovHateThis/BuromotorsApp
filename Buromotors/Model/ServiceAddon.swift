//
//  ServiceAddon.swift
//  Buromotors
//
//  Created by Anton Redkozubov on 27.09.2020.
//  Copyright © 2020 Anton Redkozubov. All rights reserved.
//

import Foundation

class ServiceAddon {
    var id = ""
    var type = ""
    var count = 0
    var cost = 0.0
    var name = ""
    var number = ""
    
    init(serviceAddonModel: ServiceAddonModel) {
        id = serviceAddonModel.id
        type = serviceAddonModel.type
        number = serviceAddonModel.attributes.number
        count = serviceAddonModel.attributes.count
        name = serviceAddonModel.attributes.name
        number = serviceAddonModel.attributes.number
    }
}
