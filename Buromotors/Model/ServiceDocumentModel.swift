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
    var attributes : ServiceAttributes!
    var relationships : ServiceRelationships!

    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        type <- map["type"]
        attributes <- map["attributes"]
        relationships <- map["relationships"]
        print("relationships>id>", relationships.client.id)
        
    }
}

class ServiceAttributes : Mappable {
    var number = ""
    var reason = ""
    var masterFio = ""
    var cost = 0.0
    var endDate = ""
    var startDate = ""
    var status = ""
    var paidStatus = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        number <- map["number"]
        reason <- map["reason"]
        masterFio <- map["masterFio"]
        cost <- map["cost"]
        endDate <- map["endDate"]
        startDate <- map["startDate"]
        status <- map["status"]
        paidStatus <- map["paidStatus"]
    }
}

// Mark: - ralations

class ServiceRelationships: Mappable {
    
    var vehicleMileage : VehicleMileageDoc!
    var executor : Executor!
    var client : Client!
    var vehicle : VehicleDoc!
    var customer : CustomerDoc!
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        vehicleMileage <- map["vehicleMileage"]
        executor <- map["executor"]
        client <- map["client"]
        vehicle <- map["vehicle"]
        customer <- map["customer"]
    }
}

class VehicleMileageDoc: Mappable {
    
    var data = DataDoc()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        data <- map["data"]
    }
}

class DataDoc: Mappable {
    var id = ""
    var type = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        type <- map["type"]
    }
}

class Executor: Mappable {
    

    var data = DataDoc()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        data <- map["data"]
    }
}

class Client: Mappable {
    
    var id = ""
    var data = DataDoc()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        data <- map["data"]
    }
}

class VehicleDoc: Mappable {
    
    var data = DataDoc()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        data <- map["data"]
    }
}

class CustomerDoc: Mappable {
    
    var data = DataDoc()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        data <- map["data"]
    }
}
