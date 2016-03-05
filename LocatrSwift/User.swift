//
//  User.swift
//  LocatrSwift
//
//  Created by Chris Jeon on 3/4/16.
//  Copyright © 2016 Nina Yang. All rights reserved.
//

import Foundation
import ObjectMapper

class User : Mappable {
    var email: String?
    var name: String?
    
    required init?(_ map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        email <- map["email"]
        name  <- map["name"]
    }
}