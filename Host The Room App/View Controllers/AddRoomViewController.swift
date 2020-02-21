//
//  AddRoomViewController.swift
//  Host The Room App
//
//  Created by Sashank Vempati on 9/16/19.
//  Copyright © 2019 Sashank Vempati. All rights reserved.
//

import UIKit

class AddRoomViewController: UIViewController {

    @IBOutlet weak var RoomImage: UIImageView!
    
    @IBOutlet weak var DescriptionTextView: UITextView!
    
    @IBOutlet weak var AddressTextView: UITextView!
    
    @IBOutlet weak var AmenitiesTextView: UITextView!
    
    @IBOutlet weak var PriceTextField: UITextField!
    
    var selectedImage: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleSelectPhoto))
        RoomImage.addGestureRecognizer(tapGesture)
        RoomImage.isUserInteractionEnabled = true
    }
    
    @objc func handleSelectPhoto() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
        
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func done(_ sender: Any) {
        
        
        
        
        self.dismiss(animated: true, completion: nil)
    }


}
extension AddRoomViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("did finish picking media")
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImage = image
            RoomImage.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}
