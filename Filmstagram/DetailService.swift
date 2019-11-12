//
//  DetailService.swift
//  Filmstagram
//
//  Created by Xcode on 6.11.2019.
//  Copyright © 2019 Xcode. All rights reserved.
//

import Foundation
import UIKit


class DetailService {
     let http = HTTP();
    func getDetail(param: [String:String],result: @escaping (FilmDetail) -> Void    ) -> Void {
        http.get(url:ServiceBase.getURLBase(),param: param ){ (data) in
                      do
                              {
                                 let jsonDecoder = JSONDecoder()
                                 let responseModel = try jsonDecoder.decode(FilmDetail.self, from: data);
                                result(responseModel)
                                 
                              } catch let error {
                                  print("Error", error)
                                  
                              }
                    };
        }
    }

