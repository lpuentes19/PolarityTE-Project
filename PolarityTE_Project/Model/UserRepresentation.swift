//
//  UserRepresentation.swift
//  PolarityTE_Project
//
//  Created by Luis Puentes on 12/5/18.
//  Copyright © 2018 LuisPuentes. All rights reserved.
//

import Foundation

struct UserRepresentation: Codable, Equatable {
    
    var firstName: String
    var lastName: String
    var name: String
    var phoneNumber: String
    var email: String
    var zipCode: String
    var tenant: String
    var profilePhoto: Data?
    var guid: String?
}

extension UserRepresentation {
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case name
        case phoneNumber = "phone_number"
        case email
        case zipCode = "zipcode"
        case tenant
        case profilePhoto = "profilePhoto"
        case guid
    }
}

