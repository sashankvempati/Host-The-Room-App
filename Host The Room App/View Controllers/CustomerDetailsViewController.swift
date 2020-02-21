//
//  CustomerDetailsViewController.swift
//  Host The Room App
//
//  Created by Sashank Vempati on 9/18/19.
//  Copyright © 2019 Sashank Vempati. All rights reserved.
//

import UIKit

class CustomerDetailsViewController: UIViewController {
    
    @IBOutlet weak var CustomerPicture: UIImageView!
    @IBOutlet weak var CustomerName: UILabel!
    @IBOutlet weak var CustomerBio: UILabel!
    @IBOutlet weak var CustomerEmail: UILabel!
    @IBOutlet weak var CustomerPhoneNumber: UILabel!
    @IBOutlet weak var CustomerDateAndTimeBooked: UILabel!
    @IBOutlet weak var TotalHours: UILabel!
    @IBOutlet weak var TotalAmount: UILabel!
    
    //These variables correspond to the outlets, will be initialized in the CustomersViewController
    var image = UIImage()
    var name = ""
    var bio = ""
    var email = ""
    var number = ""
    var time = ""
    var hours = ""
    var cost = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        CustomerPicture.image = image
        CustomerName.text = name
        //CustomerBio.text = bio
        //CustomerEmail.text = email
        //CustomerPhoneNumber.text = number
        CustomerDateAndTimeBooked.text = time
        TotalHours.text = hours
        TotalAmount.text = cost
    }
    
    

}
