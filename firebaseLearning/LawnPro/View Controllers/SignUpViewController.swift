//
//  SignUpViewController.swift
//  LawnServicePro
//
//  Created by 90304588 on 2/28/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements(){
        
        // hide error label
        errorLabel.alpha = 0
        
        //style text fields
        Utilities.styleTextField(firstName)
        Utilities.styleTextField(lastName)
        Utilities.styleTextField(email)
        Utilities.styleTextField(password)
        Utilities.styleFilledButton(signUpButton)
    }
    
    //check fields and validate data is correct, if all is correct return nil, otherwise return error message as string
    func validateFields() -> String?{
        //check all fields filled in
        if firstName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || email.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Please fill in all fields."
        }
        
        // Check if password is secure
        
        if Utilities.isPasswordValid(password.text!.trimmingCharacters(in: .whitespacesAndNewlines)) == false {
            //password is not secure enough
            return "Password is not secure. Russia finna hack you. Make sure it has 8 characters, a special character and a number."
        }
        
        
        return nil
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    @IBAction func signUpTapped(_ sender: Any) {
        //validate fields
        let error = validateFields()
        
        if error != nil{
            //something wrong with fields, show error message
            showError(error!)
            
        }else{
            
        //create cleaned versions of data
            let firstName = firstName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                if err != nil{
                    
                    //there was an error
                    self.showError("Error creating user")
                }else{
                    //user was created, now store first and last name
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["firstname": firstName, "lastname": lastName, "uid": result!.user.uid]) { (error) in
                        if error != nil{
                            self.showError("First or last name was not stored")
                        }
                    }
                    
                    //transition to the home screen
                    self.transitionToHome()
                }
               
            }
        
            
                   
        }
       
    }
    
    func showError(_ message: String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome(){
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }

}
