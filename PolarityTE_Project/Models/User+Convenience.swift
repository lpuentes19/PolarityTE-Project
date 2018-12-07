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
    
    // MARK: - Properties
    
    // Computed property that will always get the most up to date values
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
            guid = UUID().uuidString
        }
        return UserRepresentation(firstName: firstName,
                                  lastName: lastName,
                                  name: name,
                                  phoneNumber: phoneNumber,
                                  email: email,
                                  zipCode: zipCode,
                                  tenant: tenant,
                                  // Encoding the profilePhoto properties value as base64 bit
                                  profilePhoto: String(data: profilePhoto, encoding: .utf8), guid: guid!)
    }
    
    // MARK: - Initializers
    convenience init(firstName: String,
                     lastName: String,
                     name: String,
                     phoneNumber: String,
                     email: String,
                     zipCode: String,
                     tenant: String,
                     profilePhoto: Data?,
                     guid: String?,
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
    // Initializer that takes in a UserRepresentation that then sets the User properties
    // To the values received from the database
    convenience init(userRepresentation: UserRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        self.init(firstName: userRepresentation.firstName,
                  lastName: userRepresentation.lastName,
                  name: userRepresentation.name,
                  phoneNumber: userRepresentation.phoneNumber,
                  email: userRepresentation.email,
                  zipCode: userRepresentation.zipCode,
                  tenant: userRepresentation.tenant,
                  profilePhoto: userRepresentation.profilePhoto?.data(using: .utf8),
                  guid: userRepresentation.guid!,
                  context: context)
        // Decoding the base64 bit image and passing the value to the profilePhoto property
        if let imageData = userRepresentation.profilePhoto, let decodedData = Data(base64Encoded: imageData, options: .ignoreUnknownCharacters) {
            profilePhoto = decodedData
        }
    }
}
