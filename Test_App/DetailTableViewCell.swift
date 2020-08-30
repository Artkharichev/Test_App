//
//  DetailTableViewCell.swift
//  Test_App
//
//  Created by Артём Харичев on 27.08.2020.
//  Copyright © 2020 Артём Харичев. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet var userImage: ImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var userLogin: UILabel!
    @IBOutlet var userDate: UILabel!
    @IBOutlet var userLocation: UILabel!
    
    func configure(with user: UserInfo) {
        userName.text = user.name ?? "No name"
        userLogin.text = "Login: \(user.login)"
        userDate.text = "Created: \(user.created_at ?? "No info")"
        userLocation.text = "City: \(user.location ?? "No info")"
        userImage.fetchImage(with: user.avatar_url)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userImage.layer.cornerRadius = userImage.frame.width / 2
    }
    
}
