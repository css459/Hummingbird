//
//  DataManager.swift
//  Hummingbird
//
//  Created by Cole Smith on 9/24/16.
//  Copyright © 2016 Ahmad and Smith. All rights reserved.
//

import UIKit

class DataManager: NSObject {
    
    static let sharedManager: DataManager = DataManager()
    
    // MARK: - Class Properties
    
    let GENRES = [
        "Rock",
        "Inide",
        "Electronic",
    ]
    
    override private init() {
        super.init()
    }

}
