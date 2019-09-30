//
//  PTweetPresenter.swift
//  TwitterAppMVP
//
//  Created by KO on 24/09/2019.
//  Copyright © 2019 Ahmet Tuztașı. All rights reserved.
//

import Foundation

protocol ITweetPresenter: NSObjectProtocol {
    func onTweetResolved(tweetList: [Tweet])
    func onError(message: Bool)
}
