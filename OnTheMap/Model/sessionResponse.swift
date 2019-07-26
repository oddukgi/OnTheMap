//
//  session.swift
//  OnTheMap
//
//  Created by 강선미 on 25/07/2019.
//  Copyright © 2019 Yoshimi. All rights reserved.
//

import Foundation
//{
//    "account":{
//        "registered":true,
//        "key":"3903878747"
//    },
//    "session":{
//        "id":"1457628510Sc18f2ad4cd3fb317fb8e028488694088",
//        "expiration":"2015-05-10T16:48:30.760460Z"
//    }
//}
struct sessionResponse: Codable {
    let account: Account
    let session: infoSession
}

struct Account: Codable {
    let registered: Bool
    let key: String
}

struct infoSession: Codable {
    let id: String
    let expiration: String
}
