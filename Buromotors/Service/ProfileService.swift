//
//  ProfileService.swift
//  Buromotors
//
//  Created by Anton Redkozubov on 25.09.2020.
//  Copyright © 2020 Anton Redkozubov. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import ObjectMapper

//
//PROFILE:
//    {
//        "id": string,
//        "type": "profile",
//        "links": {
//            "self": string
//        },
//        "attributes": {
//            "firstName": string,
//            "lastName": string,
//            "address": string,
//            "deleted": boolean,
//            "phone": string,
//            "name": string,
//            "byFio": boolean,
//            "inn": string,
//            "middleName": string,
//            "autoRegister": boolean,
//            "email": string
//        },
//        "relationships": {
//            "createdBy": {
//                "data": {
//                    "id": string,
//                    "type": "profile"
//                },
//                "links": {
//                    "related": string,
//                    "self": string
//                }
//            },
//            "user": {
//                "links": {
//                    "related": string,
//                    "self": string
//                }
//            }
//        }
//    }

class ProfileService {
    
    static let shared = ProfileService()
    var myProfile: UserProfile?
    var myUser: UserInfo?
    var users = [UserProfile]()
    var myEntity: AdEntity?
    var entities = [AdEntity]()
    
    func saveMyProfile(token: String, userProfile: UserProfile, completion: @escaping (_ success: Bool, _ error: String) -> Void) {
        
        let url = URLs.profileEdit + userProfile.userId
        
        let authorization =  "Bearer " + token
        let _headers: HTTPHeaders = [
            "Content-Type": "application/vnd.api+json",
            "Authorization": "\(authorization)",
        ]
   
        let relationships:Parameters = [String: String]()
        
        let inn = userProfile.inn ?? "null"
        
        let attributes: Parameters = [
            "firstName": userProfile.firstName,
            "lastName": userProfile.lastName,
            "address": userProfile.address,
            "deleted": userProfile.deleted,
            "phone": userProfile.phone,
            "name": userProfile.name,
            "byFio": userProfile.byFio,
            "inn": inn,
            "middleName": userProfile.middleName,
            "autoRegister": userProfile.autoRegister,
            "email": userProfile.email
        ]
        
        let data: Parameters = [
            "type" : "profile",
            "id" : userProfile.userId,
            "attributes" : attributes,
            "relationships": relationships
        ]
        
        let parameters: Parameters = [
            "data": data
        ]
        print("url>", url)
        print("parameters>", parameters)
        
        AF.request(url, method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: _headers).responseJSON { response in
            
            let statusCode = response.response?.statusCode ?? 0
            print("saveMyProfile>statusCode>",statusCode)
            
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
    
    
    
    func saveMyUser(token: String, userInfo: UserInfo, userProfile: UserProfile, completion: @escaping (_ success: Bool, _ error: String) -> Void) {
        
        let url = URLs.userEdit + userInfo.userId
        
        let authorization =  "Bearer " + token
        let _headers: HTTPHeaders = [
            "Content-Type": "application/vnd.api+json",
            "Authorization": "\(authorization)",
        ]
        
        
        userInfo.relationships.roles.forEach { (RoleModel) in
            print(RoleModel)
        }
        
//        let dataRoles : Parameters = [
//            "type": userInfo.profileType.rawValue,
//            "id" : userInfo.userId
//        ]
//
//        let roles: Parameters = [
//            "data": dataRoles
//        ]
        
        let currentAdSubscriptionData : Parameters = [
            "type": userInfo.relationships.currentAdSubscriptionModel.data.type,
            "id" : userInfo.relationships.currentAdSubscriptionModel.data.id
        ]
        let currentAdSubscription : Parameters = [
            "data": currentAdSubscriptionData
        ]

        let currentOperatorSubscriptionData : Parameters = [
            "type": userInfo.relationships.currentOperatorSubscriptionModel.data.type,
            "id" : userInfo.relationships.currentOperatorSubscriptionModel.data.id
        ]
        let currentOperatorSubscription : Parameters = [
            "data": currentOperatorSubscriptionData
        ]

        let adEntityData : Parameters = [
            "type": userInfo.relationships.adEntity.data.type,
            "id" : userInfo.relationships.adEntity.data.id
        ]
        let adEntity : Parameters = [
            "data": adEntityData
        ]
        
        let dataProfile: Parameters = [
            "type": "profile",
            "id" : userProfile.userId
        ]
        
        let profile: Parameters = [
            "data": dataProfile
        ]
        
        var relationships: Parameters = [
//            "roles": roles,
//            "adEntity": adEntity,
//            "currentAdSubscription": currentAdSubscription,
//            "currentOperatorSubscription": currentOperatorSubscription,
            "profile": profile
        ]
        
        if !userInfo.relationships.adEntity.data.id.isEmpty &&
            !userInfo.relationships.adEntity.data.type.isEmpty {
            relationships["adEntity"] = adEntity
        }
        
        if !userInfo.relationships.currentAdSubscriptionModel.data.id.isEmpty &&
            !userInfo.relationships.currentAdSubscriptionModel.data.type.isEmpty {
            relationships["currentAdSubscription"] = currentAdSubscription
        }
        
        if !userInfo.relationships.currentOperatorSubscriptionModel.data.id.isEmpty &&
            !userInfo.relationships.currentOperatorSubscriptionModel.data.type.isEmpty {
            relationships["currentOperatorSubscription"] = currentOperatorSubscription
        }
        
        let attributes: Parameters = [
            "lastName": userInfo.lastName,
            "shortFio": userInfo.shortFio,
            "serviceWorkPrice": userInfo.serviceWorkPrice,
            "isAutoRegistered": userInfo.isAutoRegistered,
            "credentialsNonExpired": userInfo.credentialsNonExpired,
            "checkingAccount": userInfo.checkingAccount,
            "bankBic": userInfo.bankBic,
            "bankName": userInfo.bankName,
            "fio": userInfo.fio,
            "enabled": userInfo.enabled,
            "firstName": userInfo.firstName,
            "balance": userInfo.balance,
            "corrAccount": userInfo.corrAccount,
            "middleName": userInfo.middleName,
            "accountNonExpired": userInfo.accountNonExpired,
            "fullFio": userInfo.fullFio,
            "rawPassword": userInfo.rawPassword,
            "serviceGoodsCost": userInfo.serviceGoodsCost,
            "username": userInfo.username,
            "accountNonLocked": userInfo.accountNonLocked
        ]
        
        let data: Parameters = [
            "type" : "user",
            "id" : userInfo.userId,
            "attributes" : attributes,
            "relationships": relationships
        ]
        
        let parameters: Parameters = [
            "data": data
        ]
        
        print("parameters>", parameters)
        
        AF.request(url, method: .patch, parameters: parameters, encoding: JSONEncoding.default , headers: _headers).responseJSON { response in
            
            let statusCode = response.response?.statusCode ?? 0
            print("saveMyUser>statusCode>",statusCode)
            
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
        
        let url = URLs.profileUrl
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
//                let json = JSON(value)
//                print("loadMyProfile>json>", json)
                
                 let json = JSON(value)
                print("loadMyProfile>json>", json)
                                if let dict = json["data"].dictionaryObject {
                                    if let userInfoModel = Mapper<UserInfoModel>().map(JSON: dict) {
                                        let userInfo = UserInfo(userInfoModel: userInfoModel)
                                        self.myUser = userInfo
                                    }
                                }
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

