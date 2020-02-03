//
//  TextnputsCoordinator.swift
//  DNAKitConsumer
//
//  Created by Shivani on 23/01/20.
//  Copyright © 2020 designSystem. All rights reserved.
//

import UIKit

class TextInputsCoordinator: Coordinator {
    
    var presentingViewController: UINavigationController
    var textInputViewController: TextInputViewController!
    
    
    init(presentingViewController: UINavigationController) {
        self.presentingViewController = presentingViewController
    }
    
    func start() {
        textInputViewController = TextInputViewController()
        presentingViewController.pushViewController(textInputViewController, animated: true)
    }
}
