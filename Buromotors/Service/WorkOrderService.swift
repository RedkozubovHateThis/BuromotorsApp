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
    
    func loadMyWorkInOrder(orderId: String, token: String, completion: @escaping ( _ list: [ServiceWork],_ success: Bool, _ error: String) -> Void) {
        
        let url = URLs.serviceWorkUrl + "\(orderId)/serviceWorks"
        let parameters: Parameters = ["": ""]
        let authorization =  "Bearer " + token
        
        let _headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "\(authorization)",
        ]
        
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: _headers).responseJSON { response in
            
            let statusCode = response.response?.statusCode ?? 0
            print("statusCode>",statusCode)
    
            var serviceWorks = [ServiceWork]()
            
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                
                if let list = Mapper<ServiceWorkModel>().mapArray(JSONObject: json["data"].object) {
                    for doc in list {
                        let serviceWork = ServiceWork(serviceWorkModel: doc)
                        serviceWorks.append(serviceWork)
                    }
                }
                               
                completion(serviceWorks, true, "")
                return
            case .failure(let error):
                print("failure")
                completion(serviceWorks, false, error.localizedDescription)
                return
            }
        }
    }
    
    func loadMyAddonInOrder(myOrderId: String,token: String, completion: @escaping ( _ list: [ServiceAddon],_ success: Bool, _ error: String) -> Void) {

        let url = URLs.serviceWorkUrl + "\(myOrderId)/serviceAddons"
        let parameters: Parameters = ["": ""]
        let authorization =  "Bearer " + token

        let _headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "\(authorization)",
        ]

        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: _headers).responseJSON { response in

            let statusCode = response.response?.statusCode ?? 0
            print("statusCode>",statusCode)
            
            var serviceAddons = [ServiceAddon]()

            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                
                if let list = Mapper<ServiceAddonModel>().mapArray(JSONObject: json["data"].object) {
                    for doc in list {
                        let serviceAddon = ServiceAddon(serviceAddonModel: doc)
                        serviceAddons.append(serviceAddon)
                    }
                }
                               
                completion(serviceAddons, true, "")

            case .failure(let error):
                print("failure")
                completion(serviceAddons,false, error.localizedDescription)

            }
        }
    }
}
