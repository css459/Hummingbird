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
    var posterUID: String?
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
    
    init(posterUID: String, key: String, snapshot: FIRDataSnapshot, data: [String: AnyObject]) {
        
        self.posterUID = posterUID
        ref = snapshot.ref
        self.key = key
        
        poster = data["poster"] as? String
        audioFilePath = data["audioFilePath"] as? String
        upVotes = (data["upVotes"] as? UInt)!
        downVotes = (data["downVotes"] as? UInt)!
        netVotes = (data["netVotes"] as? Int)!
        genre = data["genre"] as? String
        completed = (data["completed"] as? Bool)!
    }
    
    init(key: String = " ", poster: String, posterUID: String, genre: String, audioFilePath: String) {
        self.key = key
        self.posterUID = posterUID
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
