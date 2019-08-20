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
    
    func startSpinning() {
        self.isHidden = false
        self.startAnimating()
    }
    
    func stopSpinning() {
        self.isHidden = true
        self.stopAnimating()
    }
}
