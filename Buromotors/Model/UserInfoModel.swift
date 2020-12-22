//
//  UserInfoModel.swift
//  Buromotors
//
//  Created by Anton Redkozubov on 13.10.2020.
//  Copyright © 2020 Anton Redkozubov. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftyJSON

class UserInfoModel: Mappable {
    var id = ""
    var type = ""
    var attributes: UserInfoAttributes!
    var relationships : UserRelationships!
    
    required convenience init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        id <- map["id"]
        type <- map["type"]
        attributes <- map["attributes"]
        relationships <- map["relationships"]
    }
}

class UserInfoAttributes : Mappable {
    var lastName = ""
    var currentAdSubscriptionExpired: Bool = false
    var midisAutoRegistereddleName: Bool = false
    var isAutoRegistered: Bool = false
    var bankBic = ""
    var bankName = ""
    var fio = ""
    var enabled: Bool = false
    var balance: Double = 0.0
    var enable = true
    var serviceGoodsCost: Double = 0.0
    var accountNonLocked: Bool = false
    var currentAdSubscriptionEmpty: Bool = false
    var shortFio = ""
    var serviceWorkPrice: Double = 0.0
    var credentialsNonExpired: Bool = false
    var checkingAccount = ""
    var currentOperatorSubscriptionEmpty: Bool = false
    var currentOperatorSubscriptionExpired: Bool = false
    var firstName = ""
    var balanceInvalid: Bool = false
    var corrAccount = ""
    var middleName = ""
    var accountNonExpired: Bool = false
    var fullFio = ""
    var rawPassword = ""
    var username = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        lastName <- map["lastName"]
        currentAdSubscriptionExpired <- map["currentAdSubscriptionExpired"]
        midisAutoRegistereddleName <- map["midisAutoRegistereddleName"]
        isAutoRegistered <- map["isAutoRegistered"]
        bankBic <- map["bankBic"]
        bankName <- map["bankName"]
        fio <- map["fio"]
        enabled <- map["enabled"]
        serviceGoodsCost <- map["serviceGoodsCost"]
        accountNonLocked <- map["accountNonLocked"]
        currentAdSubscriptionEmpty <- map["currentAdSubscriptionEmpty"]
        shortFio <- map["shortFio"]
        serviceWorkPrice <- map["serviceWorkPrice"]
        credentialsNonExpired <- map["credentialsNonExpired"]
        checkingAccount <- map["checkingAccount"]
        currentOperatorSubscriptionEmpty <- map["currentOperatorSubscriptionEmpty"]
        currentOperatorSubscriptionExpired <- map["currentOperatorSubscriptionExpired"]
        firstName <- map["firstName"]
        balanceInvalid <- map["balanceInvalid"]
        corrAccount <- map["corrAccount"]
        middleName <- map["middleName"]
        accountNonExpired <- map["accountNonExpired"]
        fullFio <- map["fullFio"]
        rawPassword <- map["rawPassword"]
        username <- map["username"]
    }
}
// Mark: - relations

class UserRelationships: Mappable {
    
    var adEntity = AdEntityParse()
    //    var executor : Executor!
    var profile : Profile!
    var roles = [RoleModel]()
    var currentOperatorSubscriptionModel = CurrentOperatorSubscriptionModel()
    var currentAdSubscriptionModel = CurrentAdSubscriptionModel()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        adEntity <- map["adEntity"]
        //        executor <- map["executor"]
        profile <- map["profile"]
        currentAdSubscriptionModel <- map["currentAdSubscription"]
        currentOperatorSubscriptionModel <- map["currentOperatorSubscription"]
        
//        if let list = Mapper<RoleModel>().mapArray(JSONObject: json["roles"].object) {
//            roles = list
//        }
    }
    
}

class CurrentOperatorSubscriptionModel: Mappable {
    
    var data = DataDoc()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        data <- map["data"]
    }
}

class CurrentAdSubscriptionModel: Mappable {
    
    var data = DataDoc()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        data <- map["data"]
    }
}

class Profile: Mappable {
    
    var id = ""
    var type: UserProfile!
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        type <- map["type"]
    }
}

class RoleModel: Mappable {
    
    var data = DataDoc()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        data <- map["data"]
    }
}

class CurrentAdSubscription: Mappable {
    
    var id = ""
    var type: CurrentAdSubscription!
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        type <- map["type"]
    }
}

class AdEntityParse: Mappable {
    
    var data = DataDoc()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        data <- map["data"]
    }
}
