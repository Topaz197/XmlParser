//
//  Networking.swift
//  ParsingXML
//
//  Created by Anthony Rodriguez on 8/25/17.
//  Copyright © 2017 Anthony Rodriguez. All rights reserved.
//

import Foundation

enum NetworkingErrors:Error
{
    case BadUrl
}

class Networking
{
    static func callApi(url:String, completion:@escaping (Data?, Error?)->())
    {
        guard let url = URL(string: url) else {completion(nil, NetworkingErrors.BadUrl);return}
        let session = URLSession.shared
        let task = session.dataTask(with: url){(data, response, error) in
            completion(data, error)
        }
        task.resume()
    }
    
}
