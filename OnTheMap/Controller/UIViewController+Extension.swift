//
//  UIViewController+Extension.swift
//  OnTheMap
//
//  Created by 강선미 on 27/07/2019.
//  Copyright © 2019 Yoshimi. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    @IBAction func logoutTapped(_ sender: UIBarButtonItem) {
        
        UdacityClient.deleteLoginSession { (success: Bool, error: Error?) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
            
            print(error?.localizedDescription ?? "")
        }
    }
    
    
}
