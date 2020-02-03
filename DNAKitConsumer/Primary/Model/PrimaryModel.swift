//
//  PrimaryModel.swift
//  DNAKitConsumer
//
//  Created by Shivani on 23/01/20.
//  Copyright © 2020 designSystem. All rights reserved.
//

import Foundation


enum DesignComponent: Int, CaseIterable {
    
    enum Atom: Int, CaseIterable {
        case buttons
        case labels
        case textInputs
        case imageView
        
        var title: String {
            switch self {
            case .buttons:
                return "Buttons"
                
            case .labels:
                return "Labels"
                
            case .textInputs:
                return "Text Inputs"
                
            case .imageView:
                return "Image View"
            }
        }
    }
    
    enum Core: Int, CaseIterable {
        case colorScheme
        case typography
        // case shadows
        //case images
        
        
        var title: String {
            switch self {
            case .colorScheme: return "Color Scheme"
            case .typography: return "Typography"
           
            }
        }
        
    }
    
    enum Molecule: Int, CaseIterable {
        case tooltip
        case alert
        case snackbar
        case datePicker
        case tableViewCells
        case collectionViewCells
        
        var title: String {
            switch self {
            case .tooltip: return "Tooltip"
            case .alert: return "Alerts & Action Sheets"
            case .snackbar: return "Toasts & Snackbars"
            case .datePicker: return "Date Picker"
            case .tableViewCells: return "Table View cells"
            case .collectionViewCells: return "Collection View Cells"
                
                
            }
        }
    }
    
    enum Template: Int, CaseIterable {
        case stateView
        case customTableView
        case customCollectionView
        
        var title: String {
            switch self {
            case .stateView: return "Stateful View"
            case .customTableView: return "Custom Table View"
            case .customCollectionView: return "Custom Collection View"
                
            }
        }
        
    }
    
    enum Organism: Int, CaseIterable {
        case emptyViews
        case popupViews
        
        var title: String {
            switch self {
            case .emptyViews: return "Empty State Views"
            case .popupViews: return "Popup Views"
                
            }
            
        }
    }
    
    
    enum Page: Int, CaseIterable {
        case imageViewController
        case webViewController
        case popupController
        
        var title: String {
            switch self {
            case .imageViewController: return "Image View Controller"
            case .webViewController: return "Web View Controller"
            case .popupController: return "Popup Controller"
                
            }
        }
    }
    
    
    case foundation
    case atoms
    case molecules
    case templates
    case organisms
    case pages
    
    var title: String {
        switch self {
        case .foundation:
            return "Foundation"
            
        case .atoms:
            return "Atoms"
            
        case .molecules:
            return "Molecules"
            
        case .templates:
            return "Templates"
            
        case .organisms:
            return "Organisms"
            
        case .pages:
            return "Pages"
            
        }
    }
    
    
    
}



protocol PrimaryModelProtocol {
    func numberOfDesignComponents() -> Int
    func designElementAt(index: Int) -> DesignComponent?
    
    func numberOfTableViewItems(for selectedComponent: Int) -> Int
    func tableViewItem(for selectedComponent: Int, index: Int) -> (title: String?, isExpandable: Bool)
    func screenAt(segment: Int, index: Int) -> PrimaryCoordinator.SecondaryScreen?
}

struct PrimaryDataModel: PrimaryModelProtocol  {
    
    
    func numberOfDesignComponents() -> Int {
        return DesignComponent.allCases.count
    }
    
    func designElementAt(index: Int) -> DesignComponent? {
        return DesignComponent(rawValue: index)
    }
    
    func numberOfTableViewItems(for selectedComponent: Int) -> Int {
        let designComponent = DesignComponent(rawValue: selectedComponent)
        
        switch designComponent {
            
        case .foundation:
            return DesignComponent.Core.allCases.count
        case .atoms:
            return DesignComponent.Atom.allCases.count
            
        case .molecules:
            return DesignComponent.Molecule.allCases.count
            
        case .templates:
            return DesignComponent.Template.allCases.count
            
        case .organisms:
            return DesignComponent.Organism.allCases.count
            
        case .pages:
            return DesignComponent.Page.allCases.count
            
        case .none:
            return 0
        }
    }
    
    func tableViewItem(for selectedComponent: Int, index: Int) -> (title: String?, isExpandable: Bool) {
        
        let designComponent = DesignComponent(rawValue: selectedComponent)
        
        switch designComponent {
            
        case .foundation:
            return (DesignComponent.Core(rawValue: index)?.title, true)
            
        case .atoms:
            return (DesignComponent.Atom(rawValue: index)?.title, true)
            
        case .molecules:
            return (DesignComponent.Molecule(rawValue: index)?.title, true)
            
            
        case .templates:
            return (DesignComponent.Template(rawValue: index)?.title, true)
            
            
        case .organisms:
            return (DesignComponent.Organism(rawValue: index)?.title, true)
            
            
        case .pages:
            return (DesignComponent.Page(rawValue: index)?.title, true)
            
        case .none:
            return ("" , false)
        }
        
    }
    
    
    func screenAt(segment: Int, index: Int) -> PrimaryCoordinator.SecondaryScreen? {
        let designComp = DesignComponent(rawValue: segment)
        switch designComp {
        case .foundation:
            let core = DesignComponent.Core(rawValue: index)!
            switch  core  {
            case .typography:
                return .typography
            case .colorScheme:
                return .colors

            }
            
            
        case .atoms:
            let atomType = DesignComponent.Atom(rawValue: index)
            switch atomType! {
            case .buttons:
                return .buttons
            case .textInputs:
                return .textInput
            case .labels:
                return .labels
            case .imageView:
                return .images
            }
            
        case .molecules:
            return .molecule
  
        default:
            return nil
        }
    }
}
