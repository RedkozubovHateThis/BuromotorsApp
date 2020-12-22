//
//  UserProfile.swift
//  Buromotors
//
//  Created by Anton Redkozubov on 25.09.2020.
//  Copyright © 2020 Anton Redkozubov. All rights reserved.
//

import Foundation

class UserProfile {
    var userId = ""
    var profileType = ProfileType.none
    var firstName = ""
    var lastName = ""
    var middleName = ""
    var name = ""
    var inn: String?
    var address = ""
    var phone = ""
    var email = ""
    var attributes: UserAttributes!
    var servicePrice: Double = 0.0
    var serviceGoodsCost: Double = 0.0
    var byFio = ""
    var deleted = false
    var autoRegister = false
    var rawPassword = ""
    
    init(userProfileModel: UserProfileModel) {
        userId = userProfileModel.id
        profileType = ProfileType(rawValue: userProfileModel.type) ?? ProfileType.none
        firstName = userProfileModel.attributes.firstName
        lastName = userProfileModel.attributes.lastName
        middleName = userProfileModel.attributes.middleName
        name = userProfileModel.attributes.name
        address = userProfileModel.attributes.address
        phone = userProfileModel.attributes.phone
        inn = userProfileModel.attributes.inn
        servicePrice = userProfileModel.attributes.serviceWorkPrice
        serviceGoodsCost = userProfileModel.attributes.serviceGoodsCost
        email = userProfileModel.attributes.email
        byFio = userProfileModel.attributes.byFio
        deleted = userProfileModel.attributes.deleted
        autoRegister = userProfileModel.attributes.autoRegister
        rawPassword = userProfileModel.attributes.rawPassword
    }
    
    init(type: ProfileType,
         firstName: String,
         lastName: String,
         middleName: String,
         name: String,
         address:String,
         phone: String,
         inn: String?,
         email: String,
         rawPassword: String
         ) {
        self.profileType = type
        self.firstName = firstName
        self.lastName = lastName
        self.middleName = middleName
        self.name = name
        self.address = address
        self.phone = phone
        self.inn = inn
        self.email = email
        self.rawPassword = rawPassword
    }
}
