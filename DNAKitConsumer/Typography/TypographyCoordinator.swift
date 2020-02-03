//
//  TypographyCoordinator.swift
//  DNAKitConsumer
//
//  Created by Shivani on 23/01/20.
//  Copyright © 2020 designSystem. All rights reserved.
//

import UIKit

class TypographyCoordinator: Coordinator {
    
    
    var presentingViewController: UINavigationController
    
    var typographyViewController: TypographyViewController!
    
    func start() {
        typographyViewController = TypographyViewController()
        presentingViewController.pushViewController(typographyViewController, animated: true)
        //show(typographyViewController, sender: self)
    }
    
    
    init(presentingViewController: UINavigationController) {
        self.presentingViewController = presentingViewController
    }
}
