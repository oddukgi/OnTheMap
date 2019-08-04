//
//  UserDataResponse.swift
//  OnTheMap
//
//  Created by 강선미 on 03/08/2019.
//  Copyright © 2019 Yoshimi. All rights reserved.
//

import Foundation

struct UserData: Codable {
    let firstName: String
    let lastName: String
    let key: String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case key
    }
}
//struct UserData: Codable {
//    let user: User
//}
