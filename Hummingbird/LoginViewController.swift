//
//  ViewController.swift
//  Hummingbird
//
//  Created by Cole Smith on 9/24/16.
//  Copyright © 2016 Ahmad and Smith. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var facebookLogin: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.facebookLogin.delegate = self
        self.facebookLogin.readPermissions = ["public_profile", "email", "user_friends"]
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if let err = error {
            // Process error
            print(err.localizedDescription)
        } else if result.isCancelled {
            // Handle cancellations
            print("cancelled")
        } else {
            // Navigate to other view
            let creds = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            
            FIRAuth.auth()?.signIn(with: creds, completion: { (user, error) in
                if let e = error {
                    print(e)
                } else {
                    print(user?.displayName)
                }
            })
        }
    
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Logout")
    }

}

