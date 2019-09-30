//
//  UserPresenter.swift
//  TwitterAppMVP
//
//  Created by KO on 24/09/2019.
//  Copyright © 2019 Ahmet Tuztașı. All rights reserved.
//

import Foundation

class UserPresenter {
    
    private var iUserPresenter: IUserPresenter?
    weak private var userService: UserService?
    
    
    init(delegate: IUserPresenter) {
        self.iUserPresenter = delegate
    }
    
    func getUserById(userId: Int) {
        let userService = UserService(iUserService: self)
        let headers = ["Content-Type":"application/json"]
        userService.getUser(baseUrl: "http://localhost:8081/users/\(userId)", method: .get, header: headers, body: nil, paremeters: nil)
    }
    
    func saveUserInfo(userId: Int, userName: String, fullName: String){
        saveUserService(userId: userId, fullName: fullName, userName: userName)
    }
    
    // Check user by userId
    func checkUserId(id: Int?) throws -> Bool {
        if id == nil {
            //throw Check.Id(errmsg: "User'a ait tweet bulunamadı")
        }
        return true
    }
    
    func saveUserService(userId: Int, fullName: String, userName: String) {
        let userService = UserService(iUserService: self)
        let tweetService = TweetService(iTweetService: self)
        
        let headers = ["Content-Type":"application/json"]
        
        userService.changeUserInfo(baseUrl: "http://localhost:8081/updateuserintweets/\(userId)/\(fullName)", method: .get, header: headers, body: nil, paremeters: nil)
        do {
            try tweetService.changeTweetInfo(baseUrl: "http://localhost:8081/updateuserinusers/\(userId)/\(fullName)/\(userName)", method: .get, header: headers, body: nil, paremeters: nil)
        } catch ServiceError.Failure() {
            print("Servise baglanilamadi")
        } catch {
              
        }
        
    }
}

extension UserPresenter: IUserService {
    
    func onChangeUserResponse(response: Data) {
        do{
            let responseModel = try JSONDecoder().decode(User.self, from: response)
            iUserPresenter?.onUserResolved(user: responseModel)
            iUserPresenter?.onError(message: true)
        } catch {
            iUserPresenter?.onError(message: false)
        }
    }
    
    func onUserResponse(response: Data) {
        do{
            let responseModel = try JSONDecoder().decode(User.self, from: response)
            iUserPresenter?.onUserResolved(user: responseModel)
        } catch {
        }
    }
    
    func onUserError(message: Bool) {
        if message {
            iUserPresenter?.onError(message: true)
        }else {
            iUserPresenter?.onError(message: false)
        }
    }
}

extension UserPresenter: ITweetService {
    func onTweetError(message: Bool) {
        if message {
            iUserPresenter?.onError(message: true)
        }else {
            iUserPresenter?.onError(message: false)
        }
    }

    func onChangeTweetResponse(response: Data) {
        return
    }
    
    func onTweetListResponse(response: Data) {
    }
    
    
}
