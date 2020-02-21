//
//  AvailableRoomsViewController.swift
//  Host The Room App
//
//  Created by Sashank Vempati on 12/30/19.
//  Copyright © 2019 Sashank Vempati. All rights reserved.
//

import UIKit

class AvailableRoomsViewController: UITableViewController {
    
    
    @IBOutlet weak var availableList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = availableList.dequeueReusableCell(withIdentifier: "AvailableRoomsTableViewCell", for: indexPath) as! AvailableRoomsTableViewCell
        
        return cell
    }
    

}
