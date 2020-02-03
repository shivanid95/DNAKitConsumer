//
//  ButtonsCoordinator.swift
//  DNAKitConsumer
//
//  Created by Shivani on 23/01/20.
//  Copyright © 2020 designSystem. All rights reserved.
//

import UIKit


class ButtonsCoordinator: Coordinator {
    
    var presentingViewController: UINavigationController
    
    var buttonsViewController: UIViewController!
    
    
    init(presentingViewController: UINavigationController) {
        self.presentingViewController = presentingViewController
    }
    
    func start() {
        buttonsViewController = ButtonsViewController()
        presentingViewController.show(buttonsViewController, sender: self)
    }
}
