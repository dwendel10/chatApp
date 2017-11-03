//
//  WelcomeViewController.swift
//  Flash Chat
//
//  This is the welcome view controller - the first thign the user sees
//

import UIKit
import Firebase
import FirebaseAuth
import SVProgressHUD


class WelcomeViewController: UIViewController {

    //Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        //Check if email or password are empty
        guard let email = emailTextField.text, let password = passwordTextField.text else{return}
        
        //Create new user
        SVProgressHUD.show()
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error != nil{
                print(error!)
            } else {
                self.performSegue(withIdentifier: "goToChat", sender: self)
            }
            SVProgressHUD.dismiss()
        }
    }
    
    

    
}
