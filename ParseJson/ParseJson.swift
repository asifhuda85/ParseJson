//
//  ParseJson.swift
//  ParseJson
//
//  Created by Md Asif Huda on 3/3/17.
//  Copyright © 2017 Md Asif Huda. All rights reserved.
//

import Foundation
protocol updateModel {
    func didDownloadItem(arr: [AnyObject])
}

class ParseJson {
    
    var delegate:updateModel?
    
//    func parseJson(completion:(([Model]) -> Void)!) {
        func parseJson() {


        let requestURL = URL(string: "https://www.reddit.com/.json")!
        let urlRequest = URLRequest(url: requestURL)
        let task = URLSession.shared.dataTask(with: urlRequest as URLRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                print("Everyone is fine, file downloaded successfully.")
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as? NSDictionary
                    
                    if let children = ((json?["data"] as? NSDictionary)?["children"] as? [Dictionary<String,AnyObject>]) {
                        var model = [Model]()
                        for child in children {
                            if let images = (((child["data"])?["preview"] as? NSDictionary)?["images"] as? [Dictionary<String,AnyObject>] ) , let title = ((child["data"])?["title"] as? String) {
                                for image in images {
                                    if let url = (image["source"]?["url"] as? String){
                                       
                                        model.append(Model(title: title, url: url))
                                    }
                                }
                            }
                            self.delegate?.didDownloadItem(arr: model)
                        }
                    }
                }catch {
                    print("Error with Json: \(error)")
                }
            }
        }
        task.resume()
    }

}







