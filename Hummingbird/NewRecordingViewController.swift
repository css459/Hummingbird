//
//  NewRecordingViewController.swift
//  Hummingbird
//
//  Created by Cole Smith on 9/24/16.
//  Copyright © 2016 Ahmad and Smith. All rights reserved.
//

import UIKit
import Firebase

class NewRecordingViewController: UIViewController, SendGenreBack, SendDescBack {
    let ref = FIRDatabase.database().reference(withPath: "posts")

    // MARK: - Outlets
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var descPreview: UITextView!
    
    // MARK: - Class Properties
    
    private let am = AudioManager.sharedManager
    
    var newHumm: Humm?
    var genre: String?
    var desc: String?
    
    // MARK: - Initalizers
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - View Handlers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        circlularProgress.roundedCorners = 0
//        circlularProgress.trackTintColor = UIColor.red
//        circlularProgress.backgroundColor = UIColor.clear
//        circlularProgress.progress = 0.0
//        circlularProgress.isHidden = true
        
        descPreview.isHidden = true
        descPreview.layer.cornerRadius = 15.0
        descPreview.layer.masksToBounds = true
    }
    
    func throwErrorMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Animations
    
    func drawRecordingAnimation(view: UIView) {
        // TODO: -
    }
    
    // MARK: - Actions
    
    @IBAction func submitPressed(_ sender: AnyObject) {
        
        if self.genre == nil || self.desc == nil {
            
            throwErrorMessage(title: "Not Complete", message: "All fields are required")
            
            FIRAuth.auth()?.addStateDidChangeListener({ (auth, user) in
                if (FIRAuth.auth()?.currentUser) != nil {
                    let name = user?.displayName
                    let storage = FIRStorage.storage()
                    let storageRef = storage.reference(forURL: "gs://hummingbird-112df.appspot.com")
                    
                    let metadata = FIRStorageMetadata()
                    metadata.contentType = "audio/m4a"
                    
                    self.newHumm = Humm(poster: name!, posterUID: (user?.uid)!, genre: self.genreLabel.text!, audioFilePath: m4aFiles[0].absoluteString)
                    let hummUserRef = self.ref.child((user?.uid)!)
                    let subRef = hummUserRef.childByAutoId()
                    let key = subRef.key
                    subRef.setValue(self.newHumm?.toAnyObject())
                    
                    let uploadTask = storageRef.child("posts/\(key).m4a").putFile(m4aFiles[0], metadata: metadata);
                    uploadTask.observe(.success) { snapshot in
                        // Upload completed successfully
                        print("[ STORAGE ]: UPLOAD DONE")
                    }
                }
            })
            
            let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            do {
                // Get the directory contents urls (including subfolders urls)
                let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: [])
                
                // if you want to filter the directory contents you can do like this:
                let m4aFiles = directoryContents.filter{ $0.pathExtension == "m4a" }
                
                FIRAuth.auth()?.addStateDidChangeListener({ (auth, user) in
                    if (FIRAuth.auth()?.currentUser) != nil {
                        let name = user?.displayName
                        let storage = FIRStorage.storage()
                        let storageRef = storage.reference(forURL: "gs://hummingbird-112df.appspot.com")
                        
                        let metadata = FIRStorageMetadata()
                        metadata.contentType = "audio/m4a"
                        
                        self.newHumm = Humm(poster: name!, genre: "Rock", audioFilePath: m4aFiles[0].absoluteString)
                        self.newHumm?.genre = self.genre
                        self.newHumm?.desc = self.desc
                        let hummUserRef = self.ref.child((user?.uid)!)
                        let subRef = hummUserRef.childByAutoId()
                        let key = subRef.key
                        subRef.setValue(self.newHumm?.toAnyObject())
                        let uploadTask = storageRef.child("posts/\(key).m4a").putFile(m4aFiles[0], metadata: metadata);
                        uploadTask.observe(.success) { snapshot in
                            // Upload completed successfully
                            print("[ STORAGE ]: UPLOAD DONE")
                        }
                        
                        print(key)
                        
                    }
                })
                
                am.playFromURL(url: m4aFiles[0] as NSURL)
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func recordButtonPressed(_ sender: AnyObject) {
        
//        circlularProgress.isHidden = false
//        UIView.animate(withDuration: 10.0, animations: {
//            self.circlularProgress.progress += 0.1
//            }, completion: { success in
//        })
        
        let am = AudioManager.sharedManager
        _ = am.record()
    }
    
    @IBAction func cancelPressed(_ sender: AnyObject) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func recordButtonUnpressed(_ sender: AnyObject) {
        
//        let layer = circlularProgress.layer.presentation()! as CALayer
//        let frame = layer.frame
//        circlularProgress.layer.removeAllAnimations()
//        circlularProgress.frame = frame
        
        let am = AudioManager.sharedManager
        am.stopRecording()
    }
    
    // MARK: - Delegate Methods
    
    // Implemented from delegate to get the genre
    func sendGenre(genre: String) {
        self.genre = genre
        genreLabel.text = genre
    }
    
    func sendDesc(desc: String) {
        self.desc = desc
        self.descPreview.isHidden = false
        self.descPreview.text = desc
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGenres" {
            let vc = segue.destination as! GenresTableViewController
            vc.delegate = self
        }
        else if segue.identifier == "toDesc" {
            let vc = segue.destination as! AddDescriptionViewController
            vc.delegate = self
        }
    }
}
