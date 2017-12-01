//
//  NASAObject.swift
//  URLSession-Practice
//
//  Created by C4Q on 12/1/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import Foundation

struct NASAObject: Codable {
    let title: String
    let hdUrlString: String?
    let urlString: String
    
    //WILL NOT FIX NESTING PROPERTIES
    enum CodingKeys: String, CodingKey {
        //all properties must be accounted for, 
        case title = "title"
        case hdUrlString = "hdurl"
        case urlString = "url"
    }
    
    //allows you to fix the nesting problem by override the default initializer
//    init(from decoder: Decoder) {
//       //fill in stuff here - ben included a link to this in github - https://medium.com/@sarunw/codable-in-swift-4-0-1a12e38599d8
//    }
}
