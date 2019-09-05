//
//  ViewController.swift
//  DiffableDataSource
//
//  Created by Gualtiero Frigerio on 05/09/2019.
//  Copyright © 2019 Gualtiero Frigerio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var dataSource:DataSource!
    var restClient:RESTClient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restClient = SimpleRESTClient()
        let baseUrl = "https://api.punkapi.com/v2/"
        dataSource = DataSource(baseURLString: baseUrl, restClient: restClient)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowTable",
            let tableViewController = segue.destination as? TableViewController {
            tableViewController.dataSource = dataSource
        }
    }
}

