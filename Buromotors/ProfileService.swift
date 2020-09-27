//
//  ProfileService.swift
//  Buromotors
//
//  Created by Ахмед Фокичев on 25.09.2020.
//  Copyright © 2020 Anton Redkozubov. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import ObjectMapper


class ProfileService {
    
    static let shared = ProfileService()
    var myProfile: UserProfile?
    
    func loadMyProfile(token: String, completion: @escaping (_ success: Bool, _ error: String) -> Void) {
        
        let url = "https://service.buromotors.ru:8080/api/external/users/currentUser"
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
                    if let userProfileModel = Mapper<UserProfileModel>().map(JSON: dict) {
                        let userProfile = UserProfile(userProfileModel: userProfileModel)
                        self.myProfile = userProfile
                    }
                }
                    
                print("userId>",ProfileService.shared.myProfile?.userId)
                print("profileType>",ProfileService.shared.myProfile?.profileType)
                
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

