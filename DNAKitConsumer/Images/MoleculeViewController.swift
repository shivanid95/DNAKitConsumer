//
//  MoleculeViewController.swift
//  DNAKitConsumer
//
//  Created by Shivani on 29/01/20.
//  Copyright © 2020 designSystem. All rights reserved.
//

import UIKit
import DNAKit



class MoleculeViewController : UIViewController {
    
    fileprivate var headerLabel: DNALabel = {
        let label = DNALabel(withType: .h1(.blog), text: "Coming Soon!")
        return label
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.appWhite
        view.addSubview(headerLabel)
        headerLabel.centerInSuperview()
    }
}
