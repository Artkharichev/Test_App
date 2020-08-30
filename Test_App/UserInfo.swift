//
//  User.swift
//  Test_App
//
//  Created by Артём Харичев on 27.08.2020.
//  Copyright © 2020 Артём Харичев. All rights reserved.
//

import Foundation

struct SearchResult: Decodable {
    var items: [User]
    var total_count: Int
}

struct UserInfo: Decodable {
    
    let login: String
    let avatar_url: String
    let name: String?
    let created_at: String?
    let location: String?
    let public_repos: Int
}

struct Repo: Decodable {

    let name: String?
    let language: String?
    let updated_at: String?
    let stargazers_count: Int
}

struct User: Decodable {
    
    let login: String
    let avatar_url: String
    let type: String
}

