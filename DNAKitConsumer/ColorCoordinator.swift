//
//  ColorCoordinator.swift
//  DNAKitConsumer
//
//  Created by Shivani on 27/01/20.
//  Copyright © 2020 designSystem. All rights reserved.
//

import UIKit

class ColorCoordiantor: Coordinator {
    
    var presentingViewController: UINavigationController
    var colorsViewController: ColorsViewController!
    
    
    init(presentingViewController: UINavigationController) {
        self.presentingViewController = presentingViewController
    }
    
    func start() {
        let model = ColorsModel()
        colorsViewController = ColorsViewController(model: model)
        presentingViewController.pushViewController(colorsViewController, animated: true)
    }
}
