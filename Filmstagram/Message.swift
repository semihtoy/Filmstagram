//
//  Message.swift
//  Filmstagram
//
//  Created by Xcode on 11.11.2019.
//  Copyright © 2019 Xcode. All rights reserved.
//

import Foundation
import UIKit

class Message {
    static func show(messageTitle:String) -> Void {
    let alert = UIAlertController(title: "Error", message:messageTitle , preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
    UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}

