//
//  YelpService.swift
//  LocatrSwift
//
//  Created by Nina Yang on 3/19/16.
//  Copyright © 2016 Nina Yang. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import ObjectMapper
import AlamofireObjectMapper
import OAuthSwift

class YelpService {
    
    let yelp = [
        "consumerKey": "Z5wpXTeoqrcPhhuixMitEw",
        "consumerSecret": "AL7bkf34P72F__SowKj6YrrjKwo",
        "accessToken": "DFHFDGoELx3zmwx8B2Oe3ESjU5gjvzWJ",
        "accessTokenSecret": "oMjViwGnPpzoVMBhbj7nXM_mV-s"
    ]
    
    let baseUrl = "https://api.yelp.com/v2/search"
    
    func yelpOAuth(terms: String, latitude: Double, longitude: Double) {
        let oauthClient = OAuthSwiftClient (consumerKey: yelp["consumerKey"]!, consumerSecret: yelp["consumerSecret"]!, accessToken: yelp["accessToken"]!, accessTokenSecret: yelp["accessTokenSecret"]!)
                
        let termsArray = terms.componentsSeparatedByString(" ")
        let yelpTerms = termsArray.joinWithSeparator("+")
        let params: [String: String] = ["term": yelpTerms, "ll": "\(latitude),\(longitude)"]
        print(baseUrl, params)
        
        oauthClient.get(baseUrl, parameters: params, success: { (data, response) -> Void in
            let jsonObject = JSON(data: data)
            print(jsonObject)
            
            let yelpLocation = Mapper<YelpLocation>().map(jsonObject)
            
//            let location = Mapper<User>().map(jsonObject)!
//            for businesses in jsonObject["businesses"].arrayValue {
//                print(businesses)
//                
//                var yelpLocation = Mapper<YelpLocation>().map(businesses)
//                let location: Array<YelpLocation> = Mapper<YelpLocation>().map(businesses)
//                print(location)
//            }

//            print(businesses)
//            let location = Mapper<YelpLocation>().map(businesses)
//            print(location)
            }) { (error) -> Void in
                print(error)
        }
    }

//    func getYelpLocations(completionHandler: (Array<Event>) -> ()) {
//        Alamofire.request(.GET, baseUrl).responseArray { (response: Response<[Event], NSError>) in
//            let eventArray = response.result.value
//            
//            completionHandler(eventArray!)
//        }
//        
//        Alamofire.request(.GET, baseUrl, headers: headers)
//        
//        let params = OAuthSwiftClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessTokenSecret: yelpTokenSecret)
//        Alamofire.request(.GET, baseUrl, parameters: params)
//            .authenticate(user: consumerKey, password: consumerSecret)
//            .responseJSON { response in
//                switch response.result {
//                case .Success(let value):
//                    completionHandler(value as? NSDictionary, nil)
//                case .Failure(let error):
//                    completionHandler(nil, error)
//                }
//        }
//    }
    
}