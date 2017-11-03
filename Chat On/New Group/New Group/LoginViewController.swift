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
        SVProgressHUD.show()
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print(error!)
            } else {
                self.performSegue(withIdentifier: "goToChat" , sender: self)
            }
            SVProgressHUD.dismiss()
        }
    }
    

}
