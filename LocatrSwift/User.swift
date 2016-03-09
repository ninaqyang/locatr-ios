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
    var password: String?
    
//    init(email: String, name: String, password: String) {
//        self.email = email
//        self.name = name
//        self.password = password
//    }
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    // Mappable
    func mapping(map: Map) {
        email <- map["email"]
        name  <- map["name"]
        password <- map["password"]
    }
}