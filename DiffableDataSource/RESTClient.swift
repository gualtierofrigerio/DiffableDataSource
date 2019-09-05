//
//  RESTClient.swift
//  DiffableDataSource
//
//  Created by Gualtiero Frigerio on 05/09/2019.
//  Copyright © 2019 Gualtiero Frigerio. All rights reserved.
//

import Foundation

protocol RESTClient {
    func getData(atURL url: URL, completion: @escaping (Data?) -> Void)
}

class SimpleRESTClient: RESTClient {
    func getData(atURL url: URL, completion: @escaping (Data?) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            completion(data)
        }
        task.resume()
    }
}
