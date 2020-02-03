//
//  LabelsViewController.swift
//  DNAKitConsumer
//
//  Created by Shivani on 23/01/20.
//  Copyright © 2020 designSystem. All rights reserved.
//

import UIKit
import DNAKit

class LabelsViewController: UIViewController {
    
    enum Constant {
        static let typographyPickerTag = 100
        static let numberPickerTag = 200
    }
    
    var model: LabelsModelProtocol
    
    var typography: Typography? {
        didSet {
            typographyValueLabel.type = typography
        }
    }
    
    
    //MARK: - UI Components
    
    fileprivate let scrollView: UIScrollView = {
        let sv = UIScrollView()
        return sv
    }()
    
    fileprivate let typographyContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.appWhite
        view.layer.cornerRadius = 5
        return view
    }()
    
    fileprivate lazy var typographyPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.showsSelectionIndicator = true
        pickerView.tag = Constant.typographyPickerTag
        
        pickerView.backgroundColor = Color.backgroundLight
        return pickerView
    }()
    
    fileprivate lazy var typographyTextField: DNATextField = {
        let textField = DNATextField(withState: .normal)
        textField.inputView = typographyPickerView
        textField.placeholder = "Select typography for label"
        textField.delegate = self
        textField.inputAccessoryView = typographyPickerAccessoryView
        return textField
    }()
    
    fileprivate let typographyDescriptionLabel: DNALabel = {
        let label = DNALabel(withType: Typography.h2(.product), text: "DNALabel")
        return label
    }()
    
    fileprivate let typographyValueLabel: DNALabel = {
        let label = DNALabel()
        label.text = "Example Text: A quick brown fox jumps over a little dog."
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    fileprivate let typographyPickerAccessoryView: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.barTintColor = Color.accentDark
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.tintColor = Color.appWhite
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(onClickPickerCancel(sender:)))
        cancelButton.tag = Constant.typographyPickerTag
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(onClickPickerDone(sender:)))
        doneButton.tag = Constant.typographyPickerTag
        toolbar.setItems([cancelButton, doneButton], animated: true )
        return toolbar
    }()
    
    
    
    //Numeric Labels
    
    fileprivate let numericContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.appWhite
        view.layer.cornerRadius = 5
        return view
    }()
    
    fileprivate let numericDescriptionLabel: DNALabel = {
        let label = DNALabel(withType: Typography.h2(.product), text: "DNA Numeric Label")
        return label
    }()
    
    fileprivate lazy var numberTypeTextfield: DNATextField = {
        let textField = DNATextField(withState: .normal)
        textField.inputView = numberTypePicker
        textField.placeholder = "Select numeric label type"
        textField.delegate = self
        textField.inputAccessoryView = numberPickerAccessoryView
        return textField
    }()
    
    fileprivate lazy var numberTypePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        picker.tag = Constant.numberPickerTag
        picker.showsSelectionIndicator = true
        picker.backgroundColor = Color.appWhite
        return picker
    }()
    
    fileprivate let numberPickerAccessoryView: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.barTintColor = Color.accentDark
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.tintColor = Color.appWhite
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(onClickPickerCancel(sender:)))
        cancelButton.tag = Constant.numberPickerTag
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(onClickPickerDone(sender:)))
        doneButton.tag = Constant.numberPickerTag
        toolbar.setItems([cancelButton, doneButton], animated: true )
        return toolbar
    }()
    
    fileprivate let numberShowcaseView: NumberLabelShowcaseComponent = {
        let view = NumberLabelShowcaseComponent()
        return view
    }()
    
    //MARK: - Initialize
    
    init(model: LabelsModelProtocol) {
        
        self.model = model
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Labels"
        view.backgroundColor = Color.backgroundLight
    }
    
    //MARK:- Setup
    
    
    func setup() {
        
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        typographyContainerView.stack(typographyDescriptionLabel, typographyTextField, typographyValueLabel,
                                      spacing: 16,
                                      alignment: .fill,
                                      distribution: .fill)
            .withMargins(
                .init(top: 24, left: 8, bottom: 24, right: 8))
        
        numericContainerView.stack(numericDescriptionLabel, numberTypeTextfield, numberShowcaseView,
                                   spacing: 16,
                                   alignment: .fill,
                                   distribution: .fill)
            .withMargins(
                .init(top: 24, left: 8, bottom: 24, right: 8))
        
        scrollView.stack(typographyContainerView, numericContainerView,
                         spacing: 48,
                         alignment: .fill,
                         distribution: .fill)
            .withMargins(.allSides(16))
            .withWidth(view.bounds.width)
        
    }
    
    //MARK: - Actions
    
    @objc func onClickPickerCancel(sender: UIBarButtonItem?) {
        
        switch sender!.tag {
        case Constant.numberPickerTag:
            numberTypeTextfield.endEditing(true)
            
        case Constant.typographyPickerTag:
            typographyTextField.endEditing(true)
            
        default:
            return
        }
        
    }
    
    @objc func onClickPickerDone(sender: UIBarButtonItem?) {
        
        switch sender!.tag {
        case Constant.numberPickerTag:
            let title = model.numberTitleFor(row: numberTypePicker.selectedRow(inComponent: 0))
            numberTypeTextfield.text = title
            numberShowcaseView.numberType = model.numberTypeFor(index: numberTypePicker.selectedRow(inComponent: 0), currentNumberType: numberShowcaseView.numberType, isSigned: numberShowcaseView.isSigned)
            
        case Constant.typographyPickerTag:
            let selectedContentType = typographyPickerView.selectedRow(inComponent: 0)
            let selectedTextType = typographyPickerView.selectedRow(inComponent: 1)
            let str1 =  model.titleForTypographyAt(row: selectedContentType, component: 0)
            let str2 = model.titleForTypographyAt(row: selectedTextType, component: 1)
            typographyTextField.text = "\(str1!) \(str2!)"
            typography = model.typographyFor(row: selectedTextType, component: selectedContentType)
            
        default :
            return
        }
        
        
        
    }
    
}


extension LabelsViewController: UIPickerViewDelegate {
    
}

extension LabelsViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        switch pickerView.tag {
        case Constant.numberPickerTag:
            return model.numberOfNumericComponents()
        case Constant.typographyPickerTag:
            return model.numberOfTypographyComponents()
        default:
            return 0
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch pickerView.tag {
        case Constant.numberPickerTag:
            return model.numberOfItemsForNumericLabel()
        case Constant.typographyPickerTag:
            return model.numberOfTypographyItems(in: component)
        default:
            return 0
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch pickerView.tag {
        case Constant.numberPickerTag:
            return model.numberTitleFor(row: row)
        case Constant.typographyPickerTag:
            return model.titleForTypographyAt(row: row, component: component)
        default:
            return nil
        }
        
    }
    
    
}


extension LabelsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
}

