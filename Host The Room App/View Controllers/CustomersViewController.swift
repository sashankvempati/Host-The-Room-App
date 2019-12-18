//
//  CustomerViewController.swift
//  Host The Room App
//
//  Created by Sashank Vempati on 9/9/19.
//  Copyright © 2019 Sashank Vempati. All rights reserved.
//

import UIKit

class CustomersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    //Test arrays **Temporary until connecting to Firebase**
    var nameArray = ["John","Alex","Jane","Sam","Dan"]
    var timeArray = ["Wed Nov 20 2019 7-8 pm","Fri Jan 3 2020 3-5 pm","Sat Oct 12 2019 12-6 pm","Tue Nov 5 2019 8-10 am","Mon Nov 25 2019 7-8 am"]
    var hoursArray = ["1 hrs","2 hrs","6 hrs","2 hrs","1 hrs"]
    var amountArray = ["$20.67","$41.82","$127.34","$41.82","$20.67"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //Defines size of tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    //Initializing all elements in a table view cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomersTableViewCell", for: indexPath) as! CustomersTableViewCell
        
        //test arrays
        cell.CustomerImageView.image = UIImage(named: nameArray[indexPath.row])
        cell.CustomerNameLabel.text = nameArray[indexPath.row]
        cell.DateTimeBookedLabel.text = timeArray[indexPath.row]
        cell.TotalHoursLabel.text = hoursArray[indexPath.row]
        cell.TotalAmountLabel.text = amountArray[indexPath.row]
        
        return cell
    }
    
    //Elements of the Customer Details View Controller retrieved from their corresponding table view cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CustomerDetailsViewController") as? CustomerDetailsViewController
        vc?.image = UIImage(named: nameArray[indexPath.row])!
        vc?.name = nameArray[indexPath.row]
        vc?.time = timeArray[indexPath.row]
        vc?.hours = hoursArray[indexPath.row]
        vc?.cost = amountArray[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    


}
