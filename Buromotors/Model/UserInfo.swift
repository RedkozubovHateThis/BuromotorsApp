//
//  UserInfo.swift
//  Buromotors
//
//  Created by Anton Redkozubov on 13.10.2020.
//  Copyright © 2020 Anton Redkozubov. All rights reserved.
//

import Foundation

class UserInfo {
    var userId = ""
    var profileType = ProfileType.none
    var isAutoRegistered: Bool = false
    var lastName = ""
    var currentAdSubscriptionExpired: Bool = false
    var midisAutoRegistereddleName: Bool = false
    var bankBic = ""
    var bankName = ""
    var fio = ""
    var enabled: Bool = true
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
    var relationships = UserRelationships()
    
    init(userInfoModel: UserInfoModel) {
        userId = userInfoModel.id
        profileType = ProfileType(rawValue: userInfoModel.type) ?? ProfileType.none
        firstName = userInfoModel.attributes.firstName
        isAutoRegistered = userInfoModel.attributes.isAutoRegistered
        lastName = userInfoModel.attributes.lastName
        middleName = userInfoModel.attributes.middleName
        shortFio = userInfoModel.attributes.shortFio
        fio = userInfoModel.attributes.fio
        fullFio = userInfoModel.attributes.fullFio
        username = userInfoModel.attributes.username
//        servicePrice = userInfoModel.attributes.serviceWorkPrice
        serviceGoodsCost = userInfoModel.attributes.serviceGoodsCost
//        email = userInfoModel.attributes.email
        relationships = userInfoModel.relationships
    }
}
