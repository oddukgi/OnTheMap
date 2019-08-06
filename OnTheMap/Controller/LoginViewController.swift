//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by 강선미 on 25/07/2019.
//  Copyright © 2019 Yoshimi. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.emailTextField.becomeFirstResponder()
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.text = ""
        passwordTextField.text = ""

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        
        UdacityClient.login(with: emailTextField.text!, password: passwordTextField.text!, completion: handleLoginResponse(success:error:))
   
    }

    

    func setLoggingIn(_ loggingIn: Bool) {
        if loggingIn {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    func showLoginFailure(message: String) {
        let alertVC = UIAlertController(title: "Login Failed", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(alertVC, sender: nil)
    }
    
    @IBAction func signUpViaWebsite(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://auth.udacity.com/sign-up")!, options: [:], completionHandler: nil)
    }


  func handleLoginResponse(success: Bool, error: Error?){
  
      if success {
          performSegue(withIdentifier: "completeLogin", sender: nil)
          setLoggingIn(true)
      }
      else {
    
         showLoginFailure(message: error?.localizedDescription ?? "Wrong Email or Password!!")
         setLoggingIn(false)
      }
    }
}
