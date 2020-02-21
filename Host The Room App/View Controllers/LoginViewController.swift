//
//  LoginViewController.swift
//  Host The Room App
//
//  Created by Sashank Vempati on 9/21/19.
//  Copyright © 2019 Sashank Vempati. All rights reserved.
//

import UIKit
import FirebaseUI

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Firebase Auth Demo"
    }
    
    
    @IBAction func loginTapped(_ sender: UIButton) {
        //Get the default Auth UI object
        let authUI = FUIAuth.defaultAuthUI()
        
        guard authUI != nil else {
            //Log the error
            return
        }
        
        //Set ourselves as the delegate
        authUI?.delegate = self
        authUI?.providers = [FUIEmailAuth()]
        
        //Get a reference to the auth UI view controller
        let authViewController = authUI?.authViewController()
        
        //Show it
        present(authViewController!, animated: true, completion: nil)
        
    }
    
}

extension UIViewController: FUIAuthDelegate {
    
        
    public func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        
        //Check if there is an error
        if error != nil {
            //log the error
            return
        }
        
        //authDataResult?.user.uid
        
        performSegue(withIdentifier: "onLogin", sender: self)
        
        
    }
    
    
}
