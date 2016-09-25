//
//  NewRecordingViewController.swift
//  Hummingbird
//
//  Created by Cole Smith on 9/24/16.
//  Copyright © 2016 Ahmad and Smith. All rights reserved.
//

import UIKit

class NewRecordingViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var recordButton: UIButton!
    
    // MARK: - Initalizers
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - View Handlers
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Animations
    
    func drawRecordingAnimation(view: UIView) {
        
    }
    
    // MARK: - Actions
    
    @IBAction func recordButtonPressed(_ sender: AnyObject) {
        let am = AudioManager.sharedManager
        am.record()
    }
    
    @IBAction func recordButtonUnpressed(_ sender: AnyObject) {
        let am = AudioManager.sharedManager
        am.stopRecording()
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
