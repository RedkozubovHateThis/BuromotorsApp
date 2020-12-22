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
    var endDate = Date()
    var startDate = Date()
    var serviceRelationships: ServiceRelationships?
    var status = DocumentStatus.none
    var paidStatus = PaidStatus.notPaid
    var adEntity: AdEntity?
    
    init(adEntity: AdEntity) {
        self.adEntity = adEntity
    }
    
    init(serviceDocumentModel: ServiceDocumentModel) {
        id = serviceDocumentModel.id
        type = serviceDocumentModel.type
        number = serviceDocumentModel.attributes.number
        reason = serviceDocumentModel.attributes.reason
        masterFio = serviceDocumentModel.attributes.masterFio
        cost = serviceDocumentModel.attributes.cost
       // endDate = serviceDocumentModel.attributes.endDate
//        startDate = serviceDocumentModel.attributes.startDate
        serviceRelationships = serviceDocumentModel.relationships
        
        status = DocumentStatus(rawValue: serviceDocumentModel.attributes.status) ?? .none
        paidStatus = PaidStatus(rawValue: serviceDocumentModel.attributes.paidStatus) ?? .none
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
        print("serviceDocumentModel.attributes.endDate>", serviceDocumentModel.attributes.endDate)
        print("serviceDocumentModel.attributes.startDate>", serviceDocumentModel.attributes.startDate)
        
        if let end = formatter.date(from: serviceDocumentModel.attributes.endDate) {
            endDate = end
        }
        if let start = formatter.date(from: serviceDocumentModel.attributes.startDate) {
            startDate = start
        }
    }
}

