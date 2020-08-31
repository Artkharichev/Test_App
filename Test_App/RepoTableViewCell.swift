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
    
    func configure(with repo: Repo) {
        repoName.text = repo.name ?? "No repos"
        language.text = repo.language ?? "No info"
        dateUpdate.text = convertDate(from: repo.updated_at ?? "No date")
        stars.text = "Stars: \(repo.stargazers_count)"
    }
    
    func convertDate(from string: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        
        guard let date: Date  = dateFormatterGet.date(from: string) else { return "No date"}

        return dateFormatterPrint.string(from: date)
    }
}

