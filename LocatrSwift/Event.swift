//
//  Event.swift
//  LocatrSwift
//
//  Created by Nina Yang on 3/12/16.
//  Copyright © 2016 Nina Yang. All rights reserved.
//

import Foundation
import ObjectMapper

class Event: Mappable {
    var iconType: String?
    var iconMarker: String?
    var title: String?
    var address1: String?
    var address2: String?
    var city: String?
    var state: String?
    var zip: String?
    var time: String?
    // add other things in response call
    
    init(iconType: String, title: String, location: String, time: String) {
        self.iconType = iconType
        self.title = title
        self.address1 = location
        self.time = time
    }
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    // Mappable
    func mapping(map: Map) {
        iconType <- map["iconType"]
        iconMarker <- map["iconMarker"]
        title <- map["title"]
        address1  <- map["address1"]
        address2 <- map["address2"]
        city <- map["city"]
        state <- map["state"]
        zip <- map["zip"]
    }
}