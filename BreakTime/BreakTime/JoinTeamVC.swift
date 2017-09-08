//
//  JoinTeamVC.swift
//  BreakTime
//
//  Created by Kishore Kankata on 9/7/17.
//  Copyright © 2017 RBA. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import CoreLocation
import MapKit

class JoinTeamVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var gameTitleString: String = ""
    var locationManager = CLLocationManager()
    
    @IBOutlet var tableView: UITableView!
    var teamArray : [[String : Any]] = Array()
    var keysArray : [String] = Array()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        gameTitle.text = gameTitleString
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        updateLocation()
        getTeamsList()
    }
    
    func updateLocation() {
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        locationManager.delegate=self;
        locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        locationManager.distanceFilter=kCLDistanceFilterNone;
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.startUpdatingLocation()
        var geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(locationManager.location!, completionHandler: {(placemarks, error)->Void in
            self.activityIndicator.stopAnimating()
            self.location.text = placemarks?[0].name
            print("Location: \(placemarks)")
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:BTTeamCell = tableView.dequeueReusableCell(withIdentifier: "teamsCell")! as! BTTeamCell
        let team = teamArray[indexPath.row]
        cell.teamNameLBL.text = team["teamName"] as? String
        var teamMembers : [[String : String]] = Array()
        if team["teamMembers"] != nil {
            teamMembers = team["teamMembers"] as! [[String : String]]
        }
        cell.numberOfTeamLBL.text = "\(teamMembers.count)/\(team["teamSize"] as! String)"
        cell.joinButton.tag = indexPath.row
        cell.inProgressLBL.text = team["location"] as? String
        cell.joinButton.addTarget(self, action: #selector(joinClicked), for: .touchUpInside)
        
        var userNumbers : [String] = Array()
        for user in teamMembers{
            userNumbers.append(user["mobile"]!)
        }
        
        let defaults = UserDefaults.standard
        let details = defaults.value(forKey: "userDetails") as! Dictionary<String, String>
        let mobileNumber = details["mobileNumber"]!
        
        if userNumbers.contains(mobileNumber){
            cell.joinButton.setTitle("Joined", for: .normal)
            cell.joinButton.isUserInteractionEnabled = false
        }
        else{
            cell.joinButton.setTitle("Join", for: .normal)
            cell.joinButton.isUserInteractionEnabled = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard.init(name: "Cricket", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "TeamListID") as! TeamList
        vc.isCreater = false
        vc.selUid = self.keysArray[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getTeamsList() {
        let ref: DatabaseReference = Database.database().reference()
        ref.child("CreateTeam").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            
            if (value?.allKeys.count)! > 0{
                print(value as Any)
                //self.keysArray = value?.allKeys as! [String]
                let teams = value?.allValues as! [[String : Any]]
                let keys = value?.allKeys as! [String]
                self.teamArray.removeAll()
                self.keysArray.removeAll()
                var count = 0
                for team in teams {
                    if team["gameTitle"] as! String == self.gameTitleString {
                        self.teamArray.append(team)
                        self.keysArray.append(keys[count])
                    }
                    
                    count += 1
                }
            }
            self.tableView.reloadData()
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    @IBAction func joinClicked(_ sender: UIButton) {
        let team = teamArray[sender.tag]
        var teamMembers = team["teamMembers"] as! [[String : String]]
        let defaults = UserDefaults.standard
        let details = defaults.value(forKey: "userDetails") as! Dictionary<String, String>
        let userName = details["userName"]!
        let mobileNumber = details["mobileNumber"]!
        let user = ["name" : userName, "mobile" : mobileNumber]
        teamMembers.append(user)
        let uid = keysArray[sender.tag]
        Database.database().reference().root.child("CreateTeam").child(uid).updateChildValues(["teamMembers": teamMembers])
        getTeamsList()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }

}

class BTTeamCell: UITableViewCell {
    @IBOutlet var teamNameLBL: UILabel!
    @IBOutlet var inProgressLBL: UILabel!
    @IBOutlet var numberOfTeamLBL: UILabel!
    @IBOutlet var joinButton: UIButton!
    
}
