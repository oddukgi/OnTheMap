//
//  API.swift
//  OnTheMap
//
//  Created by 강선미 on 25/07/2019.
//  Copyright © 2019 Yoshimi. All rights reserved.
//

import Foundation

// Reqeust

class UdacityClient {
    struct Auth {
        static var keyAccount = ""
        static var sessionId = ""
    
    }
    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com/v1/"
        
        case createSessionId
        case getStudentLocation
        case postStudentLocation
        case updateStudentLocation(String)
        case getUserData
        case logout
        
        var urlString: String {
            switch self {
                
            case .createSessionId: return Endpoints.base + "session"
            case .getStudentLocation: return Endpoints.base + "StudentLocation?order=-updatedAt&limit=100"
            case .postStudentLocation: return Endpoints.base + "StudentLocation"
            case .updateStudentLocation(let objectID): return Endpoints.base + "StudentLocation/\(objectID)"
            case .getUserData: return Endpoints.base + "users/" + Auth.keyAccount
            case .logout: return Endpoints.base + "session"
            }
            
        }
        
        var url: URL {
            return URL(string: urlString)!
        }
    }
    
    //step 1: login
    class func login(with email: String, password: String, completion: @escaping (Bool, Error?) -> ()){
   
        var request = URLRequest(url: Endpoints.createSessionId.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"udacity\": {\"username\": \"\(email)\", \"password\": \"\(password)\"}}".data(using: .utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    return completion(false, error)
                }
                return
            }
            print("login: \(String(describing: String(data: data, encoding: .utf8)))")
            let range = 5..<data.count
            let newData = data.subdata(in: range)
            let decoder = JSONDecoder()
            do {
                
                let responseObject = try decoder.decode(UserLoginResponse.self, from: newData)
                DispatchQueue.main.async {
                    self.Auth.sessionId = responseObject.session.id
                    self.Auth.keyAccount = responseObject.account.key
                    completion(true, nil)
                }
            }
            catch {
                DispatchQueue.main.async {
                    completion(false, error)
                }
            }
        }
        task.resume()
    }
    
    
    // https://onthemap-api.udacity.com/v1/users/<user_id>
    
    class func getUserData() {
        
    }
}


    

