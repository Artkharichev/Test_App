//
//  DetailTableViewController.swift
//  Test_App
//
//  Created by Артём Харичев on 27.08.2020.
//  Copyright © 2020 Артём Харичев. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    var currentUserName: String!
    var currentUser: [UserInfo] = []
    private var isTapped = false
    private var repos: [Repo] = []
    private var selectedIndex = IndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.fetchUserDetail(for: currentUserName) { result in
            
            switch result {
            case .success(let user):
                self.currentUser.append(user)
                self.tableView.reloadData()
            case.failure(let error):
                print(error)
            }
        }
        
        NetworkManager.fetchUserRepoDetail(for: currentUserName) { result in
            switch result {
            case .success(let repos):
                for repo in repos {
                    self.repos.append(repo)
                }
                self.tableView.reloadData()
            case.failure(let error):
                print(error)
            }
        }
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return repos.count + currentUser.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailTableViewCell
            
            let user = currentUser.first!
            cell.configure(with: user)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RepoCell", for: indexPath) as! RepoTableViewCell
            
            let repo = repos[indexPath.row - 1 ]
            cell.configure(with: repo)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedIndex = indexPath
        isTapped.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 150
        } else if indexPath == selectedIndex, isTapped {
            return 150
        } else {
            return 75
        }
    }
}
