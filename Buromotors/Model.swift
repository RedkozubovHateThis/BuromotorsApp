//
//  Model.swift
//  Buromotors
//
//  Created by Anton Redkozubov on 24.09.2020.
//  Copyright © 2020 Anton Redkozubov. All rights reserved.
//

import Foundation

struct User : Codable {
    let id : String
    let type : String
    let links : String
}

struct Attributes {
    let lastName : String
    let currentAdSubscriptionExpired : Bool
    let isAutoRegistered : Bool
    let bankBic : String
    let bankName : String
    let fio : String
    let enabled : Bool
    let balance : Double
    let serviceGoodsCost : Double
    let accountNonLocked : Bool
    let currentAdSubscriptionEmpty: Bool
    let shortFio : String
    let serviceWorkPrice : String
    let credentialsNonExpired : Bool
    let checkingAccount : String
    let currentOperatorSubscriptionEmpty : Bool
    let currentOperatorSubscriptionExpired : Bool
    let firstName : String
    let balanceInvalid : Bool
    let corrAccount : String
    let middleName : String
    let accountNonExpired : Bool
    let fullFio : String
    let rawPassword : String
    let username : String
    
}
