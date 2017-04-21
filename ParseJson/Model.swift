//
//  Model.swift
//  ParseJson
//
//  Created by Md Asif Huda on 3/3/17.
//  Copyright © 2017 Md Asif Huda. All rights reserved.
//

import Foundation

class Model {
    
//    var name = ""
//    var year = ""
//    
//    init(json: [String: AnyObject]) {
//        self.name = (json["stationName"] as? String)!
//        self.year = (json["buildYear"] as? String)!
//    }
//    init(data:[String: AnyObject]){
//        super.init()
//        self.name = getStringFromJSON(data: data, key: "stationName")
//        self.year = getStringFromJSON(data: data, key: "buildYear")
//    }
//    
//    func getStringFromJSON(data:[String: AnyObject], key:String) -> String {
//        
//        if let info = data[key] as? String {
//            return info
//        } else {
//            return ""
//        }
//        
//    }
    
    
    var title = ""
    var url = ""
    
    init(title:String , url: String) {
        self.title = title
        self.url = url
    }
    
}
