//
//  ServiceError.swift
//  TwitterAppMVP
//
//  Created by KO on 24/09/2019.
//  Copyright © 2019 Ahmet Tuztașı. All rights reserved.
//

import Foundation

enum ServiceError: Error {
    case Failure()
}

enum Check: Error{
    case Id(errmsg: String)
}
