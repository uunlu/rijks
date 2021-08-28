//
//  View+Extensions.swift
//  View+Extensions
//
//  Created by Ugur Unlu on 8/28/21.
//

import UIKit

extension UIViewController {
    @objc func tapDone(sender: Any) {
           self.view.endEditing(true)
       }  
}
