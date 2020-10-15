//
//  Customer.swift
//  Buromotors
//
//  Created by Anton Redkozubov on 27.09.2020.
//  Copyright © 2020 Anton Redkozubov. All rights reserved.
//

import Foundation

class Customer {
    
    var id = ""
    var type = ""
    var address = ""
    var phone = ""
    var name = ""
    var inn = ""
    var email = ""
    
    init(customerModel: CustomerModel) {
        id = customerModel.id
        type = customerModel.type
        address = customerModel.attributes.address
        phone = customerModel.attributes.phone
        name = customerModel.attributes.name
        inn = customerModel.attributes.inn
        email = customerModel.attributes.email
    }
}
