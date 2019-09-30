//
//  PUserPresenter.swift
//  TwitterAppMVP
//
//  Created by KO on 24/09/2019.
//  Copyright © 2019 Ahmet Tuztașı. All rights reserved.
//

import Foundation

protocol IUserPresenter: NSObjectProtocol {
    func onUserResolved(user: User)
    func onError(message: Bool)
}
