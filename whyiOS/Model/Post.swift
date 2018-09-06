//
//  Post.swift
//  whyiOS
//
//  Created by Cody on 9/5/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import Foundation

class Post: Codable {
    let name: String
    let reason: String
    var uuid: String = UUID().uuidString
    let cohort: String = "iOS21"
    
    init(name: String, reason: String, uuid: String = UUID().uuidString) {
        self.name = name
        self.reason = reason
        self.uuid = uuid
        
    }
}
