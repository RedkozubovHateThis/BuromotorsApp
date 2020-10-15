//
//  AdvertisingService.swift
//  Buromotors
//
//  Created by Anton Redkozubov on 15.10.2020.
//  Copyright © 2020 Anton Redkozubov. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import ObjectMapper

class AdvertisingService {
    static let shared = AdvertisingService()
    var myAdvertising: AdEntity?
    
    func loadAdvertising(token: String, completion: @escaping (_ success: Bool, _ error: String) -> Void) {
        
        let url = URLs.advertisingUrl
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
                    if let adEntityModel = Mapper<AdEntityModel>().map(JSON: dict) {
                        let adEntityModel = AdEntity(adEntityModel: adEntityModel)
                        self.myAdvertising = adEntityModel
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
