//
//  ButtonsViewController.swift
//  DNAKitConsumer
//
//  Created by Shivani on 23/01/20.
//  Copyright © 2020 designSystem. All rights reserved.
//

import UIKit
import DNAKit

class ButtonsViewController: UIViewController {
    
    //MARK: - UI Components
    
    fileprivate let scrollView: UIScrollView = {
        let sv = UIScrollView()
        return sv
    }()
    
    fileprivate lazy var segmentControl: UISegmentedControl = {
        
        let segment = UISegmentedControl(items: allStates)
        allStates.enumerated().forEach { (index, bState) in
            segment.setTitle(bState, forSegmentAt: index)
        }
        segment.addTarget(self, action: #selector(segmentValueChanged), for: .valueChanged)
        return segment
    }()
    
    fileprivate lazy var heightSlider: UISlider = {
        let slider = UISlider()
        slider.isContinuous = false
        slider.addTarget(self, action: #selector(heightSliderValueChanged(_:)), for: .valueChanged)
        slider.minimumValue = 0
        slider.maximumValue = 4
        return slider
    }()
    
    fileprivate let sliderInfoLabel: DNALabel = {
        let label = DNALabel(withType: Typography.h3(.product), text: "Select Button Height")
        return label
    }()
    
    fileprivate let sliderValueLabel: DNALabel = {
        let label = DNALabel(withType: Typography.h3(.product), text: "")
        label.textAlignment = .center
        return label
    }()
    
    //MARK:- Variables
    
    private var allStates: [String] = {
        return  DNAButtonState.allCases.map { (bState) -> String in
            return bState.rawValue
        }.filter({ (val) -> Bool in
            val != "highlighted"
        })
    }()
    
    private var buttonHeight: DNAButtonHeight = .small {
        didSet {
            if buttonHeight.value == oldValue.value { return }
            sliderValueLabel.text = getHeightStringValue(buttonHeight)
            buttons.forEach { (button) in
                button.buttonHeight = buttonHeight
            }
        }
    }
    
    
    private var buttonState: DNAButtonState! {
        didSet {
            buttons.forEach { (element) in
                element.buttonState = buttonState
            }
            //TODO: - change states for buttons
        }
    }
    
    private var buttons: [DNABaseButton]  = DNAButtonType.allCases.map { (bType) -> DNABaseButton in
        return DNABaseButton(title: bType.rawValue, type: bType, height: .small)
        
    }
    
    
    
    
    //MARK: - Initialize
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.appWhite
        sliderValueLabel.text = getHeightStringValue(buttonHeight)
        segmentControl.selectedSegmentIndex = 0
    }
    func setup() {
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        let sliderStack = UIView().stack(sliderInfoLabel, heightSlider, sliderValueLabel,
                                         spacing: 12,
                                         alignment: .fill,
                                         distribution: .fill)
        
        let stack = scrollView.stack(segmentControl, sliderStack,
                                     spacing: 24,
                                     alignment: .fill,
                                     distribution: .fill)
            .withMargins(.init(top: view.safeAreaInsets.top + 20, left: 16, bottom: view.safeAreaInsets.bottom , right: 16))
        
        buttons.forEach { (element) in
            stack.addArrangedSubview(element)
        }
        stack.withWidth(view.bounds.width)
    }
    
    
    
    
    @objc func segmentValueChanged() {
        buttonState = DNAButtonState(rawValue: allStates[segmentControl.selectedSegmentIndex])
        
    }
    
    @objc func heightSliderValueChanged(_ sender: UISlider) {
        
        let heights : [DNAButtonHeight] = [ .small, .medium, .large, .extraLarge]
        let index = min(Int(sender.value), heights.count - 1)
        buttonHeight =  heights[index]
        
    }
    
    
    func getHeightStringValue(_ buttonHeight: DNAButtonHeight) -> String {
        switch buttonHeight {
        case .small:
            return "Small"
            
        case .medium:
            return "Medium"
            
        case .large:
            return "Large"
            
        case .extraLarge:
            return "Extra Large"
            
        case .custom(let val):
            return "Custom: \(val)"
            
        }
    }
}
