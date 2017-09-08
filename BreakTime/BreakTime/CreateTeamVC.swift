//
//  CreateTeamVC.swift
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

class CreateTeamVC: UIViewController,CLLocationManagerDelegate  {

    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var teamName: UITextField!
    @IBOutlet weak var teamSize: UITextField!
    @IBOutlet weak var createTeamButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var gameTitleString: String = ""
    
    var ref: DatabaseReference!
     var locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        let result = formatter.string(from: date)
        time.text = result
        //print("Time is \(result)")
        gameTitle.text = gameTitleString
        ref = Database.database().reference()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        updateLocation()
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
            print("Location: \(placemarks!)")
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func creatTeamAction(_ sender: Any) {
        if teamSize.text != "" && teamName.text != "" {
            
            let defaults = UserDefaults.standard
            let details = defaults.value(forKey: "userDetails") as! Dictionary<String, String>
            let userName = details["userName"]!
            let mobileNumber = details["mobileNumber"]!
            let dataDict : [String : Any] = ["gameTitle" : gameTitle.text!, "teamName" : teamName.text!, "teamSize" : teamSize.text!, "creatorName" : userName, "location" : location.text!, "time" : "12:00 PM", "teamMembers" : [["name" : userName, "mobile" : mobileNumber]]]
            
            let formDataRef = ref.child("CreateTeam")
            //formDataRef.childByAutoId().setValue(dataDict)
            formDataRef.childByAutoId().setValue(dataDict, withCompletionBlock: { (error, result) in
                print("finished saving")
                if let error = error {
                    print(error.localizedDescription)
                }else{
                    let storyBoard = UIStoryboard.init(name: "Cricket", bundle: nil)
                    let vc = storyBoard.instantiateViewController(withIdentifier: "TeamListID") as! TeamList
                    vc.isCreater = true
                    vc.selUid = result.key
                    vc.gameName = self.gameTitle.text!
                    vc.teamName = self.teamName.text!
                    vc.teamSize = Int(self.teamSize.text!)!                    
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            })
        }
        
       
    }

    @IBAction func backButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
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
