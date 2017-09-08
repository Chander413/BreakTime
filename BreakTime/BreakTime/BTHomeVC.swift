//
//  BTHomeVC.swift
//  BreakTime
//
//  Created by Gopala Krishna Kammela on 07/09/17.
//  Copyright © 2017 RBA. All rights reserved.
//

import Foundation
import UIKit

class BTHomeVC: BaseViewController , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var indoorGamesButton: UIButton!
    @IBOutlet weak var outdoorGamesButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var sectionHeadingsArray : [String] = ["Outdoor Games", "Indoor Games"]
    var sectionIndoor : [String] = ["Carroms", "Chess", "Snakes & Laders","Asta-Chemma"]
    var sectionOutdoor : [String] = ["Cricket","Volley Ball","Foot Ball","Badminton"]
    var selectedGame : String = ""
    var selectedArray : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let fView = UIView()
        tableView.tableFooterView = fView
        selectedArray = sectionOutdoor
        outdoorGamesButton.backgroundColor = UIColor.init(red: 248/255, green: 12/255, blue: 59/255, alpha: 1.0)
        indoorGamesButton.backgroundColor = UIColor.lightGray
        

    }
    
    
    @IBAction func outdoorOrIndoorSelected(_ sender: Any) {
        if (sender as! UIButton).tag == 1 {
            outdoorGamesButton.backgroundColor = UIColor.init(red: 248/255, green: 12/255, blue: 59/255, alpha: 1.0)
            indoorGamesButton.backgroundColor = UIColor.lightGray
            selectedArray = sectionOutdoor
            tableView.reloadData()
        } else {
            outdoorGamesButton.backgroundColor = UIColor.lightGray
            indoorGamesButton.backgroundColor = UIColor.init(red: 248/255, green: 12/255, blue: 59/255, alpha: 1.0)
            selectedArray = sectionIndoor
            tableView.reloadData()
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return selectedArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell

        cell.textLabel?.text = selectedArray[indexPath.row]
        cell.selectionStyle = .none
      return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedGame = selectedArray[indexPath.row]
        showAlertView( title: "\(selectedGame)", controller: self)
    }
    
    
    func showAlertView( title: String , controller : UIViewController)->Void {
        
        let alertController = UIAlertController(title: title, message:
            "", preferredStyle: UIAlertControllerStyle.alert)
//        for i in ["Create Team", "Join Team", "Cancel"] {
//            alertController.addAction(UIAlertAction(title: i, style: .default, handler: doSomething))
//        }
        
        // Create the actions
        let createAction = UIAlertAction(title: "Create Team", style: UIAlertActionStyle.default) {
            UIAlertAction in
            NSLog("Create Pressed")
            
            let storyBoard = UIStoryboard(name: "Cricket", bundle: nil)
            let cricketVC = storyBoard.instantiateViewController(withIdentifier: "CreateTeamVC") as! CreateTeamVC
            cricketVC.gameTitleString = self.selectedGame
            self.navigationController?.pushViewController(cricketVC, animated: true)
        }
        let joinAction = UIAlertAction(title: "Join Team", style: UIAlertActionStyle.default) {
            UIAlertAction in
            NSLog("Join Pressed")
            
            let storyBoard = UIStoryboard(name: "Cricket", bundle: nil)
            let cricketVC = storyBoard.instantiateViewController(withIdentifier: "JoinTeamVC") as! JoinTeamVC
            cricketVC.gameTitleString = self.selectedGame
    
            self.navigationController?.pushViewController(cricketVC, animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        
        // Add the actions
        alertController.addAction(createAction)
        alertController.addAction(joinAction)
        alertController.addAction(cancelAction)
        
        alertController.view.tintColor = .black
        
        controller.present(alertController, animated: true, completion: nil)
    }
    
    func doSomething(action: UIAlertAction) {
        //Use action.title
        
    }
    @IBAction func myTeamAction(_ sender: Any) {
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
