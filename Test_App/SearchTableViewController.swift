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
    
    var users: [User] = []
    private var searchUsers: SearchResult?
    private var page = 1
    private var query = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userSearchBar.searchBarStyle = .minimal
        userSearchBar.placeholder = "GitHub user search"
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
            
            detailVC.currentUserName = user.login
    
        }
    }
}

// MARK: - Search

extension SearchTableViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let query = userSearchBar.text {
            
            self.query = query
            page = 1
            
            NetworkManager.fetchUsers(with: query, page: self.page) { result in
                
                switch result {
                case .success(let searchResults):
                    
                    self.users.removeAll()
                    
                    
                    for user in searchResults.items {
                        self.users.append(user)
                    }
                    self.page += 1
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
        
        searchBar.resignFirstResponder()
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        userSearchBar.resignFirstResponder()
    }
}

// MARK: - Upload result

extension SearchTableViewController {
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let index = indexPath.row
        if index == users.count - 3 {
            
            NetworkManager.fetchUsers(with: query, page: page) { result in
                
                switch result {
                case .success(let searchResults):
                    
                    if self.checkResultCount(result: searchResults, page: self.page) {
                    
                        for user in searchResults.items {
                            self.users.append(user)
                        }
                        self.page += 1
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    private func checkResultCount(result: SearchResult, page: Int) -> Bool {
        
        let count = result.total_count
        
        if (count / 20) >= (page - 1){
            return true
        } else {
            return false
        }
    }
}
