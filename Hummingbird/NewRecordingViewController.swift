//
//  NewRecordingViewController.swift
//  Hummingbird
//
//  Created by Cole Smith on 9/24/16.
//  Copyright © 2016 Ahmad and Smith. All rights reserved.
//

import UIKit
import Firebase

class NewRecordingViewController: UIViewController {
    let ref = FIRDatabase.database().reference(withPath: "posts")

    // MARK: - Outlets
    
    @IBOutlet weak var recordButton: UIButton!
    
    // MARK: - Class Properties
    
    private let am = AudioManager.sharedManager
    
    var newHumm: Humm?
    
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
        // TODO: -
    }
    
    // MARK: - Actions
    
    @IBAction func recordButtonPressed(_ sender: AnyObject) {
        let am = AudioManager.sharedManager
        am.record()
    }
    
    @IBAction func cancelPressed(_ sender: AnyObject) {
        _ = navigationController?.popViewController(animated: true)
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
            
            FIRAuth.auth()?.addStateDidChangeListener({ (auth, user) in
                if (FIRAuth.auth()?.currentUser) != nil {
                    let name = user?.displayName
                    let humm = Humm(poster: name!, genre: "Rock", audioFilePath: m4aFiles[0].absoluteString)
                    let hummUserRef = self.ref.child((user?.uid)!)
                    let subRef = hummUserRef.childByAutoId()
                    let key = subRef.key
                    subRef.setValue(humm.toAnyObject())
                    print(key)
                    
                }
            })
            
            am.playFromURL(url: m4aFiles[0] as NSURL)
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    // Implemented from delegate to get the genre
    func sendGenre(genre: String) {
        newHumm?.genre = genre
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGenres" {
            let vc = segue.destination as! GenresTableViewController
            vc.delegate = self
        }
    }
}
