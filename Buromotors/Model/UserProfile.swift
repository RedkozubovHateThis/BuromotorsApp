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
    var profileType = ""
    var firstName = ""
    var lastName = ""
    var middleName = ""
    
    init(userProfileModel: UserProfileModel) {
        userId = userProfileModel.id
        profileType = userProfileModel.type
        firstName = userProfileModel.firstName
        lastName = userProfileModel.lastName
        middleName = userProfileModel.middleName
    }
}
