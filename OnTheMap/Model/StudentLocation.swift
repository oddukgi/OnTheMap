//
//  StudentLocation.swift
//  OnTheMap
//
//  Created by 강선미 on 26/07/2019.
//  Copyright © 2019 Yoshimi. All rights reserved.
//

import Foundation
import MapKit
//"createdAt"
//"firstName"
//"lastName":
//"latitude":
//"longitude"
//"mapString"
//"mediaURL":
//"objectId":
//"uniqueKey"
//"updatedAt"

struct StudentLocation: Codable {
    let createdAt: String
    let firstName: String
    let lastName: String
    let mapString: String
    let mediaURL: String
    let objectId: String
    let uniqueKey: String
    let updatedAt: String
    let latitude: Float
    let longitude: Float
}
