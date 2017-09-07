//
//  BTHomeVC.swift
//  BreakTime
//
//  Created by Gopala Krishna Kammela on 07/09/17.
//  Copyright © 2017 RBA. All rights reserved.
//

import Foundation
import UIKit

class BTHomeVC: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var sectionHeadingsArray : [String] = ["Outdoor Games", "Indoor Games"]
    var sectionIndoor : [String] = ["Carroms", "Chess", "Snakes & Laders","Asta-Chemma"]
    var sectionOutdoor : [String] = ["Cricket","Volley Ball","Foot Ball","Badminton"]
    var selectedGame : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let fView = UIView()
        tableView.tableFooterView = fView
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return sectionOutdoor.count
        } else {
            return sectionIndoor.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewHeader = UIView()
        viewHeader.backgroundColor = UIColor.red
        //        viewHeader.layer.opacity = 0.5
        
        let headerTitle = UILabel()
        headerTitle.frame = CGRect(x: 15 , y: 3, width: tableView.frame.width, height: 30)
        let title = sectionHeadingsArray[section]
        headerTitle.text = title.capitalized
        headerTitle.textAlignment = .left
        headerTitle.font = UIFont(name: "Gill Sans - Regular", size: 17)
        headerTitle.textColor = UIColor.white
        viewHeader.addSubview(headerTitle)
        return viewHeader
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        if indexPath.section == 0 {
            cell.textLabel?.text = sectionOutdoor[indexPath.row]
        } else {
            cell.textLabel?.text = sectionIndoor[indexPath.row]
        }
        cell.selectionStyle = .none
      return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            selectedGame = sectionOutdoor[indexPath.row]
        } else {
            selectedGame = sectionIndoor[indexPath.row]
        }
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
