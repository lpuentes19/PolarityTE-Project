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
    
    convenience init(firstName: String?,
                     lastName: String?,
                     name: String?,
                     phoneNumber: String?,
                     email: String?,
                     zipCode: String?,
                     tenant: String?,
                     profilePhoto: Data?,
                     identifier: UUID = UUID(),
                     managedObjectContext: NSManagedObjectContext = CoreDataStack.shared.mainContext) {

        self.init(context: managedObjectContext)
        
        self.firstName = firstName
        self.lastName = lastName
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = email
        self.zipCode = zipCode
        self.tenant = tenant
        self.profilePhoto = profilePhoto
        self.identifier = identifier
    }
}
