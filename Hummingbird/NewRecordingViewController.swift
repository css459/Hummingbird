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
        
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        do {
            // Get the directory contents urls (including subfolders urls)
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: [])
        
            // if you want to filter the directory contents you can do like this:
            let m4aFiles = directoryContents.filter{ $0.pathExtension == "m4a" }
            am.playFromURL(url: m4aFiles[0] as NSURL)
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
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
