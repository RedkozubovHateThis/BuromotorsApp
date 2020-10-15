//
//  WorkOrderService.swift
//  Buromotors
//
//  Created by Anton Redkozubov on 08.10.2020.
//  Copyright © 2020 Anton Redkozubov. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import ObjectMapper

class WorkOrderService {
    
    static let shared = WorkOrderService()
    var myWorkOrder: ServiceWork?
    var myAddon: ServiceAddon?
    var myOrder: ServiceDocument?
    
    func loadMyWorkInOrder(token: String, completion: @escaping (_ success: Bool, _ error: String) -> Void) {
        
        let url = URLs.serviceWorkUrl + "\(myOrder?.id)/serviceWorks"
        let parameters: Parameters = ["": ""]
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
                print("success")
                let json = JSON(value)
                if let dict = json["data"].dictionaryObject {
                    if let serviceWorkModel = Mapper<ServiceWorkModel>().map(JSON: dict) {
                        let serviceWorkProfile = ServiceWork(serviceWorkModel: serviceWorkModel)
                        self.myWorkOrder = serviceWorkProfile
                    }
                }
                    
                print("json>",json)
                
                
                completion(true,"")
                return
            case .failure(let error):
                print("failure")
                completion(false, error.localizedDescription)
                return
            }
        }
    }
    
    func loadMyAddonInOrder(token: String, completion: @escaping (_ success: Bool, _ error: String) -> Void) {
        
        let url = URLs.serviceWorkUrl + "\(myOrder?.id)/serviceAddons"
        let parameters: Parameters = ["": ""]
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
                print("success")
                let json = JSON(value)
                if let dict = json["data"].dictionaryObject {
                    if let serviceAddonModel = Mapper<ServiceAddonModel>().map(JSON: dict) {
                        let serviceAddonProfile = ServiceAddon(serviceAddonModel: serviceAddonModel)
                        self.myAddon = serviceAddonProfile
                    }
                }
                    
                print("json>",json)
                
                
                completion(true,"")
                return
            case .failure(let error):
                print("failure")
                completion(false, error.localizedDescription)
                return
            }
        }
    }
}
