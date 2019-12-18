//
//  AddRoomViewController.swift
//  Host The Room App
//
//  Created by Sashank Vempati on 9/16/19.
//  Copyright © 2019 Sashank Vempati. All rights reserved.
//

import UIKit

class AddRoomViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func done(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }


}
