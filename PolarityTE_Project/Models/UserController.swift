//
//  UserController.swift
//  PolarityTE_Project
//
//  Created by Luis Puentes on 12/5/18.
//  Copyright © 2018 LuisPuentes. All rights reserved.
//

import Foundation
import CoreData

let baseURL = URL(string: "https://q1o3gh76yb.execute-api.us-west-2.amazonaws.com/InterviewProd/users")!

class UserController {
    
    init() {
        fetchUsers()
    }
    
    // Create
    func post(user: User, completion: @escaping (Error?) -> Void = {_ in}) {
        var request = URLRequest(url: baseURL)
        let headers = ["X-api-key":"TqzKu0n0kW7uI5GkghsK76jMxLa4Km0EadtnmSM7"]
        request.allHTTPHeaderFields = headers
        request.httpMethod = "POST"
        do {
            guard let representation = user.userRepresentation else { throw NSError() }
            request.httpBody = try JSONEncoder().encode(representation)
            // Find user and update their properties on our end
            if let user = self.user(withUUID: user.guid!) {
                self.update(user: user, with: representation)
            }
        } catch {
            print("Error encoding user, error: \(error.localizedDescription)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print("Error PUTting user to server, error: \(error!.localizedDescription)")
                completion(error)
                return
            }
            completion(nil)
            }.resume()
    }
    
    // Read/Fetch users from database
    func fetchUsers(completion: @escaping (Error?) -> Void = {_ in }) {
        var requestURL = URLRequest(url: baseURL)
        let headers = ["X-api-key":"TqzKu0n0kW7uI5GkghsK76jMxLa4Km0EadtnmSM7"]
        requestURL.allHTTPHeaderFields = headers
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if error != nil {
                print("Error fetching users: \(error!.localizedDescription)")
                completion(error)
                return
            }
            guard let data = data else {
                print("No data returned")
                completion(error)
                return
            }
            DispatchQueue.main.async {
                do {
                    let userRepresentations = try JSONDecoder().decode([UserRepresentation].self, from: data)
                    for userRep in userRepresentations {
                        let uuid = userRep.guid
                        if let user = self.user(withUUID: uuid!) {
                            // We have a local user in Core Data
                            self.update(user: user, with: userRep)
                        } else {
                            // Need to create a User in Core Data
                            let _ = User(userRepresentation: userRep)
                        }
                    }
                    let moc = CoreDataStack.shared.mainContext
                    try moc.save()
                } catch {
                    print("Error decoding users: \(error.localizedDescription)")
                }
                completion(nil)
            }
            }.resume()
    }
    
    // Update User
    func patch(user: User, completion: @escaping (Error?) -> Void = {_ in}) {
        let requestURL = baseURL.appendingPathComponent(user.guid!)
        var request = URLRequest(url: requestURL)
        let headers = ["X-api-key":"TqzKu0n0kW7uI5GkghsK76jMxLa4Km0EadtnmSM7"]
        request.allHTTPHeaderFields = headers
        request.httpMethod = "PATCH"
        do {
            guard let representation = user.userRepresentation else { throw NSError() }
            request.httpBody = try JSONEncoder().encode(representation)
            // Find user and update their values
            if let user = self.user(withUUID: user.guid!) {
                self.update(user: user, with: representation)
            }
        } catch {
            print("Error encoding user, error: \(error.localizedDescription)")
            completion(error)
            return
        }
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print("Error PATCHing user to server, error: \(error!.localizedDescription)")
                completion(error)
                return
            }
            completion(nil)
            }.resume()
    }
    
    // Fetching users using their guid
    private func user(withUUID uuid: String) -> User? {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "guid == %@", uuid)
        let moc = CoreDataStack.shared.mainContext
        
        // Assuming there is only one matching User
        // We use the 'first' property
        return (try? moc.fetch(fetchRequest))?.first
    }
    
    // Update helper method
    private func update(user: User, with representation: UserRepresentation) {
        user.firstName = representation.firstName
        user.lastName = representation.lastName
        user.name = representation.name
        user.phoneNumber = representation.phoneNumber
        user.email = representation.email
        user.zipCode = representation.zipCode
        user.tenant = representation.tenant
        // Decoding the base64 bit image and passing the value to the profilePhoto property
        if let imageData = representation.profilePhoto, let decodedData = Data(base64Encoded: imageData, options: .ignoreUnknownCharacters) {
            user.profilePhoto = decodedData
        }
        user.guid = representation.guid
    }
}
