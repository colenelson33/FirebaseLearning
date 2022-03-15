//
//  HomeViewController.swift
//  LawnServicePro
//
//  Created by 90304588 on 2/28/22.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth


class HomeViewController: UIViewController {


    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var signoutButton: UIButton!
    
    
    override func viewDidLoad() {
        setUpElements()
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        let userID = Auth.auth().currentUser?.uid
        ref.child("users/\(String(describing: userID))/firstname").getData { error, FIRDataSnapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return;
              }
            let firstName = FIRDataSnapshot.value as? String ?? "Unknown";
            self.welcomeLabel.text = "Welcome, " + firstName
        }
        
        func parseJSON(_ data:Data) {
                
                var jsonResult = NSArray()
                
                do{
                    jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
                    
                } catch let error as NSError {
                    print(error)
                    
                }
                
                var jsonElement = NSDictionary()
                //let locations = NSMutableArray()
                
                for i in 0 ..< jsonResult.count
                {
                    
                    jsonElement = jsonResult[i] as! NSDictionary
                    
                  //  let currentUser = User()

                    
                    //the following insures none of the JsonElement values are nil through optional binding
                  /*  if let firstname = jsonElement["firstname"] as? String,
                        let lastname = jsonElement["lastname"] as? String,
                        let id = jsonElement["uid"] as? String
                    {
                        
                        currentUser.firstName = firstname
                        currentUser.lastName = lastname
                        currentUser.userID = id
                    }
                    */
                    //locations.add(location)
                    
                }
        }
        
        
        
        
        
        

        // Do any additional setup after loading the view.
        
        
    }
    func setUpElements(){
        Utilities.styleFilledButton(signoutButton)
    }
    @IBAction func signoutTapped(_ sender: Any) {
        let signUp = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homePageViewController) as? ViewController
        
        self.view.window?.rootViewController = signUp
        self.view.window?.makeKeyAndVisible()
            
            
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
