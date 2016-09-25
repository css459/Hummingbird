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
    
    @IBOutlet weak var welcomeText: UILabel!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var facebookLogin: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.facebookLogin.delegate = self
        self.facebookLogin.readPermissions = ["public_profile", "email", "user_friends"]
        
        // Pretty animations
        let animationDuration = 2.0
        let delayBetween: UInt32 = 1
        welcomeText.alpha = 0.0
        logoImage.alpha = 0.00
        facebookLogin.alpha = 0.0
        facebookLogin.isEnabled = false
        UIView.animate(withDuration: animationDuration, animations: {
            // Logo
            self.logoImage.alpha = 1.0
            }, completion: { _ in
                // Text
                sleep(delayBetween)
                UIView.animate(withDuration: animationDuration, animations: {
                    self.welcomeText.alpha = 1.0
                    }, completion: { _ in
                        // Button
                        sleep(delayBetween)
                        UIView.animate(withDuration: animationDuration, animations: {
                            self.facebookLogin.alpha = 1.0
                            }, completion: { _ in
                                self.facebookLogin.isEnabled = true
                        })
                })
        })
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if (error) != nil {
            // Process error
            let fbalert = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
            self.present(fbalert, animated: true, completion: nil)
        } else {
            // Navigate to other view
            let creds = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            
            FIRAuth.auth()?.signIn(with: creds, completion: { (user, error) in
                if error != nil {
                    let alert = UIAlertController(title: "Error", message: "Error Signing In", preferredStyle: .alert)
                    self.present(alert, animated: true, completion: nil)
                } else {
                    print(user?.displayName)
                    self.performSegue(withIdentifier: "toHome", sender: self)
                }
            })
        }
    
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        try! FIRAuth.auth()!.signOut()
    }

}

