//
//  MoleculeCoordinator.swift
//  DNAKitConsumer
//
//  Created by Shivani on 29/01/20.
//  Copyright © 2020 designSystem. All rights reserved.
//

import UIKit

class MoleculeCoordinator: Coordinator {
    
    var presentingViewController: UINavigationController
    var moleculeViewController: MoleculeViewController!
    
    
    init(presentingViewController: UINavigationController) {
        self.presentingViewController = presentingViewController
    }
    
    func start() {
        moleculeViewController = MoleculeViewController()
        presentingViewController.pushViewController(moleculeViewController, animated: true)
    }
    
}
