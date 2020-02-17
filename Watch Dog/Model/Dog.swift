//
//  Dog.swift
//  Watch Dog
//
//  Created by Nick Nguyen on 2/16/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import Foundation

struct Dog : Codable {
    
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case image = "message"
    }
    
    
}
