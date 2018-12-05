//
//  CoreDataStack.swift
//  PolarityTE_Project
//
//  Created by Luis Puentes on 12/4/18.
//  Copyright © 2018 LuisPuentes. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static let shared = CoreDataStack()
    
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PolarityTE_Project")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if error != nil {
                print("Failed to load Persistent Store, error: \(error!.localizedDescription)")
            }
        })
        return container
    }()
    
    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }
}
