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
    
    var key: String
    var poster: String?
    var audioFilePath: String?
    var upVotes: UInt?
    var downVotes: UInt?
    var netVotes: Int?
    var completed: Bool = false
    let ref: FIRDatabaseReference?
    var genre: String?

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
        upVotes = snapshot.value(forKey: "upVotes") as? UInt
        downVotes = snapshot.value(forKey: "downVotes") as? UInt
        netVotes = snapshot.value(forKey: "netVotes") as? Int
        genre = snapshot.value(forKey: "genre") as? String
        completed = (snapshot.value(forKey: "completed") as? Bool)!
        ref = snapshot.ref
    }
}
