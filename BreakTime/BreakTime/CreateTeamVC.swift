//
//  CreateTeamVC.swift
//  BreakTime
//
//  Created by Kishore Kankata on 9/7/17.
//  Copyright © 2017 RBA. All rights reserved.
//

import UIKit

class CreateTeamVC: UIViewController {

    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var teamName: UITextField!
    @IBOutlet weak var teamSize: UITextField!
    @IBOutlet weak var createTeamButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func creatTeamAction(_ sender: Any) {
        if teamSize.text != "" && teamName.text != "" {
            
            let storyBoard = UIStoryboard.init(name: "Cricket", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "TeamListID") as! TeamList
            vc.isCreater = true
            vc.gameName = gameTitle.text!
            vc.teamName = teamName.text!
            vc.teamSize = Int(teamSize.text!)!
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
       
    }

    /*
    // MARK: - Navigation

     
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
