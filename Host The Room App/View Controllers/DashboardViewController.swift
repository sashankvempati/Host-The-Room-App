//
//  DashboardViewController.swift
//  Host The Room App
//
//  Created by Sashank Vempati on 9/9/19.
//  Copyright © 2019 Sashank Vempati. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var switchLabel: UISwitch!
    
    @IBAction func `switch`(_ sender: UISwitch){
        UserDefaults.standard.set(sender.isOn, forKey: "switchStatus")
        if sender.isOn {
            statusLabel.text = "You're Online"
            
        } else {
            statusLabel.text = "Go Online"
        }
        UserDefaults.standard.set(statusLabel.text, forKey: "statusLabel")
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let savedSwitch = UserDefaults.standard.object(forKey: "switchStatus")
        let savedStatus = UserDefaults.standard.object(forKey: "statusLabel")
        if let Switch = savedSwitch as? Bool {
            switchLabel.setOn(Switch, animated: true)
            if let Status = savedStatus as? String {
                statusLabel.text = Status
            }
        }
    }

    

}
