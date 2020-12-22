//
//  AthService.swift
//  Buromotors
//
//  Created by Anton Redkozubov on 23.09.2020.
//  Copyright © 2020 Anton Redkozubov. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AthService {
    
    func regstration(userProfile: UserProfile, password: String, rePassword: String, completion: @escaping (_ success: Bool, _ error: String) -> Void) {
        
        let url = URLs.profileRegistr + userProfile.profileType.rawValue
        
        print("regstration>url>", url)
        let parameters: Parameters = [
            "username": userProfile.name,
              "password": password,
              "rePassword": rePassword,
              "firstName": userProfile.firstName,
              "lastName": userProfile.lastName,
              "middleName": userProfile.middleName,
            "email": userProfile.email,
              "phone": userProfile.phone,
            "inn": userProfile.inn ?? "null"
        ]
        
        let _headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept-Encoding" : "gzip, deflate, br"
        ]
        
        print("regstration>parameters>", parameters)
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: _headers).responseJSON { response in
            let statusCode = response.response?.statusCode ?? 0
            print("regstration>statusCode>",statusCode)
            
            switch response.result {
            case .success(let value):
                if statusCode == 200 {
                    completion(true, "")
                } else {
                    completion(false, "")
                }
                return
            case .failure(let error):
                print("failure")
                completion(false, error.localizedDescription)
                return
            }
        }
    }
    
    func refreshAccessToken(refreshToken: String, completion: @escaping (_ success: Bool, _ error: String) -> Void) {
    
        print(#function)
        let url = URLs.tokenUrl
        let parameters: Parameters = [
            "refresh_token": refreshToken,
            "grant_type" : "refresh_token"
        ]
        let _headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: _headers).responseJSON { response in
            
            let statusCode = response.response?.statusCode ?? 0
            
            print("refreshAccessToken>statusCode>",statusCode)
            print("refreshAccessToken>response.response>",response.response)
            
            switch response.result {
            case .success(let value):
                print("success")
                let json = JSON(value)
                TokenService.shared.config(value: json)
                print("TokenService.shared.access_token>",TokenService.shared.access_token)
                print("TokenService.shared.refresh_token>",TokenService.shared.refresh_token)
                print("TokenService.shared.expires_in>",TokenService.shared.expires_in)
                
                if !TokenService.shared.access_token.isEmpty && !TokenService.shared.refresh_token.isEmpty {
                    completion(true, "")
                } else {
                    completion(false, "Неверный логин или пароль")
                }
                
                return
            case .failure(let error):
                print("failure")
                completion(false, error.localizedDescription)
                return
            }
        }
        
        
    }
    
    
    func ath(username:String, password:String, completion: @escaping (_ success: Bool, _ error: String) -> Void) {
        
        let url = URLs.tokenUrl
        let parameters: Parameters = [
            "username" : username,
            "password" : password,
            "grant_type" : "password",
        ]
        
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString =  "Basic c3ByaW5nLXNlY3VyaXR5LW9hdXRoMi1yZWFkLXdyaXRlLWNsaWVudDpzcHJpbmctc2VjdXJpdHktb2F1dGgyLXJlYWQtd3JpdGUtY2xpZW50LXBhc3N3b3JkMTIzNA=="
        
        print("base64LoginString>", base64LoginString)
        let _headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "\(base64LoginString)",
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: _headers).responseJSON { response in
            
            let statusCode = response.response?.statusCode ?? 0
            
            print("statusCode>",statusCode)
            print("response.response>",response.response)
            
            switch response.result {
            case .success(let value):
                print("success")
                let json = JSON(value)
                TokenService.shared.config(value: json)
                print("TokenService.shared.access_token>",TokenService.shared.access_token)
                print("TokenService.shared.refresh_token>",TokenService.shared.refresh_token)
                print("TokenService.shared.expires_in>",TokenService.shared.expires_in)
                
                if !TokenService.shared.access_token.isEmpty && !TokenService.shared.refresh_token.isEmpty {
                    completion(true, "")
                } else {
                    completion(false, "Неверный логин или пароль")
                }
                
                return
            case .failure(let error):
                print("failure")
                completion(false, error.localizedDescription)
                return
            }
        }
    }
    
    
}
