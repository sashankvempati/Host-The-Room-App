//
//  MyRoomsViewController.swift
//  Host The Room App
//
//  Created by Sashank Vempati on 9/9/19.
//  Copyright © 2019 Sashank Vempati. All rights reserved.
//

import UIKit
import Firebase

class MyRoomsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    
    //Array Declarations **Temporary until connecting to Firebase**
    var roomImage = ["Room with beautiful view", "Italian Luxury Room"]
    /** Room Description should be a maximum of 125 characters **/
    var discArray = ["Beautiful room situated in the foothills of san fernando valley with brethtaking views of the city. Available for 3 hrs only.", "Spacious room for 6 people in Irvine, California"]
    var priceArray = ["$127/hr","$17/hr"]
    var priceValue = ["127.00", "17.00"]
    var addressArray = ["61039 Foothill Dr, Calabasas, CA 90290", "930139 Bridgecastle Way, Irvine, CA 92602"]
    var amenitiesArray = ["Printer, External TV Monitor, Refridgerator with food, Floor to ceiling windows, Adjustable lighting, Lamp, Restroom", "Two extra large couches, Printer, Whiteboard with markers, soda and coffee bar, Adjustable lighting, Adjustable Temperature"]
    var row = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
    
    func loadPosts(){
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return discArray.count
    }
    
    //Initializes elements in each table view cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyRoomsTableViewCell", for: indexPath) as! MyRoomsTableViewCell
        cell.MyRoomImageView.image = UIImage(named: roomImage[indexPath.row])
        cell.MyRoomDescription.text = discArray[indexPath.row]
        cell.MyRoomRate.text = priceArray[indexPath.row]
        
        return cell
    }
    
    //Initializes elements in the CustomerDetailsViewController 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MyRoomDetailsViewController") as? MyRoomDetailsViewController
        
        vc?.image = UIImage(named: roomImage[indexPath.row])!
        vc?.desc = discArray[indexPath.row]
        vc?.price = priceValue[indexPath.row]
        vc?.address = addressArray[indexPath.row]
        vc?.amenities = amenitiesArray[indexPath.row]
        
        //shows what cell has been opened
        /*print("opened cell number \(indexPath.row + 1)")
        row = indexPath.row
        print(row)
        */
        
        /*
        let savedDisc = UserDefaults.standard.object(forKey: "myRoomDescription")
        let savedPrice = UserDefaults.standard.object(forKey: "myRoomPrice")

        if let Disc = savedDisc as? String {
            //discArray[indexPath.row] = Disc
            //vc?.desc = Disc
        }
            //vc?.desc = discArray[indexPath.row]
        
        if let Price = savedPrice as? String {
            //priceArray[indexPath.row] = Price
            //vc?.price = Price
        }
            //vc?.price = priceArray[indexPath.row]
        */
        let db = Firestore.firestore()
        
        let docRef = db.collection("Rooms").document("aE7zP3IryV7ldLjNY15w")

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
            } else {
                print("Document does not exist")
            }
        }

        
        
        
        self.navigationController?.pushViewController(vc!, animated: true)
        
        
    }
    
    
    
    

}
