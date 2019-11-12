//
//  HTTP.swift
//  Filmstagram
//
//  Created by Xcode on 3.11.2019.
//  Copyright © 2019 Xcode. All rights reserved.
//
import UIKit
class HTTP {
    func get(url:String, param: [String:String],result: @escaping (Data) -> Void	) -> Void {
        
        var component = URLComponents(string: url)!;
        let queryItemToken = URLQueryItem(name: "apikey", value: "ebb5f279")
       
       
         component.queryItems = [queryItemToken];
         param.map { (key, value) in
         component.queryItems?.append(URLQueryItem(name: key, value: value));
         }
      
        let request = URLRequest(url: (component.url!));
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                
                    
                } else {
                    if let response = response as? HTTPURLResponse {
                        print("statusCode: \(response.statusCode)")
                    }
                    if data != nil {
                        result(data!)
                     }
            }
         }
        task.resume();
       
    }
    func post(x: Any) -> Void {
       
    }
    func put(x: Any) -> Void {
    }
    func delete(x: Any) -> Void {
        
        
        
    }

    
    
}
