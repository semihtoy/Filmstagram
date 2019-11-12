//
//  File.swift
//  Filmstagram
//
//  Created by Xcode on 3.11.2019.
//  Copyright © 2019 Xcode. All rights reserved.
//
import UIKit
import Foundation
class SearchService {
    let http = HTTP();
        
    func search(param: [String:String],result: @escaping ([Search]) -> Void ) -> Void {
     
       
        
        http.get(url:ServiceBase.getURLBase(), param:param ){ (data) in
            
               let jsonDecoder = JSONDecoder()
                  do
                          {
                          
                            let responseModel = try jsonDecoder.decode(SearchResponse.self, from: data)
                              if(responseModel.response=="False"){
                               DispatchQueue.main.async {
                                Message.show(messageTitle: "Böyle bir film yok")
                                }
                                
                              }
                            else{
                                 result(responseModel.search!)
                            }
                             
                            
                  } catch _ {
                             
                              
                          }
            
                };
    }
  
}
