//
//  TweetPresenter.swift
//  TwitterAppMVP
//
//  Created by KO on 24/09/2019.
//  Copyright © 2019 Ahmet Tuztașı. All rights reserved.
//

import Foundation

class TweetPresenter {
    private var iTweetPresenter: ITweetPresenter?
    
    init(delegate: ITweetPresenter) {
        self.iTweetPresenter = delegate
    }
    
    // Get all tweets in server
    func getTweets() {
        let tweetService = TweetService(iTweetService: self)
        let headers = ["Content-Type":"application/json"]
        do {
           try tweetService.getTweetList(baseUrl: "http://localhost:8081/tweets", method: .get, header: headers, body: nil, paremeters: nil)
        } catch ServiceError.Failure() {
            
        } catch {
            
        }
    }
}

extension TweetPresenter: ITweetService {
    func onTweetError(message: Bool) {
        if message {
            iTweetPresenter?.onError(message: true)
        }else {
            iTweetPresenter?.onError(message: false)
        }
    }
    
    func onChangeTweetResponse(response: Data) {
        return
    }
    
    func onTweetListResponse(response: Data) {
        do{
            let responseModel = try JSONDecoder().decode([Tweet].self, from: response)
            iTweetPresenter?.onTweetResolved(tweetList: responseModel)
         
        } catch {
        }
    }
}
