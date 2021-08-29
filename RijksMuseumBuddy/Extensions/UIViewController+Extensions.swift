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

extension UIViewController {
    func displayErrorMessage(_ message: String = "") {
        let errorMessage = message.isEmpty ? "Operation cannot be completed" : message
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in }))
        present(alert, animated: true, completion: nil)
    }
}
