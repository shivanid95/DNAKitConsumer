//
//  LabelsCoordinator.swift
//  DNAKitConsumer
//
//  Created by Shivani on 23/01/20.
//  Copyright © 2020 designSystem. All rights reserved.
//

import UIKit

class LabelsCoordinator: Coordinator {
    
    var presentingViewController: UINavigationController
    var labelsViewController: LabelsViewController!
    
    
    init(presentingViewController: UINavigationController) {
        self.presentingViewController = presentingViewController
    }
    
    func start() {
        labelsViewController = LabelsViewController(model: LabelsModel())
        presentingViewController.pushViewController(labelsViewController, animated: true)
    }
}
