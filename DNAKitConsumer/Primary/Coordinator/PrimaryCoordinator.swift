//
//  PrimaryCoordinator.swift
//  DNAKitConsumer
//
//  Created by Shivani on 22/01/20.
//  Copyright © 2020 designSystem. All rights reserved.
//

import UIKit

protocol PrimaryCoordinatorDelegate: class {
    func show(_ screenType: PrimaryCoordinator.SecondaryScreen)
    
}

class PrimaryCoordinator: Coordinator {
    
    enum SecondaryScreen {
        case typography
        case buttons
        case textInput
        case labels
        case colors
        case images
        case molecule
        
        
        
        var key: String {
            
            switch self {
            case .typography:
                return "typography"
                
            case .buttons:
                return "buttons"
                
            case .textInput:
                return "textInput"
                
            case .labels:
                return "labels"
                
            case .colors:
                return "colors"
                
            case .images:
                return "images"
                
            case .molecule:
                return "molecule"
                
            }
            
        }
        
    }
    
    var window: UIWindow
    
    var navigationController: UINavigationController!
    
    var primaryViewController: PrimaryViewController!
    
    private var coordinators: [String: Coordinator] = [:]
    
    init(window: UIWindow ) {
        self.window = window
    }
    
    
    func start() {
        
        let model = PrimaryDataModel()
        primaryViewController = PrimaryViewController(model: model)
        navigationController = UINavigationController(rootViewController: primaryViewController)
        navigationController?.navigationBar.prefersLargeTitles = true
        
        window.rootViewController = navigationController
        primaryViewController.coordinatorDelegate = self
    }
}

extension PrimaryCoordinator: PrimaryCoordinatorDelegate {
    
    func show(_ screenType: PrimaryCoordinator.SecondaryScreen) {
        switch screenType {
        case .typography:
            let typographyCoordinator = TypographyCoordinator(presentingViewController: self.navigationController)
            coordinators[screenType.key] = typographyCoordinator
            typographyCoordinator.start()
            
        case .buttons:
            let buttonCoordinator = ButtonsCoordinator(presentingViewController: self.navigationController)
            coordinators[screenType.key] = buttonCoordinator
            buttonCoordinator.start()
            
        case .textInput:
            let textInputCoordinator = TextInputsCoordinator(presentingViewController: self.navigationController)
            coordinators[screenType.key] = textInputCoordinator
            textInputCoordinator.start()
            
        case .labels:
            let labelsCoordiantor = LabelsCoordinator(presentingViewController: navigationController)
            coordinators[screenType.key] = labelsCoordiantor
            labelsCoordiantor.start()
            
        case .colors:
            let colorsCoordinator = ColorCoordiantor(presentingViewController: navigationController)
            coordinators[screenType.key] = colorsCoordinator
            colorsCoordinator.start()
            
        case .images:
            let imageCoordinator = ImagesCoordinator(presentingViewController: navigationController)
            coordinators[screenType.key] = imageCoordinator
            imageCoordinator.start()
            
        case .molecule:
            let moleculeCoordinator = MoleculeCoordinator(presentingViewController: navigationController)
            coordinators[screenType.key] = moleculeCoordinator
            moleculeCoordinator.start()
            
        }
    }
    
}
