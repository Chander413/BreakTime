//
//  TeamList.swift
//  BreakTime
//
//  Created by Kishore Kankata on 9/7/17.
//  Copyright © 2017 RBA. All rights reserved.
//

import UIKit

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
class usersCell: UITableViewCell {
    
    @IBOutlet weak var userNameLabel: UILabel!
}
