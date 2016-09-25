//
//  HomeViewController.swift
//  Hummingbird
//
//  Created by Cole Smith on 9/25/16.
//  Copyright © 2016 Ahmad and Smith. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    @IBOutlet weak var nameButton: UIBarButtonItem!
    @IBOutlet weak var pausePlayImage: UIImageView!
    
    var isPlaying: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add a cute name label
        if let name = FIRAuth.auth()?.currentUser?.displayName {
            nameButton.title = name
        }
        
        // Logo view
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "logo_nav")
        imageView.image = image
        navigationItem.titleView = imageView
        navigationController?.navigationBar.barTintColor = UIColor(red: 1.0, green: 130.0/255.0, blue: 116.0/255.0, alpha: 1.0)
        
        // Functionality for Pause / Play Image Button
        pausePlayImage.isUserInteractionEnabled = true
        pausePlayImage.tag = 0
        pausePlayImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(HomeViewController.tap)))
    }

    func tap() {
        UIView.animate(withDuration: 0.15, animations: {
            self.pausePlayImage.alpha = 0.0
        }, completion: { _ in
            if self.isPlaying {
                // Paused
                self.pausePlayImage.image = UIImage(named: "play")
                self.pause()
            } else {
                // Playing
                self.pausePlayImage.image = UIImage(named: "pause")
                self.play()
            }
            self.isPlaying = !self.isPlaying
            UIView.animate(withDuration: 0.15, animations: {
                self.pausePlayImage.alpha = 1.0
            })
        })
    }
    
    func pause() {
        
    }
    
    func play() {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
