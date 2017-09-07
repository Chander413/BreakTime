//
//  ViewController.swift
//  BreakTime
//
//  Created by chander on 07/09/17.
//  Copyright © 2017 RBA. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
class ViewController: UIViewController {

    @IBOutlet var emailTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if Auth.auth().currentUser != nil{
            let user = Auth.auth().currentUser
            let storageRef = Storage.storage().reference().child("userDetails").child(user!.uid)
            
            // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
            storageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                if data != nil{
                    // Uh-oh, an error occurred!
                    var dictionary: Dictionary? = NSKeyedUnarchiver.unarchiveObject(with: data!) as? [String : Any]
                    print(dictionary as Any)
                    dictionary?["email"] = user?.email
                    let defaults : UserDefaults = UserDefaults.standard
                    defaults.set(dictionary, forKey: "userDetails")
                    defaults.synchronize()
                } else {
                    // Data for "images/island.jpg" is returned
                }
            }
            gotoHomeScreen(withNavigation: false)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginButtonAction(_ sender: Any) {
        if emailTF.hasText && passwordTF.hasText {
            Auth.auth().signIn(withEmail: emailTF.text!, password: passwordTF.text!) { (user, error) in
                if((error) != nil) {
                    print(error?.localizedDescription as Any)
                    let alertController = UIAlertController(title: "BreakTime", message:
                        error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: { (action: UIAlertAction!) in
                        
                    }))
                    
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    print(user?.email as Any,user?.uid as Any)
                    
                    let storageRef = Storage.storage().reference().child("userDetails").child(user!.uid)
                    
                    // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
                    storageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                        if data != nil{
                            // Uh-oh, an error occurred!
                            var dictionary: Dictionary? = NSKeyedUnarchiver.unarchiveObject(with: data!) as? [String : Any]
                            print(dictionary as Any)
                            dictionary?["email"] = user?.email
                            let defaults : UserDefaults = UserDefaults.standard
                            defaults.set(dictionary, forKey: "userDetails")
                            defaults.synchronize()
                        } else {
                            // Data for "images/island.jpg" is returned
                        }
                    }
                    
                    self.gotoHomeScreen(withNavigation: true)
                }
            }
        }
        else{
            
            let alertController = UIAlertController(title: "BreakTime", message:
                "Please enter email and password.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: { (action: UIAlertAction!) in
                
                
            }))
            
            self.present(alertController, animated: true, completion: nil)
        }
    
    }
    
    func gotoHomeScreen(withNavigation navigation:Bool) {
        let storyBoard = UIStoryboard(name: "Home", bundle: nil)
        let homeVC = storyBoard.instantiateInitialViewController() as! BTHomeVC
        self.navigationController?.pushViewController(homeVC, animated: navigation)
    }
    
    func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    @IBAction func forgotPasswordTF(_ sender: Any) {
    
    }

    @IBAction func registerButtonAction(_ sender: Any) {
        let storyBoardObj = UIStoryboard(name: "Main", bundle: nil)
        let signUPVC = storyBoardObj.instantiateViewController(withIdentifier: "signUPVC") as! BTSignUPVC
        self.navigationController?.pushViewController(signUPVC, animated: true)
    }


}

