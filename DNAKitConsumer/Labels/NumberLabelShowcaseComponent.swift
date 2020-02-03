//
//  NumberLabelShowcaseComponent.swift
//  DNAKitConsumer
//
//  Created by Shivani on 28/01/20.
//  Copyright © 2020 designSystem. All rights reserved.
//

import UIKit
import DNAKit



class NumberLabelShowcaseComponent: UIView {
    
    var numberType: DNANumberType = DNANumberType.number(.uncolored, font: DNANumberType.Font.large(.semibold), signed: false) {
        didSet{
            exampleNumberLabel.numberType = numberType
        }
    }
    
    var isSigned: Bool {
        return signedSwitch.isOn
        
    }
    
    fileprivate let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    fileprivate let signedSwitch: UISwitch = {
        let switchView = UISwitch()
        switchView.addTarget(self, action: #selector(signedSwitchValueChanged(_:)), for: .valueChanged)
        return switchView
    }()
    
    
    fileprivate let colorSwitch: UISwitch = {
        let switchView = UISwitch()
        switchView.addTarget(self, action: #selector(colorTypeChanged(_:)), for: .valueChanged)
        return switchView
    }()
    
    fileprivate let titleLabel: DNALabel = {
        let label = DNALabel(withType: .h3(.product), text: "")
        return label
    }()
    
    fileprivate let settingsLabel: DNALabel = {
        let label = DNALabel(withType: .h3(.product), text: "Label Settings")
        label.textColor = Color.fontLight
        return label
    }()
    
    fileprivate let generateRandomButton: DNABaseButton = {
        let button = DNABaseButton(title: "Generate Random Number", type: DNAButtonType.primaryAccent, height: .large)
        
        return button
    }()
    
    fileprivate let signDescriptionLabel: DNALabel = {
        let label = DNALabel(withType: .body(.regular(.product)), text: "Show signed value?")
        label.textColor = Color.fontNormal
        return label
    }()
    
    fileprivate let colorDescriptionLabel: DNALabel = {
        let label = DNALabel(withType: .body(.regular(.product)), text: "Show colored value?")
        label.textColor = Color.fontNormal
        return label
    }()
    
    
    fileprivate lazy var exampleNumberLabel: DNANumericLabel = {
        let label = DNANumericLabel(withNumberType: numberType)
        return label
    }()
    
    //MARK: - Initialize
    
    init() {
        super.init(frame: .zero)
        setup()
        generateRandomButton.action { [weak self] _ in
            self?.exampleNumberLabel.value = Double.random(in: -100..<100)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup
    
    func setup() {
        addSubview(containerView)
        containerView.fillSuperview(padding: .allSides(16))
        
        let signedStack = UIView().hstack(signDescriptionLabel, signedSwitch, spacing: 16, alignment: .fill, distribution: .fill)
        let colorStack = UIView().hstack(colorDescriptionLabel, colorSwitch, spacing: 16, alignment: .fill, distribution: .fill)
        let valueStack = UIView().stack(generateRandomButton, exampleNumberLabel, spacing: 16, alignment: .center, distribution: .fill)
        
        containerView.stack(titleLabel, settingsLabel, signedStack, colorStack, valueStack,
                            spacing: 16,
                            alignment: .fill,
                            distribution: .fill)
        
    }
    
    @objc func signedSwitchValueChanged(_ sender: UISwitch?) {
        
        switch numberType {
        case let .number(color, font, signed):
            numberType = DNANumberType.number(color, font: font, signed: !signed)
        case let .percentage(color, font, signed):
            numberType = DNANumberType.percentage(color, font: font, signed: !signed)
        case let .change(color, font, signed):
            numberType = DNANumberType.change(color, font: font, signed: !signed)
        default:
            return
        }
        
    }
    
    @objc func colorTypeChanged(_ sender: UISwitch) {
        let colorType = sender.isOn ? DNANumberType.Color.colored : .uncolored
        
        
        switch numberType {
        case let .number(_, font, signed):
            numberType = DNANumberType.number(colorType, font: font, signed: signed)
        case let .percentage(_, font, signed):
            numberType = DNANumberType.percentage(colorType, font: font, signed: signed)
        case let .change(_, font, signed):
            numberType = DNANumberType.change(colorType, font: font, signed: signed)
        case let .amount(_, font, unit):
            numberType = DNANumberType.amount(colorType, font: font, unit: unit)
        }
        
    }
    
}
