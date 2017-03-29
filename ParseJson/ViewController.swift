//
//  ViewController.swift
//  ParseJson
//
//  Created by Md Asif Huda on 3/3/17.
//  Copyright © 2017 Md Asif Huda. All rights reserved.
//

import UIKit

class ViewController: UIViewController, updateModel {

    @IBOutlet weak var myTableView: UITableView!
    
    var models = [Model]()

    override func viewDidLoad() {
        super.viewDidLoad()
//        parseJson()
        let api = ParseJson()
        api.delegate = self
        
        api.parseJson()
        // Do any additional setup after loading the view, typically from a nib.
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

}

extension ViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as! MyTableViewCell
        let model = models[indexPath.row]
        
        cell.myLabel.text = model.name

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
}

