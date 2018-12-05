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
        guard let user = user,
            let imageData = user.profilePhoto else { return }
        
        userImageView.image = UIImage(data: imageData)
        userNameLabel.text = user.name
    }
}
