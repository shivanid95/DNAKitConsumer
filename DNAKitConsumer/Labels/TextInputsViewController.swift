//
//  TextInputsViewController.swift
//  DNAKitConsumer
//
//  Created by Shivani on 23/01/20.
//  Copyright © 2020 designSystem. All rights reserved.
//

import UIKit
import DNAKit


class TextInputViewController: UIViewController {
    
    private enum InputType: String, CaseIterable{
        case textField
        case textView
        
        var title: String {
            switch self {
            case .textField:
                return "Text Field"
            case .textView:
                return "Text View"
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.appWhite
        self.title = "Text Inputs"
        
    }
    
    
    //MARK: - UI Components
    
    fileprivate let scrollView: UIScrollView = {
        let sv = UIScrollView()
        return sv
    }()
    
    fileprivate lazy var segmentControl: UISegmentedControl = {
        let items = InputType.allCases.map({ (val) -> String in
            return val.rawValue
        })
        let segment = UISegmentedControl(items: items)
        segment.addTarget(self, action: #selector(segmentValueChanged(_:)), for: .valueChanged)
        return segment
    }()
    
    //Email
    fileprivate let emailLabel: DNALabel = {
        let label = DNALabel(withType: Typography.body(.regular(.product)), text: "Email")
        return label
    }()
    
    fileprivate let emailTextField: DNATextField = {
        let textField = DNATextField(withState: .normal)
        textField.validationRules = [.nonEmpty, .email]
        textField.placeholder = "Enter Email ID"
        return textField
    }()
    
    //Password
    fileprivate let passwordLabel: DNALabel = {
        let label = DNALabel(withType: Typography.body(.regular(.product)), text: "Password")
        return label
    }()
    
    fileprivate let passwordTextFeild: DNATextField = {
        let textField = DNATextField(withState: .normal)
        textField.validationRules = [.greaterThan(minValue: 5)]
        textField.placeholder = "Enter Password"
        
        return textField
    }()
    
    //Name
    fileprivate let nameLabel: DNALabel = {
        let label = DNALabel(withType: Typography.body(.regular(.product)), text: "Name")
        return label
    }()
    
    fileprivate let nameTextFeild: DNATextField = {
        let textField = DNATextField(withState: .normal)
        textField.validationRules = [.nonEmpty, .name]
        textField.placeholder = "Enter name"
        return textField
    }()
    
    //Phone
    fileprivate let phoneLabel: DNALabel = {
        let label = DNALabel(withType: Typography.body(.regular(.product)), text: "Phone No.")
        return label
    }()
    
    fileprivate let phoneTextFeild: DNATextField = {
        let textField = DNATextField(withState: .normal)
        textField.validationRules = [.phoneNumber]
        textField.placeholder = "Enter phone number"
        return textField
    }()
    
    //Non Empty
    fileprivate let nonEmptyLabel: DNALabel = {
        let label = DNALabel(withType: Typography.body(.regular(.product)), text: "Non Empty")
        return label
    }()
    
    fileprivate let nonEmptyTextFeild: DNATextField = {
        let textField = DNATextField(withState: .normal)
        textField.validationRules = [.name]
        return textField
    }()
    
    //Text View
    fileprivate let textView: DNATextView = {
        let tv = DNATextView(validationRules: [.nonEmpty])
        tv.placeholderText = "Enter some text"
        return tv
    }()
    
    
    fileprivate var textFieldStack: UIStackView!
    
    fileprivate var textViewStack: UIStackView!
    
    
    //MARK: - Initialize
    
    init() {
        super.init(nibName: nil, bundle: nil)
        segmentControl.selectedSegmentIndex = 0
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Setup
    
    func setup() {
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        textFieldStack = UIView().stack(
            UIView().hstack(nameLabel.withWidth(view.bounds.width * 0.2), nameTextFeild, spacing: 16),
            UIView().hstack(emailLabel.withWidth(view.bounds.width * 0.2),emailTextField, spacing: 16),
            UIView().hstack(passwordLabel.withWidth(view.bounds.width * 0.2),passwordTextFeild, spacing: 16),
            UIView().hstack(nonEmptyLabel.withWidth(view.bounds.width * 0.2), nonEmptyTextFeild, spacing: 16),
            spacing: 40,
            alignment: .fill,
            distribution: .fill)
        
        textViewStack = UIView().stack(textView.withHeight(160))
        
        scrollView.stack(segmentControl, textFieldStack, textViewStack,
                         spacing: 40,
                         alignment: .fill,
                         distribution: .fill)
            .withMargins(.allSides(16))
            .withWidth(view.bounds.width)
        nameLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    @objc func segmentValueChanged(_ sender: UISegmentedControl) {
        guard let inputType = InputType(rawValue: sender.titleForSegment(at: sender.selectedSegmentIndex)!) else {
            return
        }
        
        switch inputType {
        case .textField:
            textFieldStack.isHidden = false
            textViewStack.isHidden = true
        case .textView:
            textFieldStack.isHidden = true
            textViewStack.isHidden = false
        }
    }
    
    
}
