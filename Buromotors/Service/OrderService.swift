//
//  OrderService.swift
//  Buromotors
//
//  Created by Anton Redkozubov on 01.10.2020.
//  Copyright © 2020 Anton Redkozubov. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import ObjectMapper

class OrderService {
    
    static let shared = OrderService()
    var myOrder: ServiceDocument?
    var myVehicle: Vehicle?
    var vehicles = [Vehicle]()
    var vehicleMileages = [VehicleMileage]()
    
    func loadMyOrders(token: String, completion: @escaping ( _ docs: [ServiceDocument], _ success: Bool, _ error: String) -> Void) {
        let url = URLs.ordersUrl
    
        let parameters: Parameters = [
            "page[number]": "1",
            "page[size]": "5",
            "sort": "-startDate",
        ]
        
        let authorization =  "Bearer " + token
        
        let _headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "\(authorization)",
        ]
        
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: _headers).responseJSON { response in
            
            let statusCode = response.response?.statusCode ?? 0
            print("statusCode>",statusCode)
            var serviceDocuments  = [ServiceDocument]()
//            var vehicle = [Vehicle]()
            
            switch response.result {
            case .success(let value):
                print("success orders")
                let json = JSON(value)
                print("json>data>", json["data"])
                
                ///////////////
                if let list = Mapper<ServiceDocumentModel>().mapArray(JSONObject: json["data"].object) {
                    for doc in list {
                        let serviceDocument = ServiceDocument(serviceDocumentModel: doc)
                        serviceDocuments.append(serviceDocument)
                    }
                    print("OrderService>list>",list.count)
                }
                
                
                print("json>included>", json["included"])
                
                for (_,value) in json["included"] {
                    
                    let type = value["type"]
                    
                    switch type {
                    
                    case "vehicleMileage":
                        if let vehicleMileageModel = Mapper<VehicleMileageModel>().map(JSONString: value.rawString() ?? "") {
                            self.vehicleMileages.append(VehicleMileage(vehicleMileageModel: vehicleMileageModel))
                        }
                        
                    case "vehicle":
                        if let vehicleModel = Mapper<VehicleModel>().map(JSONString: value.rawString() ?? "") {
                            self.vehicles.append(Vehicle(vehicleModel: vehicleModel))
                        }
                        
                    default:
                        break
                    }
                    
                }
                print("self.vehicles>", self.vehicles.count)
                
                print("self.vehicleMileages>", self.vehicleMileages.count)
                
                
                for vehicle in self.vehicles {
                    print("vehicle.type>",vehicle.type)
                }
                for vehicleMileage in self.vehicleMileages {
                    print("vehicleMileage.type>",vehicleMileage.type)
                }

                
                
                completion(serviceDocuments, true, "")
                return
            case .failure(let error):
                print("failure orders")
                completion(serviceDocuments, false, error.localizedDescription)
                return
            }
        }
    }
}

