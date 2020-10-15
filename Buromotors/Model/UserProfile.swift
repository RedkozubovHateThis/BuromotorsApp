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
    var inn = ""
    var address = ""
    var phone = ""
    var email = ""
    var attributes: UserAttributes!
    var servicePrice: Double = 0.0
    var serviceGoodsCost: Double = 0.0
    
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
    }
}
