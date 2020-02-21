//
//  CreateRoomViewController.swift
//  Host The Room App
//
//  Created by Sashank Vempati on 1/2/20.
//  Copyright © 2020 Sashank Vempati. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class CreateRoomViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var address: UITextView!
    
    @IBOutlet weak var photo: UIImageView!
    
    @IBOutlet var desc: UITextView!
    
    @IBOutlet var priceField: UITextField!
    
    
    var selectedImage: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleSelectPhoto))
        photo.addGestureRecognizer(tapGesture)
        photo.isUserInteractionEnabled = true

    }
    @objc func handleSelectPhoto() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
        
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        /*
        let ref = Firestore.firestore()
        let postReference = ref.collection("available rooms")
        let newPostId = postReference.collectionID
        
        let newPostReference = postReference.addDocument(data: ["uid" : newPostId])
        newPostReference.updateData(["address" : address.text!])
        */
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func done(_ sender: Any) {
        //show activity indicator
        /*let ref = Firestore.firestore()
        //ref.collection("available rooms").addDocument(data: ["address" : address.text!])
        
        ref.collection("available rooms").document("my first room").setData(["address" : address.text!, "description": desc.text!, "price": priceField.text!])
        print("Description: \(desc.text!)")
        print( "Address: \(address.text!)" )
        print("Cost: \(priceField.text!)")
        */
        
        
        guard let image = photo.image,
            let data = image.jpegData(compressionQuality: 0.1) else {
            return
        }
        let imageName = UUID().uuidString
        
        let imageReference = Storage.storage().reference().child("RoomImages").child(imageName)
        
        imageReference.putData(data, metadata: nil) { (metadata, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            imageReference.downloadURL { (url, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let url = url else {
                    print("Something went wrong")
                    return
                }
                
                let dataReference = Firestore.firestore().collection("Rooms").document()
                let documentUid = dataReference.documentID
                
                let urlString = url.absoluteString
                
                let data = [
                    "document UID": documentUid,
                    "image URL": urlString,
                    "description": self.desc.text!,
                    "address": self.address.text!,
                    "price": self.priceField.text!
                    
                    ] as [String : Any]
                dataReference.setData(data) { (error) in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    UserDefaults.standard.set(documentUid, forKey: "uid")
                    self.photo.image = UIImage()
                    
                }
                
                //should print document data that has just been uploaded to firestore
                /*let docRef = Firestore.firestore().collection("Rooms").document(documentUid)
                
                docRef.getDocument { (document, error) in
                    if let document = document, document.exists {
                        let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                        print("Document data: \(dataDescription)")
                    } else {
                        print("Document does not exist")
                    }
                    
                }*/
                

                //Sorts data based on what fields/ strings are filtered
                //In this case, we are querying the data of the room that was just posted and retrieving all the individual elements
                Firestore.firestore().collection("Rooms").whereField("document UID", isEqualTo: documentUid)
                    .getDocuments() { (querySnapshot, err) in
                        if let err = err {
                            print("Error getting documents: \(err)")
                        } else {
                            for document in querySnapshot!.documents {
                                print("this thing works")
                                
                                //This retrieves the address
                                /**TODO: Should do the same thing for all elements of each post**/
                                
                                let storedAddress = document.get("address")! as! String
                                let storedDesc = document.get("description")! as! String
                                let storedImageUrl = document.get("image URL")! as! String
                                let storedPrice = document.get("price")! as! String
                                let storedUID = document.get("document UID")! as! String
                                print(storedAddress)
                                UserDefaults.standard.set(storedAddress, forKey: "currAddress")
                                UserDefaults.standard.set(storedDesc, forKey: "currDescription")
                                UserDefaults.standard.set(storedImageUrl, forKey: "currImageURL")
                                UserDefaults.standard.set(storedPrice, forKey: "currPrice")
                                UserDefaults.standard.set(storedUID, forKey: "currUID")
                                print("\(document.documentID) => \(document.data()), Address: \(document.get("address")!)")
                                
                                
                                //Just to confirm that Userdefaults works for address
                                let savedAddress = UserDefaults.standard.string(forKey: "currAddress")
                                print(savedAddress!)

                            }
                        }
                }
                
            }
            
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    func sendDataToDatabase(photoUrl: String){
        let ref = Firestore.firestore()
        let postsReference = ref.collection("rooms")
        let newPostId = postsReference.collectionID
        let newPostReference = postsReference.addDocument(data: ["uid" : newPostId])
        newPostReference.setData(["photoUrl" : photoUrl]) { (error) in
            if error != nil {
                //show pop up error
                return
            }
            //show pop up success
        }
        
        
        //db.collection("cars").addDocument(data: ["year" : 2015, "make": "Ferrari", "model":"458 speciale aperta"])
    }
    

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("did finish picking media")
        if let image = info[.originalImage] as? UIImage {
            selectedImage = image
            photo.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
}
