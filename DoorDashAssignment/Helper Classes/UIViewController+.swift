//
//  UIViewController+.swift
//  DoorDashAssignment
//
//  Created by Renu Punjabi on 1/19/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

import Foundation
import UIKit

// MARK: - UIViewController extension to show error alert and other additional helper methods
extension UIViewController {
    func showError(_ title: String, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        present(alertController, animated: true, completion: nil)
    }
    
}
