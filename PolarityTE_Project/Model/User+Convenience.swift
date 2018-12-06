//
//  User+Convenience.swift
//  PolarityTE_Project
//
//  Created by Luis Puentes on 12/4/18.
//  Copyright © 2018 LuisPuentes. All rights reserved.
//

import Foundation
import CoreData

extension User {
    
    var userRepresentation: UserRepresentation? {
        guard let firstName = firstName,
            let lastName = lastName,
            let name = name,
            let phoneNumber = phoneNumber,
            let email = email,
            let zipCode = zipCode,
            let tenant = tenant,
            let profilePhoto = profilePhoto else { return nil }
        
        if guid == nil {
            guid = UUID()
        }
        return UserRepresentation(firstName: firstName, lastName: lastName, name: name, phoneNumber: phoneNumber, email: email, zipCode: zipCode, tenant: tenant, profilePhoto: profilePhoto, guid: guid!)
    }
    
    convenience init(firstName: String?,
                     lastName: String?,
                     name: String?,
                     phoneNumber: String?,
                     email: String?,
                     zipCode: String?,
                     tenant: String?,
                     profilePhoto: Data?,
                     guid: UUID = UUID(),
                     context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {

        self.init(context: context)
        
        self.firstName = firstName
        self.lastName = lastName
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = email
        self.zipCode = zipCode
        self.tenant = tenant
        self.profilePhoto = profilePhoto
        self.guid = guid
    }
    
    convenience init(userRepresentation: UserRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        self.init(firstName: userRepresentation.firstName,
                  lastName: userRepresentation.lastName,
                  name: userRepresentation.name,
                  phoneNumber: userRepresentation.phoneNumber,
                  email: userRepresentation.email,
                  zipCode: userRepresentation.zipCode,
                  tenant: userRepresentation.tenant,
                  profilePhoto: userRepresentation.profilePhoto,
                  guid: userRepresentation.guid!,
                  context: context)
    }
}
