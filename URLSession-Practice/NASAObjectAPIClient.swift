//
//  NASAObjectAPIClient.swift
//  URLSession-Practice
//
//  Created by C4Q on 12/1/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import Foundation

class NASAObjectAPIClient {
    private init() {}
    static let manager = NASAObjectAPIClient()
    //we are giving this function completion/error handlers because we are guaranteed to have data/error when the completion or error handler runs
        //this way we don't need to worry about manually stopping the code and make it wait until it gets the data
        //it will run the handlers on its own time and we won't have to worry about managing when it'll be run
    func getNASAObject(
        from urlString: String,
        completionHandler: @escaping (NASAObject) -> Void,
        errorHandler: @escaping (Error) -> Void) {
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        NetworkHelper.manager.performDataTask(
            with: url,
            completionHandler: { (data) in
                do {
                    let onlineNasaObject = try JSONDecoder().decode(NASAObject.self, from: data)
                    
                    completionHandler(onlineNasaObject)
                    
                } catch {
                    errorHandler(error)
                }
                
        },
            errorHandler: errorHandler)
        
    }
}
