//
//  AdEntity.swift
//  Buromotors
//
//  Created by Anton Redkozubov on 13.10.2020.
//  Copyright © 2020 Anton Redkozubov. All rights reserved.
//

import Foundation

class AdEntity {
    
    var id = ""
    var type = ""
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
    
    init(adEntityModel: AdEntityModel) {
        id = adEntityModel.id
        type = adEntityModel.type
        current = adEntityModel.attributes.current
        deleted = adEntityModel.attributes.deleted
        phone = adEntityModel.attributes.phone
        name = adEntityModel.attributes.name
        description = adEntityModel.attributes.description
        active = adEntityModel.attributes.active
        url = adEntityModel.attributes.url
        email = adEntityModel.attributes.email
        sideOffer = adEntityModel.attributes.sideOffer
        createDate = adEntityModel.attributes.createDate
    }
}
