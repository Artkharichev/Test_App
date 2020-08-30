//
//  SearchTableViewController.swift
//  Test_App
//
//  Created by Артём Харичев on 27.08.2020.
//  Copyright © 2020 Артём Харичев. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController {

    @IBOutlet var userSearchBar: UISearchBar!
    
    var users: [UserInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userSearchBar.searchBarStyle = .minimal
        userSearchBar.placeholder = "GitHub user search"
        
        NetworkManager.fetchUserData { result in

            switch result {
            case .success(let user):
                self.users.append(user)
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }

        }
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SearchTableViewCell

        let user = users[indexPath.row]
        cell.configure(with: user)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            
            let user = users[indexPath.row]
            
            let detailVC = segue.destination as! DetailTableViewController
            
            detailVC.currentUser = user
    
        }
    }
}

extension SearchTableViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let query = userSearchBar.text {
                    print(query)
        }

    }
    
    
}
