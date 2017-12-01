//
//  NetworkHelper.swift
//  URLSession-Practice
//
//  Created by C4Q on 12/1/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import Foundation

class NetworkHelper {
    private init() {}
    static let manager = NetworkHelper()
    private let urlSession = URLSession(configuration: .default)
    func performDataTask(
        with url: URL,
        completionHandler: @escaping (Data) -> Void,
        errorHandler: @escaping (Error) -> Void) {
        urlSession.dataTask(with: url) { (data, response, error) in
            
            //We know that dataTask is a function that executes in the global queue - because of the network request
            //since the completionHandler and errorHandler are closures being passed, and might have UIChanges in them
                //to avoid re-writing DispatchQueue.main.async {} multiple times, we can just write that here
            DispatchQueue.main.async {
                if let error = error {
                    errorHandler(error)
                    return
                }
                
                if let data = data {
                    completionHandler(data)
                }
                
            }
        }.resume()
    }
}
