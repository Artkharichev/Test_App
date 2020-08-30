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
        
        return URL(string: "https://api.github.com/search/users?q=\(query)&page=\(page)")
    }
    
}
