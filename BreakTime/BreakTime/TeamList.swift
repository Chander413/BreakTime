//
//  TeamList.swift
//  BreakTime
//
//  Created by Kishore Kankata on 9/7/17.
//  Copyright © 2017 RBA. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class TeamList: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var isCreater: Bool = false
    var gameName: String = ""
    var teamName: String = ""
    var teamSize: Int = 0
    var joinedMembers: Int = 1
    var users: [String] = ["You"]
    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var teamSizeCount: UILabel!
    @IBOutlet weak var usersTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllTeamMembers()
        gameTitle.text = gameName
        teamNameLabel.text = teamName
        teamSizeCount.text = "\(joinedMembers)/\(teamSize)"
        
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamsCell", for: indexPath) as! usersCell
        cell.userNameLabel.text = users[indexPath.row]
        return cell
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func getAllTeamMembers() {
        let ref: DatabaseReference = Database.database().reference()
        ref.child("CreateTeam").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            
            //            let messages = value?.allValues.filter({ (messageDict) -> Bool in
            //                return true
            //            })
            if (value?.allKeys.count)! > 0{
                print(value as Any)
                let user = Auth.auth().currentUser
                var data : [String : Any] = Dictionary()
                if value?[user?.uid as Any] != nil{
                   data = value?.value(forKey: (user?.uid)!) as! [String : Any]
                }
            }
            //self.tableView.reloadData()
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
    }

}
class usersCell: UITableViewCell {
    
    @IBOutlet weak var userNameLabel: UILabel!
}
