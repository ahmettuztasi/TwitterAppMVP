//
//  User.swift
//  TwitterAppMVP
//
//  Created by KO on 24/09/2019.
//  Copyright © 2019 Ahmet Tuztașı. All rights reserved.
//

class User:  Decodable {
    
    //MARK: Properties
    
    let id: Int
    let fullName: String
    let profile: String
    let profileImgUrl: String
    let age: Int
    
    //MARK: Initialization
    
    init(id: Int, fullName: String, profile: String, profileImgUrl: String, age: Int) {
        
        // Initialize stored properties.
        self.id = id
        self.fullName = fullName
        self.profile = profile
        self.profileImgUrl = profileImgUrl
        self.age = age
    }
}
