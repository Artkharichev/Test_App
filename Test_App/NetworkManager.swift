//
//  NetworkManager.swift
//  Test_App
//
//  Created by Артём Харичев on 27.08.2020.
//  Copyright © 2020 Артём Харичев. All rights reserved.
//

import UIKit

class NetworkManager {
    
    static private let jsonUrl = "https://api.github.com/users/Artkharichev"
    static private let jsonReposUrl = "https://api.github.com/users/Artkharichev/repos"
    
    static func fetchUserData(completion: @escaping (Result<UserInfo, Error>)->()) {
        
         guard let url = URL(string: jsonUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in

            if let error = error {
                print(error.localizedDescription)
                return
            }
        
            guard let data = data else { return }
            
            do {
                let user = try JSONDecoder().decode(UserInfo.self, from: data)


                DispatchQueue.main.async {

                    completion(.success(user))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            
        }.resume()
    }
    
    static func fetchUserReposData(completion: @escaping (Result<[Repo], Error>)->()) {
        
         guard let url = URL(string: jsonReposUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in

            if let error = error {
                print(error.localizedDescription)
                return
            }
        
            guard let data = data else { return }
            
            do {
                let repos = try JSONDecoder().decode([Repo].self, from: data)


                DispatchQueue.main.async {

                    completion(.success(repos))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            
        }.resume()
    }
    
    static func url(for query: String?, page: Int) -> URL? {
        guard let query = query,
            query.isEmpty == false else { return nil }
        
        return URL(string: "https://api.github.com/search/users?q=\(query)&page=\(page)&per_page=15")
    }
    
    static func userUrl(for userName: String?) -> URL? {
        guard let userName = userName,
            userName.isEmpty == false else { return nil }
            return URL(string: "https://api.github.com/users/\(userName)")
    }
    
    static func userRepoUrl(for userName: String?) -> URL? {
        guard let userName = userName,
            userName.isEmpty == false else { return nil }
            return URL(string: "https://api.github.com/users/\(userName)/repos")
    }
    
    static func fetchUsers(
        with query: String?,
        page: Int,
        completion: @escaping (Result<SearchResult, Error>)->()
    ) {
        guard let url = self.url(for: query, page: page) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in

            if let error = error {
                print(error.localizedDescription)
                return
            }
        
            guard let data = data else { return }
            
            do {
                let users = try JSONDecoder().decode(SearchResult.self, from: data)


                DispatchQueue.main.async {

                    completion(.success(users))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            
        }.resume()

    }
    
    
    static func fetchUserDetail(
        for userName: String?,
        completion: @escaping (Result<UserInfo, Error>)->()
    ) {
        guard let url = self.userUrl(for: userName) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in

            if let error = error {
                print(error.localizedDescription)
                return
            }
        
            guard let data = data else { return }
            
            do {
                let user = try JSONDecoder().decode(UserInfo.self, from: data)


                DispatchQueue.main.async {

                    completion(.success(user))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            
        }.resume()
    }
    
    static func fetchUserRepoDetail(
        for userName: String?,
        completion: @escaping (Result<[Repo], Error>)->()
    ) {
        guard let url = self.userRepoUrl(for: userName) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in

            if let error = error {
                print(error.localizedDescription)
                return
            }
        
            guard let data = data else { return }
            
            do {
                let repos = try JSONDecoder().decode([Repo].self, from: data)


                DispatchQueue.main.async {

                    completion(.success(repos))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            
        }.resume()
    }
    
}
