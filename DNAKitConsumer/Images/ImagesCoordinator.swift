//
//  ImagesCoordinator.swift
//  DNAKitConsumer
//
//  Created by Shivani on 28/01/20.
//  Copyright © 2020 designSystem. All rights reserved.
//

import UIKit


class ImagesCoordinator: Coordinator {
    
    var presentingViewController: UINavigationController
    
    var imageViewController: ImageViewController!
    
    init(presentingViewController: UINavigationController) {
        self.presentingViewController = presentingViewController
    }
    
    func start() {
        imageViewController = ImageViewController()
        presentingViewController.pushViewController(imageViewController, animated: true)
    }
}
