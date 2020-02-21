//
//  SignUpViewController.swift
//  Host The Room App
//
//  Created by Sashank Vempati on 1/15/20.
//  Copyright © 2020 Sashank Vempati. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func AccountIsThere(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func SignUp(_ sender: Any) {
        Auth.auth().createUser(withEmail: "user1@gmail.com", password: "password") { (user: AuthDataResult?, error: Error?) in
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            print(user)
        }
    }
    
    
    
    
    
}
