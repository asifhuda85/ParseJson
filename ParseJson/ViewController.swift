//
//  ViewController.swift
//  ParseJson
//
//  Created by Md Asif Huda on 3/3/17.
//  Copyright © 2017 Md Asif Huda. All rights reserved.
//

import UIKit

class ViewController: UIViewController,updateModel {

    @IBOutlet weak var myTableView: UITableView!
    
    var models = [Model]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let api = ParseJson()
        api.delegate = self
        
        api.parseJson()
//        parseJson()
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func didLoadModel(model:[Model]){
        self.models = model
        DispatchQueue.main.async {
            self.myTableView.reloadData()
        }
    }
    
    func didDownloadItem(arr: [AnyObject]) {
        self.models = arr as! [Model]
        DispatchQueue.main.async {
            self.myTableView.reloadData()
        }
    }
    
//    func parseJson() {
//        
//        let requestURL = URL(string: "https://www.reddit.com/.json")!
//        let urlRequest = URLRequest(url: requestURL)
//        let task = URLSession.shared.dataTask(with: urlRequest as URLRequest) {
//            (data, response, error) -> Void in
//            
//            let httpResponse = response as! HTTPURLResponse
//            let statusCode = httpResponse.statusCode
//            
//            if (statusCode == 200) {
//                do{
//                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as? NSDictionary
//                    
//                    if let children = ((json?["data"] as? NSDictionary)?["children"] as? [Dictionary<String,AnyObject>]) {
//
//                        for child in children {
//                            var model = [Model]()
//                            if let images = (((child["data"])?["preview"] as? NSDictionary)?["images"] as? [Dictionary<String,AnyObject>] ) , let title = ((child["data"])?["title"] as? String) {
//                                for image in images {
//                                    if let url = (image["source"]?["url"] as? String){
//                                        let mockModel = Model(title: title, url: url)
//                                        model.append(mockModel)
//                                    }
//                                }
//                            }
//
//                        }
//                        self.delegate?.didDownloadItem(arr: model)
//
//                    }
//                    
//                }catch {
//                    print("Error with Json: \(error)")
//                }
//                
//            }
//        }
//        task.resume()
//    }
//    
//

}

extension ViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as! MyTableViewCell
        let model = models[indexPath.row]
        
        cell.myLabel.text = model.title

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
}

extension String {
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z]", options: .regularExpression) == nil
    }
}
