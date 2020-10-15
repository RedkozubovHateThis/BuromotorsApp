//
//  ServiceDocument.swift
//  Buromotors
//
//  Created by Anton Redkozubov on 27.09.2020.
//  Copyright © 2020 Anton Redkozubov. All rights reserved.
//

import Foundation

class ServiceDocument {
    var id = ""
    var type = ""
    var number = ""
    var reason = ""
    var masterFio = ""
    var cost = 0.0
    var endDate = ""
    var startDate = ""
    
    init(serviceDocumentModel: ServiceDocumentModel) {
        id = serviceDocumentModel.id
        type = serviceDocumentModel.type
        number = serviceDocumentModel.attributes.number
        reason = serviceDocumentModel.attributes.reason
        masterFio = serviceDocumentModel.attributes.masterFio
        cost = serviceDocumentModel.attributes.cost
        endDate = serviceDocumentModel.attributes.endDate
        startDate = serviceDocumentModel.attributes.startDate
    }
}
