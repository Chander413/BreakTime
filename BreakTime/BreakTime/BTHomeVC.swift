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
    var sectionOutdoor : [String] = ["Shuttle", ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionHeadingsArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Trendy"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
      return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
