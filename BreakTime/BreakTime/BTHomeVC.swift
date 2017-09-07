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
    var sectionHeadingsArray : [String] = ["Indoor", "Outdoor"]
    var sectionIndoor : [String] = ["Carroms", "Chess", "Snakes & Laders"]
    var sectionOutdoor : [String] = ["Cricket"]
    var selectedGame : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let fView = UIView()
        tableView.tableFooterView = fView
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return sectionIndoor.count
        } else {
            return sectionOutdoor.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        let headerTitle = sectionHeadingsArray[section]
//        return headerTitle.uppercased()
//    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewHeader = UIView()
        viewHeader.backgroundColor = UIColor.lightGray
        
        let headerTitle = UILabel()
        headerTitle.frame = CGRect(x: 0 , y: 15, width: tableView.frame.width, height: 21)
        let title = sectionHeadingsArray[section]
        headerTitle.text = title.uppercased()
        headerTitle.textAlignment = .center
        viewHeader.addSubview(headerTitle)
        return viewHeader
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        if indexPath.section == 0 {
            cell.textLabel?.text = sectionIndoor[indexPath.row]
        } else {
            cell.textLabel?.text = sectionOutdoor[indexPath.row]
        }
        cell.selectionStyle = .none
      return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            selectedGame = sectionIndoor[indexPath.row]
        } else {
            selectedGame = sectionOutdoor[indexPath.row]
        }
        
    showAlertView( title: "\(selectedGame)", controller: self)
    }
    
    
    func showAlertView( title: String , controller : UIViewController)->Void {
        
    let alertController = UIAlertController(title: title, message:
        "", preferredStyle: UIAlertControllerStyle.alert)
    for i in ["Create Team", "Join Team", "Cancel"] {
        alertController.addAction(UIAlertAction(title: i, style: .default, handler: doSomething))
    }
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
