//
//  TweetModel.swift
//  TwitterAppMVP
//
//  Created by KO on 24/09/2019.
//  Copyright © 2019 Ahmet Tuztașı. All rights reserved.
//

import Foundation

class Tweet:  Decodable {
    
    //MARK: Properties
    
    let userId: Int
    let id: Int
    var fullName: String
    var profile: String
    let profileImgUrl: String
    let tweetText: String
    
    
    //MARK: Initialization
    
    init(userId: Int, id: Int, fullName: String, profile: String, profileImgUrl: String, tweetText: String) {
        
        // Initialize stored properties.
        self.userId = userId
        self.id = id
        self.fullName = fullName
        self.profile = profile
        self.profileImgUrl = profileImgUrl
        self.tweetText = tweetText
    }
}
