//
//  ITweetService.swift
//  TwitterAppMVP
//
//  Created by KO on 26/09/2019.
//  Copyright © 2019 Ahmet Tuztașı. All rights reserved.
//

import Foundation

protocol ITweetService: IService {
    func onTweetListResponse(response: Data)
    func onChangeTweetResponse(response: Data)
    func onTweetError(message: Bool)
}
