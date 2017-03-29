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

        let requestURL = URL(string: "http://www.learnswiftonline.com/Samples/subway.json")!
        let urlRequest = URLRequest(url: requestURL)
        let task = URLSession.shared.dataTask(with: urlRequest as URLRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                print("Everyone is fine, file downloaded successfully.")
                do{
                    
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String : AnyObject]
                    print("The data is \(json)")

                    if let stations = json["stations"] as? [[String: AnyObject]] {

                        var model = [Model]()

                        
                        for station in stations {
                            let mockModel = Model(json: station)
                            model.append(mockModel)
                        }
                        self.delegate?.didDownloadItem(arr: model)

//                        completion(model)
                    }

                }catch {
                    print("Error with Json: \(error)")
                }
                
            }
        }
        task.resume()
    }

}
