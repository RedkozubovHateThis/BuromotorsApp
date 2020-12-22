//
//  Register.swift
//  Buromotors
//
//  Created by Anton Redkozubov on 28.10.2020.
//  Copyright © 2020 Anton Redkozubov. All rights reserved.
//

import Foundation
class Register {
    
    var firstName = ""
    var lastName = ""
    var middleName = ""
    var name = ""
    var address = ""
    var email = ""
    var phone = ""
    var inn = ""
    var password = ""
    var rePassword = ""
    
    init(registerModel: RegisterModel) {
        firstName = registerModel.firstName
        lastName = registerModel.lastName
        middleName = registerModel.middleName
        name = registerModel.name
        address = registerModel.address
        email = registerModel.email
        phone = registerModel.phone
        inn = registerModel.inn
        password = registerModel.password
        rePassword = registerModel.rePassword
    }
}

