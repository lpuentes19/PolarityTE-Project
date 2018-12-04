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
    
    convenience init(firstName: String?, lastName: String?, name: String?, phoneNumber: String?, email: String?, zipCode: String?, tenant: String?, profilePhoto: String?, managedObjectContext: NSManagedObjectContext) {

        self.init(context: managedObjectContext)
        
        self.firstName = firstName
        self.lastName = lastName
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = email
        self.zipCode = zipCode
        self.tenant = tenant
        self.profilePhoto = profilePhoto
    }
}
