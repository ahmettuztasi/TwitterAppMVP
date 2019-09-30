//
//  IUserService.swift
//  TwitterAppMVP
//
//  Created by KO on 26/09/2019.
//  Copyright © 2019 Ahmet Tuztașı. All rights reserved.
//

import Foundation

protocol IUserService: IService {
    func onUserResponse(response: Data)
    func onChangeUserResponse(response: Data)
    func onUserError(message: Bool)
}
