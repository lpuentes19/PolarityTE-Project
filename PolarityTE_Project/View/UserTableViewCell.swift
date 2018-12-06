//
//  UserTableViewCell.swift
//  PolarityTE_Project
//
//  Created by Luis Puentes on 12/4/18.
//  Copyright © 2018 LuisPuentes. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    var user: User? {
        didSet {
            self.updateViews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userImageView.layer.cornerRadius = 25
    }
    
    func updateViews() {
        guard let user = user else { return }
        
        userImageView.image = UIImage(data: user.profilePhoto ?? Data())
        userNameLabel.text = user.name
    }
}
