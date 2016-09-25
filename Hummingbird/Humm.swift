//
//  Humm.swift
//  Hummingbird
//
//  Created by Cole Smith on 9/24/16.
//  Copyright © 2016 Ahmad and Smith. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase

class Humm {
    
    // MARK: - Class Properties
    
    let ref: FIRDatabaseReference?
    var key: String
    var poster: String?
    var audioFilePath: String?
    var upVotes: UInt = 0
    var downVotes: UInt = 0
    var netVotes: Int = 0
    var completed: Bool = false
    var genre: String?
    var desc: String?
    static let genres = [
        "Rock",
        "Indie",
        "Electronic"
    ]
    
    // MARK: - Initalizers
    
    init(snapshot: FIRDataSnapshot) {
        
        key = snapshot.key
        poster = snapshot.value(forKey: "poster") as? String
        audioFilePath = snapshot.value(forKey: "audioFilePath") as? String
        upVotes = (snapshot.value(forKey: "upVotes") as? UInt)!
        downVotes = (snapshot.value(forKey: "downVotes") as? UInt)!
        netVotes = (snapshot.value(forKey: "netVotes") as? Int)!
        genre = snapshot.value(forKey: "genre") as? String
        completed = (snapshot.value(forKey: "completed") as? Bool)!
        ref = snapshot.ref
    }
    
    init(key: String = " ", poster: String, genre: String, audioFilePath: String) {
        self.key = key
        self.poster = poster
        self.genre = genre
        self.ref = nil
        self.audioFilePath = audioFilePath
    }
    
    func toAnyObject() -> [String: AnyObject] {
        return [
            "poster": poster as AnyObject!,
            "audioFilePath": audioFilePath as AnyObject!,
            "upVotes": upVotes as AnyObject!,
            "downVotes": downVotes as AnyObject!,
            "netVotes": netVotes as AnyObject!,
            "completed": completed as AnyObject!,
            "genre": genre as AnyObject!
        ]
    }
}
