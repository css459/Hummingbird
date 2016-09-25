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

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameButton: UIBarButtonItem!
    var name: String!
    var pageIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameLabel.text = name
        // Add a cute name label
//        if let name = FIRAuth.auth()?.currentUser?.displayName {
//            nameButton.title = name
//        }
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
