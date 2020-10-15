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
    var myUser: UserInfo?
    var users = [UserProfile]()
    var myEntity: AdEntity?
    var entities = [AdEntity]()
    
    
    func saveMyProfile(token: String, userProfile: UserProfile, completion: @escaping (_ success: Bool, _ error: String) -> Void) {
        
        let url = "https://service.buromotors.ru:8080/api/profiles/" + userProfile.userId
        
        let authorization =  "Bearer " + token
        let _headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "\(authorization)",
        ]
        
        let parameters: Parameters = [
            "name": userProfile.name,
            "lasname": userProfile.lastName,
        ]
        
        AF.request(url, method: .patch, parameters: parameters, encoding: URLEncoding.default, headers: _headers).responseJSON { response in
            
            let statusCode = response.response?.statusCode ?? 0
            print("statusCode>",statusCode)
            
            switch response.result {
            case .success(let value):
                print("success")
                
                return
            case .failure(let error):
                print("failure")
                completion(false, error.localizedDescription)
                return
            }
        }
    }
    
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
                print("loadMyProfile>json>", json)
                
                // let json = JSON(value)
                //                if let dict = json["data"].dictionaryObject {
                //                    if let userInfoModel = Mapper<UserInfoModel>().map(JSON: dict) {
                //                        let userInfo = UserInfo(userInfoModel: userInfoModel)
                //                        self.myUser = userInfo
                //                    }
                //                }
                
                
                
                
                print("json>",json)
                
                
                
                for (_,value) in json["included"] {
                    
                    let type = value["type"]
                    
                    switch type {
                    
                    case "adEntity":
                        if let adEntityModel = Mapper<AdEntityModel>().map(JSONString: value.rawString() ?? "") {
                            self.entities.append(AdEntity(adEntityModel: adEntityModel))
                        }
                        
                    case "profile":
                        if let userProfileModel = Mapper<UserProfileModel>().map(JSONString: value.rawString() ?? "") {
                            self.myProfile = UserProfile(userProfileModel: userProfileModel)
                            //self.users.append(UserProfile(userProfileModel: userProfileModel))
                        }
                        
                    default:
                        break
                    }
                    
                }
                print("self.userProfile>", self.users.count)
                
                //                print("self.vehicleMileages>", self.vehicleMileages.count)
                
                
                for userProfile in self.users {
                    print("userProfile.type>",userProfile.profileType)
                }
                //                for vehicleMileage in self.vehicleMileages {
                //                    print("vehicleMileage.type>",vehicleMileage.type)
                //                }
                
                
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

