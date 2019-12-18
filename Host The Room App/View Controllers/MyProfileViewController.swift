//
//  MyProfileViewController.swift
//  Host The Room App
//
//  Created by Sashank Vempati on 9/16/19.
//  Copyright © 2019 Sashank Vempati. All rights reserved.
//

import UIKit
import Firebase

extension UIViewController{
    
    func HideKeyboard() {
        let Tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        view.addGestureRecognizer(Tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

class MyProfileViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var MyImage: UIImageView!
    @IBOutlet weak var MyName: UITextField!
    @IBOutlet weak var MyBio: UITextView!
    @IBOutlet weak var MyEmail: UITextField!
    @IBOutlet weak var MyPhoneNumber: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //let db = Firestore.firestore()
        
        //add fields in a document, which has an auto-generated name
        //db.collection("cars").addDocument(data: ["year" : 2015, "make": "Ferrari", "model":"458 speciale aperta"])
        //db.collection("My Profile").addDocument(data: ["name" : MyName.text!, "bio": MyBio.text!, "email":MyEmail.text!, "phone number":MyPhoneNumber.text!])
        
        //Getting the document ID and assigning it to a constant/ variable
        //let newDocument = db.collection("cars").document()
        //newDocument.setData(["year" : 2019, "make":"Ferrari", "model": "488 pista", "id":newDocument.documentID])
        
        //Adding a document with a specific document ID
        //db.collection("My Profile").document("Italian").setData(["make" : "Lamborghini"])
        //db.collection("My Profile").document("Settings").setData(["name" : MyName.text!, "bio": MyBio.text!, "email":MyEmail.text!, "phone number":MyPhoneNumber.text!, "Address":"Pinot-Gris Way, San Jose"])
        
        /** Saving user information to UserDefaults and moving the keyboard */
        let savedName = UserDefaults.standard.object(forKey: "myName")
        let savedBio = UserDefaults.standard.object(forKey: "myBio")
        let savedEmail = UserDefaults.standard.object(forKey: "myEmail")
        let savedNumber = UserDefaults.standard.object(forKey: "myPhoneNumber")
        
        if let name = savedName as? String {
            MyName.text = name
        }
        if let bio = savedBio as? String {
            MyBio.text = bio
        }
        if let email = savedEmail as? String {
            MyEmail.text = email
        }
        if let number = savedNumber as? String {
            MyPhoneNumber.text = number
        }
        
        MyName.delegate = self
        MyBio.delegate = self as? UITextViewDelegate
        MyEmail.delegate = self
        MyPhoneNumber.delegate = self
        
        self.HideKeyboard()
        
        //Listen for Keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
    }
    
    deinit { //Stop listening to keyboard events
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    
    //Methods of functions
    func hideKeyboard() {
        MyName.resignFirstResponder()
        MyEmail.resignFirstResponder()
        MyPhoneNumber.resignFirstResponder()
    }
    @objc func keyboardWillChange(notification: Notification){
        print("Keyboard will show: \(notification.name.rawValue)")
        
        /** This returns the value of the keyboard size **
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else{
            return
        }*/
        
        if notification.name == UIResponder.keyboardWillShowNotification ||
            notification.name == UIResponder.keyboardWillChangeFrameNotification {
            
            /** This value will be temporary until view can dynamically resize based on  **/
            view.frame.origin.y = -100 //-keyboardRect.height  //shifts the view up when keyboard shows
        } else {
            view.frame.origin.y = 0
        }
        
    }
    
    //UITextFieldDelegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        //view.frame.origin.y = 0 //goes back to original screen view when keyboard hides
        return true
    }
    
    //Actions
    @IBAction func saveButton(_ sender: Any) {
        UserDefaults.standard.set(MyName.text, forKey: "myName")
        UserDefaults.standard.set(MyBio.text, forKey: "myBio")
        UserDefaults.standard.set(MyEmail.text, forKey: "myEmail")
        UserDefaults.standard.set(MyPhoneNumber.text, forKey: "myPhoneNumber")
        
        //save all the user details to firebase
        let db = Firestore.firestore()
        db.collection("Host").document("My Profile").setData(["name" : MyName.text!, "bio": MyBio.text!, "email":MyEmail.text!, "phone number":MyPhoneNumber.text!, "Address":"Pinot-Gris Way, San Jose"], merge: true)
        
        
        
        self.navigationController?.popViewController(animated: true) //for show segue
    }
    


}
