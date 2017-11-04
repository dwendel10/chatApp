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

        if email == "" || password == ""{
            let alert = UIAlertController(title: "Oops!", message: " Enter email and password😁", preferredStyle: .alert)
            let alertSheet = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(alertSheet)
            present(alert, animated: true, completion: nil)
        
        }
        else{
            
            //Create new user
            SVProgressHUD.show()
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                if error != nil{
                    if let errorCode = AuthErrorCode(rawValue: error!._code){
                        switch errorCode {
                            //Check if the email is already in use by another user.
                        case .emailAlreadyInUse:
                            let alert = UIAlertController(title: "Oops!", message: "This email is in use.", preferredStyle: .alert)
                            let alertSheet = UIAlertAction(title: "OK", style: .default, handler: nil)
                            alert.addAction(alertSheet)
                            self.present(alert, animated: true, completion: nil)
                        default: print("DEFAULT")
                        }
                    }
                    print("THIS IS YOUR ERROR: ",error!)
                } else {
                    self.performSegue(withIdentifier: "goToChat", sender: self)
                }
                SVProgressHUD.dismiss()
            }
        }
        
       
    }
    
    

    
}
