//
//  ComponentTVCell.swift
//  DNAKitConsumer
//
//  Created by Shivani on 23/01/20.
//  Copyright © 2020 designSystem. All rights reserved.
//

import DNAKit
import UIKit


class ComponentTVCell: UITableViewCell {
    
    
    var title: String? {
        get { return titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    //MARK: - UI Components
    
    fileprivate var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 1.0
        view.layer.borderColor = Color.borderLight.cgColor
        view.addShadow(ofType: .button)
        return view
    }()
    
    
    var titleLabel: DNALabel = {
        let label = DNALabel(withType: Typography.body(.large(.product)), text: "")
        label.textColor = Color.fontNormal
        return label
    }()
    
    
    var iconLabel: DNALabel = {
        let label = DNALabel(withType: .h3(.product), text: "🧬")
        return label
        
    }()
    
    
    //MARK:- Initialize
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK:- Setup
    
    func setup() {
        addSubview(containerView)
        containerView.fillSuperview(padding: .init(top: 8, left: 16, bottom: 8, right: 16))
        containerView.hstack(iconLabel.withSize(.init(width: 24, height: 24)), titleLabel,
                             spacing: 8,
                             alignment: .center,
                             distribution: .fill).withMargins(.init(top: 16, left: 16, bottom: 16, right: 16))
        
    }
}
