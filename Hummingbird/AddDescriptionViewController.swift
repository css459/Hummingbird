//
//  AddDescriptionViewController.swift
//  Hummingbird
//
//  Created by Cole Smith on 9/25/16.
//  Copyright © 2016 Ahmad and Smith. All rights reserved.
//

import UIKit

protocol SendDescBack: class {
    func sendDesc(desc: String)
}

class AddDescriptionViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var descTextView: UITextView!
    
    weak var delegate: NewRecordingViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descTextView.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isEditing = false
        super.touchesBegan(touches, with: event)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        descTextView.text = ""
    }
    
    @IBAction func donePressed(_ sender: AnyObject) {
        delegate?.sendDesc(desc: descTextView.text)
        _ = self.navigationController?.popViewController(animated: true)
    }
}
