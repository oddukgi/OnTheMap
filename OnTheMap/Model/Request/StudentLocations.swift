//
//  StudentLocations.swift
//  OnTheMap
//
//  Created by 강선미 on 25/07/2019.
//  Copyright © 2019 Yoshimi. All rights reserved.
//

import Foundation

struct StudentLocations: Codable {
    
    let results: [StudentLocation]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}

class StudentsLocationData {
    
    static var studentsData = [StudentLocation]()
 
}

