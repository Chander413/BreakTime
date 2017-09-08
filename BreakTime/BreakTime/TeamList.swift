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
    var users: [[String : String]] = Array()
    var selUid : String = ""
    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var teamSizeCount: UILabel!
    @IBOutlet weak var usersTableView: UITableView!
    @IBOutlet weak var locationLBL: UILabel!
    @IBOutlet weak var timeLBL: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        gameTitle.text = gameName
//        teamNameLabel.text = teamName
//        teamSizeCount.text = "\(joinedMembers)/\(teamSize)"
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getSelectedTeamDetails()
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamsCell", for: indexPath) as! usersCell
        let user = users[indexPath.row]
        
        cell.userNameLabel.text = user["name"]
        cell.mobileNumberLBL.text = user["mobile"]
        return cell
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getSelectedTeamDetails() {
        let ref: DatabaseReference = Database.database().reference()
        ref.child("CreateTeam").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary

            if (value?.allKeys.count)! > 0{
                print(value as Any)
                var data : [String : Any] = Dictionary()
                if value?[self.selUid] != nil{
                    data = value?.value(forKey: self.selUid) as! [String : Any]
                    self.gameTitle.text = data["gameTitle"] as? String
                    self.teamNameLabel.text = data["teamName"] as? String
                    self.timeLBL.text = data["time"] as? String
                    self.locationLBL.text = data["location"] as? String
                    if data["teamMembers"] != nil {
                        let teamMembers = data["teamMembers"] as! [[String : String]]
                        self.users = teamMembers
                    }
                    self.teamSizeCount.text = "\(self.users.count)/\(data["teamSize"] as! String)"
                    
                }
            }
            self.usersTableView.reloadData()
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func leaveTeamButtonAction(_ sender: Any) {
        let defaults = UserDefaults.standard
        let details = defaults.value(forKey: "userDetails") as! Dictionary<String, String>
        let mobileNumber = details["mobileNumber"]!
        var count = 0
        
        for user in self.users{
            if user["mobile"] == mobileNumber{
                self.users.remove(at: count)
                count -= 1
            }
            count += 1
        }
        
        Database.database().reference().root.child("CreateTeam").child(selUid).updateChildValues(["teamMembers": self.users])
        getSelectedTeamDetails()
    }

}
class usersCell: UITableViewCell {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet var mobileNumberLBL: UILabel!
}
