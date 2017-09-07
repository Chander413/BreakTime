//
//  BTSignUPVC.swift
//  BreakTime
//
//  Created by chander on 07/09/17.
//  Copyright © 2017 RBA. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage

class BTSignUPVC: UIViewController {

    @IBOutlet var fullNameTF: UITextField!
    @IBOutlet var mobileNumberTF: UITextField!
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerButtonAction(_ sender: Any) {
        if emailTF.hasText && passwordTF.hasText && mobileNumberTF.hasText && fullNameTF.hasText{
            Auth.auth().createUser(withEmail: emailTF.text!, password: passwordTF.text!) { (user, error) in
                // ...
                if((error) != nil) {
                    print(error?.localizedDescription as Any)
                    
                } else {
                    print(user as Any)
                    
                    let storageRef = Storage.storage().reference().child("userDetails").child(user!.uid)
                    let dataDict = ["userName" : self.fullNameTF.text!, "mobileNumber" : self.mobileNumberTF.text!]
                    let data : Data = NSKeyedArchiver.archivedData(withRootObject: dataDict)
                    storageRef.putData(data)
                    
                    let storyBoard = UIStoryboard(name: "Home", bundle: nil)
                    let homeVC = storyBoard.instantiateInitialViewController() as! BTHomeVC
                    self.navigationController?.pushViewController(homeVC, animated: true)
                }
            }
        }
        else{
            
            let alertController = UIAlertController(title: "BreakTime", message:
                "Please enter all fields.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: { (action: UIAlertAction!) in
                
                
            }))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }

    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
