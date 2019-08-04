//
//  PostLocation.swift
//  OnTheMap
//
//  Created by 강선미 on 03/08/2019.
//  Copyright © 2019 Yoshimi. All rights reserved.
//

import Foundation

struct PostLocation: Codable {
    let uniqueKey: String
    let firstName: String
    let lastName: String
    let mapString: String
    let mediaURL: String
    let latitude: Float
    let longitude: Float
}
