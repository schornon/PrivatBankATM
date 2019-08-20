//
//  SharedClass.swift
//  PrivatBankATM
//
//  Created by Serhii CHORNONOH on 8/20/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import Foundation
import UIKit

class SharedClass : NSObject {
    
    static let sharedInstance = SharedClass()
    
    func alert(view: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        DispatchQueue.main.async {
            view.present(alert, animated: true)
        }
    }
    
    private override init() {
    }
}
