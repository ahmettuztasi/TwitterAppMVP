//
//  Repository.swift
//  TwitterAppMVP
//
//  Created by KO on 24/09/2019.
//  Copyright © 2019 Ahmet Tuztașı. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class UserService {
        
    var iUserService: IUserService?
    
    init(iUserService: IUserService) {
        self.iUserService = iUserService
    }
    
    func getUser(baseUrl: String, method: HTTPMethod, header: Dictionary<String, String>, body: Any?, paremeters: [String:Any]?) {
        
        request(baseUrl, method: method, parameters: paremeters, encoding: JSONEncoding.default, headers: header).responseJSON{ response in
            
            switch response.result {
            case .success( _): do {
                if response.data == nil {
                } else {
                    self.iUserService?.onUserResponse(response: response.data!)
                    self.iUserService?.onUserError(message: true)
                }
                }
                
            case .failure( _): do { // throw exception, catch tweet presenter and send tweetView
                do {
                    self.iUserService?.onUserError(message: false)
                } catch let error as NSError {
                    print(error)
                }
                }
            }
        }
    }
    
    func changeUserInfo(baseUrl: String, method: HTTPMethod, header: Dictionary<String, String>, body: Any?, paremeters: [String:Any]?) {
        
        request(baseUrl, method: method, parameters: paremeters, encoding: JSONEncoding.default, headers: header).responseJSON{ response in
            
            switch response.result {
            case .success( _): do {
                if response.data == nil {
                } else {
                    self.iUserService?.onChangeUserResponse(response: response.data!)
                    self.iUserService?.onUserError(message: true)
                }
                }
                
            case .failure( _): do {
                do {
                    self.iUserService?.onUserError(message: false)
                } catch let error as NSError {
                    print(error)
                }
                }
            }
        }
    }
}

