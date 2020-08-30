//
//  RepoTableViewCell.swift
//  Test_App
//
//  Created by Артём Харичев on 29.08.2020.
//  Copyright © 2020 Артём Харичев. All rights reserved.
//

import UIKit

class RepoTableViewCell: UITableViewCell {

    @IBOutlet var repoName: UILabel!
    @IBOutlet var language: UILabel!
    @IBOutlet var stars: UILabel!
    @IBOutlet var dateUpdate: UILabel!
    
    @IBOutlet var showButton: UIButton!
    @IBOutlet var hideButton: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        showButton.isHidden = false
        hideButton.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        showDetailInfo()
    }
    
    func configure(with repo: Repo) {
        repoName.text = repo.name
        language.text = repo.language ?? "No info"
        dateUpdate.text = repo.updated_at
        stars.text = "\(repo.stargazers_count)"
    }
    
    func showDetailInfo() {
        showButton.isHidden.toggle()
        hideButton.isHidden.toggle()
    }
}
