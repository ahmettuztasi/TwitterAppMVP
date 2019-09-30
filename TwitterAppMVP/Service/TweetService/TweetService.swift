//
//  TweetService.swift
//  TwitterAppMVP
//
//  Created by KO on 26/09/2019.
//  Copyright © 2019 Ahmet Tuztașı. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class TweetService {
    
    // Tweet Service Delegate
    var iTweetService: ITweetService?
    
    // MARK: Initialization
    init(iTweetService: ITweetService) {
        self.iTweetService = iTweetService
    }
    
    // Get All Tweets
    func getTweetList(baseUrl: String, method: HTTPMethod, header: Dictionary<String, String>, body: Any?, paremeters: [String:Any]?) throws {
        request(baseUrl, method: method, parameters: paremeters, encoding: JSONEncoding.default, headers: header).responseJSON { response in
            
            switch response.result {
            case .success( _): do {
                if(response.data == nil) {
                } else {
                    self.iTweetService?.onTweetListResponse(response: response.data!)
                    self.iTweetService?.onTweetError(message: true)
                }
                }
                
            case .failure( _): do { // throw exception, catch tweet presenter and send tweetView
                
                do {
                    self.iTweetService?.onTweetError(message: false)
                } catch let error as NSError {
                    print(error)
                }
                }
            }
        }
    }
    
    // Change Tweet Information
    func changeTweetInfo(baseUrl: String, method: HTTPMethod, header: Dictionary<String, String>, body: Any?, paremeters: [String:Any]?) throws {
        
        request(baseUrl, method: method, parameters: paremeters, encoding: JSONEncoding.default, headers: header).responseJSON{ response in
            
            switch response.result {
            case .success( _): do {
                if response.data == nil {
                } else {
                    self.iTweetService?.onChangeTweetResponse(response: response.data!)
                }
                }
                
            case .failure( _): do { // throw exception, catch tweet presenter and send tweetView
                do {
                    throw ServiceError.Failure()
                } catch let error as NSError {
                    print(error)
                }
                }
            }
        }
    }
}

