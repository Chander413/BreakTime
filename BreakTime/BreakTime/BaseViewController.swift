//
//  BaseViewController.swift
//  BreakTime
//
//  Created by Gopala Krishna Kammela on 08/09/17.
//  Copyright © 2017 RBA. All rights reserved.
//
import Foundation
import UIKit
import FirebaseAuth
import FirebaseStorage

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        
        let button1 = UIButton()
        button1.frame = CGRect(x : self.view.frame.size.width - 50, y : 23, width : 30, height : 30)
        button1.addTarget(self, action: #selector(menuAction), for: .touchUpInside)
        button1.setImage(#imageLiteral(resourceName: "logout"), for: .normal)
        self.view.addSubview(button1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func menuAction(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        self.navigationController?.popToRootViewController(animated: false)
    }
    
    

}
