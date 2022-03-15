//
//  LogInViewController.swift
//  LawnServicePro
//
//  Created by 90304588 on 2/28/22.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    /*
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    */
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()

        // Do any additional setup after loading the view.
    }
    func setUpElements(){
        
        //hide error label
        
        errorLabel.alpha = 0
        
        Utilities.styleTextField(usernameField)
        Utilities.styleTextField(passwordField)
        Utilities.styleFilledButton(loginButton)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func loginAction(_ sender: Any) {
        //validate test fields TODO
        let email = usernameField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        //signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil{
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }else{
                let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
                
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
            }
        }
    }
    
    
}
