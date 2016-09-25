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

class Humm: NSObject {
    
    // MARK: - Class Properties
    
    var poster: String?
    var audioFilePath: String?
    var upVotes: UInt?
    var downVotes: UInt?
    var netVotes: Int?
    var genre: Genres?
    
    enum Genres {
        case rock
        case indie
        case electronic
    }
    
    // MARK: - Initalizers
    
    override init() {
        super.init()
    }
}
