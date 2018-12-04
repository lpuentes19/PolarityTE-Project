//
//  UserTableViewController.swift
//  PolarityTE_Project
//
//  Created by Luis Puentes on 12/4/18.
//  Copyright © 2018 LuisPuentes. All rights reserved.
//

import UIKit
import CoreData

class UserTableViewController: UITableViewController {
    
    var users: [User] {
        let userRequest: NSFetchRequest<User> = User.fetchRequest()
        let moc = CoreDataStack.shared.mainContext
        
        do {
            return try moc.fetch(userRequest)
        } catch {
            print("Error fetching Users, error: \(error.localizedDescription)")
            return []
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserTableViewCell

        let user = users[indexPath.row]
        
        cell.user = user

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let user = users[indexPath.row]
            let moc = CoreDataStack.shared.mainContext
            moc.delete(user)
            
            do {
                try moc.save()
            } catch {
                print("Issue deleting user. Resetting mainContext to base state, error: \(error.localizedDescription)")
                moc.reset()
            }
            tableView.reloadData()
        }    
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toUserDetailVC" {
            let userDetailVC = segue.destination as! UserDetailViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                let user = users[indexPath.row]
                userDetailVC.user = user
            }
        }
    }
}
