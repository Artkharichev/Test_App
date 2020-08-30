//
//  SearchTableViewCell.swift
//  Test_App
//
//  Created by Артём Харичев on 27.08.2020.
//  Copyright © 2020 Артём Харичев. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet var imageUser: ImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var userType: UILabel!
    
    func configure(with user: UserInfo) {
        userName.text = user.login
        userType.text = user.type
        imageUser.fetchImage(with: user.avatar_url)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageUser.layer.cornerRadius = imageUser.frame.width / 2
    }

}
