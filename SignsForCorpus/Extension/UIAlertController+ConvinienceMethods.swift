//
//  UIAlertController+ConvinienceMethods.swift
//  SignsForCorpus
//
//  Created by IlyaCool on 22.07.22.
//

import UIKit

extension UIAlertController {
    static func showErrorController(_ title: String, withMessage message: String, _ sender: UIViewController) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        sender.present(alert, animated: true, completion: nil)
    }
}
