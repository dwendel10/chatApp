//
//  RegisterViewController.swift
//  Chat On
//
//  Created by Daniel Wendel on 10/30/17.
//  Copyright © 2017 Daniel Wendel. All rights reserved.
//

import UIKit
import FirebaseAuth
import SVProgressHUD


class LoginViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else{return}
        if email == "" || password == ""{
            let alert = UIAlertController(title: "Oops!", message: " Enter email and password😁", preferredStyle: .alert)
            let alertSheet = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(alertSheet)
            present(alert, animated: true, completion: nil)
            
        } else{
            
            SVProgressHUD.show()
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if error != nil {
                    if let errorCode = AuthErrorCode(rawValue: error!._code){
                        switch errorCode {
                            //checking if the password is incorrect
                        case .wrongPassword:
                            let alert = UIAlertController(title: "Oops!", message: "The email and password do not match, try again 🙃", preferredStyle: .alert)
                            let alertSheet = UIAlertAction(title: "OK", style: .default, handler: nil)
                            alert.addAction(alertSheet)
                            self.present(alert, animated: true, completion: nil)
                            //checking it the users email is in the database.
                        case .userNotFound:
                            let alert = UIAlertController(title: "Oops!", message: "🤔...The email entered is not found, try another one?", preferredStyle: .alert)
                            let alertSheet = UIAlertAction(title: "OK", style: .default, handler: nil)
                            alert.addAction(alertSheet)
                            self.present(alert, animated: true, completion: nil)
                            
                        default: print("DEFAULT")
                        }
                    }
                } else {
                    self.performSegue(withIdentifier: "goToChat" , sender: self)
                }
                SVProgressHUD.dismiss()
            }
        }
    }
    
    
}
