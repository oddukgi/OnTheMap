//
//  PostLocationResponse.swift
//  OnTheMap
//
//  Created by 강선미 on 04/08/2019.
//  Copyright © 2019 Yoshimi. All rights reserved.
//

import Foundation

//    "updatedAt":"2015-03-11T02:56:49.997Z"

struct PostLocationResponse: Codable {
    let createAt: String
    let objectId: String
    
    enum CodingKeys: String, CodingKey {
        case createAt
        case objectId
    }
}
