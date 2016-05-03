//
//  UserLocation.swift
//  LocatrSwift
//
//  Created by Nina Yang on 3/15/16.
//  Copyright © 2016 Nina Yang. All rights reserved.
//

import Foundation
import ObjectMapper
import CoreLocation

class UserLocation: Mappable {
    
    var locationOn: Bool?
    var latitude: String?
    var longitude: String?
    
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
        locationOn <- map["locationOn"]
        latitude  <- map["latitude"]
        longitude <- map["longitude"]
    }
}