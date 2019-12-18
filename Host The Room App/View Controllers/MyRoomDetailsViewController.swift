//
//  MyRoomDetailsViewController.swift
//  Host The Room App
//
//  Created by Sashank Vempati on 9/18/19.
//  Copyright © 2019 Sashank Vempati. All rights reserved.
//

import UIKit
import Firebase

class MyRoomDetailsViewController: UIViewController {

    @IBOutlet weak var MyRoomImage: UIImageView!
    @IBOutlet weak var MyRoomPrice: UITextField!
    @IBOutlet weak var MyRoomDescription: UITextView!
    @IBOutlet weak var MyRoomAddress: UITextView!
    @IBOutlet weak var MyRoomAmenities: UITextView!
    
    //Variables correspond to outlets, will be initialized in MyRoomsViewController
    var image = UIImage()
    var price = ""
    var desc = ""
    var address = ""
    var amenities = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        MyRoomImage.image = image
        MyRoomPrice.text = price
        MyRoomDescription.text = desc
        MyRoomAddress.text = address
        MyRoomAmenities.text = amenities
    }
    
    
    @IBAction func save(_ sender: Any) {
        
        //UserDefaults.standard.set(MyRoomImage.image, forKey: "myRoomImage")
        /**
        UserDefaults.standard.set(MyRoomPrice.text, forKey: "myRoomPrice")
        UserDefaults.standard.set(MyRoomDescription.text, forKey: "myRoomDescription")
        UserDefaults.standard.set(MyRoomAddress.text, forKey: "myRoomAddress")
        UserDefaults.standard.set(MyRoomAmenities.text, forKey: "myRoomAmenities")
        */
        //print(MyRoomPrice.text!)
        //print(MyRoomDescription.text!)
        let db = Firestore.firestore()
        db.collection("Host").document("My Rooms Example").setData(["price" : MyRoomPrice.text!, "description": MyRoomDescription.text!, "address":MyRoomAddress.text!, "amenities":MyRoomAmenities.text!], merge: true)
        /**let vc = storyboard?.instantiateViewController(withIdentifier: "MyRoomsViewController") as? MyRoomsViewController
        print(vc?.discArray[vc!.row + 1])
        vc?.discArray[vc!.row + 1] = "Beautiful Home"
        print(vc?.discArray[vc!.row + 1])
         */
        
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
}
