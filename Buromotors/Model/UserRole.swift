//
//  UserRole.swift
//  Buromotors
//
//  Created by Anton Redkozubov on 22.10.2020.
//  Copyright © 2020 Anton Redkozubov. All rights reserved.
//

import Foundation

class UserRole {
    
    var id = ""
    var type = ""
    var nameRus = ""
    var name = ""
    
    init(userRoleModel: UserRoleModel) {
        id = userRoleModel.id
        type = userRoleModel.type
        nameRus = userRoleModel.attributes.nameRus
        name = userRoleModel.attributes.name
    }
}
