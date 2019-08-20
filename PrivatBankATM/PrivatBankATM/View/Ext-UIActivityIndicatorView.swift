//
//  Ext-UIActivityIndicatorView.swift
//  PrivatBankATM
//
//  Created by Serhii CHORNONOH on 8/20/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import Foundation
import UIKit

extension UIActivityIndicatorView {
    
    func startSpinning(_ sender: UIActivityIndicatorView) {
        sender.isHidden = false
        sender.startAnimating()
    }
    
    func stopSpinning(_ sender: UIActivityIndicatorView) {
        sender.isHidden = true
        sender.stopAnimating()
    }
}
