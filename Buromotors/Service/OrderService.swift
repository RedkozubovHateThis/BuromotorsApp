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
    var myCustomer: Customer?
    var vehicles = [Vehicle]()
    var vehicleMileages = [VehicleMileage]()
    var customers = [Customer]()
    var page = 1
    var pageSize = 5
    var docFilter = DocFilter(state: "", paidState: "", organization: "")
    
    var serviceDocuments  = [ServiceDocument]()
    
    func getVehicle(id: String) ->Vehicle? {
        var result: Vehicle?
        
        for vehicle in vehicles {
            if vehicle.id == id {
               result = vehicle
            }
        }
        return result
    }
    
    func getVehicleMileage(id: String) ->VehicleMileage? {
        var result: VehicleMileage?
        
        for vehicleMileage in vehicleMileages {
            if vehicleMileage.id == id {
               result = vehicleMileage
            }
        }
        return result
    }
    
    func isDoc(id: String) -> Bool {
        var result = false
        for doc in serviceDocuments {
            if doc.id == id {
                result = true
            }
        }
        return result
    }
    
    func loadMyOrders(token: String, filter: DocFilter?, completion: @escaping ( _ docs: [ServiceDocument], _ success: Bool, _ error: String) -> Void) {
        
        if let filter = filter {
            self.docFilter = filter
            page = 1
        }
        
        let url = URLs.ordersUrl
    
        var parameters: Parameters = [
            "page[number]": String(page),
            "page[size]": String(pageSize),
            "sort": "-startDate",
        ]
        
        if !docFilter.state.isEmpty {
            parameters["filter[state]"] = docFilter.state
        }
        if !docFilter.paidState.isEmpty {
            parameters["filter[paidState]"] = docFilter.paidState
        }
        if !docFilter.organization.isEmpty {
            parameters["filter[organization]"] = docFilter.organization
        }
        
        let authorization =  "Bearer " + token
        
        let _headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "\(authorization)",
        ]
        
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: _headers).responseJSON { response in
            
            let statusCode = response.response?.statusCode ?? 0
            print("statusCode>",statusCode)
            
            switch response.result {
            case .success(let value):
                print("success orders")
                let json = JSON(value)
                print("json>data>", json["data"])
                
                ///////////////
                if let list = Mapper<ServiceDocumentModel>().mapArray(JSONObject: json["data"].object) {
                    if list.count == self.pageSize {
                        self.page += 1
                    }
                    
                    for doc in list {
                        let serviceDocument = ServiceDocument(serviceDocumentModel: doc)
                        if !self.isDoc(id: serviceDocument.id) {
                            self.serviceDocuments.append(serviceDocument)
                        }
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
                        
                    case "customer":
                        if let customerModel = Mapper<CustomerModel>().map(JSONString: value.rawString() ?? "") {
                            print("customerModel.id>", customerModel.id)
                            self.customers.append(Customer(customerModel: customerModel))
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
//                for profile in self.vehicleMileages {
//                    print("vehicleMileage.type>",vehicleMileage.type)
//                }

                
                
                completion(self.serviceDocuments, true, "")
                return
            case .failure(let error):
                print("failure orders")
                completion(self.serviceDocuments, false, error.localizedDescription)
                return
            }
        }
    }
}
