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
    // Replaces the reusable cells with this image so the wrong image doesn't appear in the wrong cell
    // Instead it will be our placeholderImg
    override func prepareForReuse() {
        super.prepareForReuse()
        
        userImageView.image = #imageLiteral(resourceName: "placeholderImg")
    }
    
    func updateViews() {
        guard let user = user else { return }
        
        if let imageData = user.profilePhoto {
            userImageView.image = UIImage(data: imageData) ?? #imageLiteral(resourceName: "placeholderImg")
        }
        
        userNameLabel.text = user.name
    }
}
