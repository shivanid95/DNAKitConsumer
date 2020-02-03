//
//  LabelsModel.swift
//  DNAKitConsumer
//
//  Created by Shivani on 27/01/20.
//  Copyright © 2020 designSystem. All rights reserved.
//

import Foundation
import DNAKit


protocol LabelsModelProtocol {
    
    func numberOfTypographyComponents() -> Int
    func numberOfTypographyItems(in component: Int) -> Int
    func titleForTypographyAt(row: Int, component: Int) -> String?
    func typographyFor(row: Int, component: Int) -> Typography?
    
    func numberTitleFor(row: Int) -> String?
    func numberOfItemsForNumericLabel() -> Int
    func numberOfNumericComponents() -> Int
    
    func numberTypeFor(index: Int, currentNumberType: DNANumberType, isSigned: Bool) -> DNANumberType
    
}


struct LabelsModel: LabelsModelProtocol {
    struct LabelType {
        var typography: Typography
        var displayName: String
    }
    
    private let labelTypes =  [
        LabelType(typography: .h1(.product), displayName: "Heading 1"),
        LabelType(typography: .h2(.product), displayName: "Heading 2"),
        LabelType(typography: .h3(.product), displayName: "Heading 3"),
        LabelType(typography: .body(.large(.product)), displayName: "Body Large"),
        LabelType(typography: .body(.regular(.product)), displayName: "Body Regular"),
        LabelType(typography: .body(.small(.product)), displayName: "Body Small"),
        LabelType(typography: .caption, displayName: "Caption"),
        
    ]
    
    enum NumberTypes: Int, CaseIterable {
        case percentage
        case amount
        case number
        case change
        
        var title: String {
            switch self {
            case .percentage: return "Percentage"
            case .amount: return "Amount"
            case .change : return "Change"
            case .number : return "Number"
            }
        }
    }
    
    
    
    func numberOfTypographyComponents() -> Int {
        return 2
    }
    
    func numberOfTypographyItems(in component: Int) -> Int {
        switch component {
        case 0: return 2
        case 1: return labelTypes.count
        default: return 0
        }
        
    }
    
    func titleForTypographyAt(row: Int, component: Int) -> String? {
        switch component {
        case 0:
            return row == 0 ? "Product" : "Blog"
        case 1:
            return labelTypes[row].displayName
            
        default:
            return nil
        }
    }
    
    func typographyFor(row: Int, component: Int) -> Typography? {
        let contentType = component == 0 ? ContentType.product : .blog
        let typography = labelTypes[row].typography
        
        switch typography {
        case .h1:
            return Typography.h1(contentType)
        case .h2:
            return Typography.h2(contentType)
        case .h3:
            return Typography.h3(contentType)
        case .body(.small(_)):
            return .body(.small(contentType))
        case .body(.regular(_)):
            return .body(.regular(contentType))
        case .body(.large(_)):
            return .body(.large(contentType))
        default:
            return typography
        }
    }
    
    
    //MARK: - Number Picker DS
    
    func numberOfNumericComponents() -> Int {
        return 1
    }
    
    func numberOfItemsForNumericLabel() -> Int {
        return NumberTypes.allCases.count
    }
    
    func numberTitleFor(row: Int) -> String? {
        return NumberTypes(rawValue: row)?.title
    }
    
    func numberTypeFor(index: Int, currentNumberType: DNANumberType, isSigned: Bool = false) -> DNANumberType {
        
        let numType = NumberTypes(rawValue: index)
        
        switch numType! {
            
        case .amount:
            switch currentNumberType {
            case let .change(color, font, _):
                return .amount(color, font: font, unit: nil)
            case let .number(color, font, _):
                return .amount(color, font: font, unit: nil)
            case let .percentage(color, font, _):
                return .amount(color, font: font, unit: nil)
            default:
                return currentNumberType
            }
            
        case .change:
            switch currentNumberType {
            case let .amount(color, font, _):
                return .change(color, font: font, signed: isSigned)
                
            case let .number(color, font, signed):
                return .change(color, font: font, signed: signed)
            case let .percentage(color, font, signed):
                return .change(color, font: font, signed: signed)
            default:
                return currentNumberType
            }
            
        case .number:
            switch currentNumberType {
            case let .amount(color, font, _):
                return .number(color, font: font, signed: isSigned)
            case let .percentage(color, font, signed):
                return .number(color, font: font, signed: signed)
            case let .change(color, font, signed):
                return .number(color, font: font, signed: signed)
            default:
                return currentNumberType
                
            }
            
        case .percentage:
            switch currentNumberType {
            case let .amount(color, font, _):
                return .percentage(color, font: font, signed: isSigned)
            case let .change(color, font, signed):
                return .percentage(color, font: font, signed: signed)
            case let .number(color, font, signed):
                return .percentage(color, font: font, signed: signed)
            default:
                return currentNumberType
            }
            
            
        }
        
    }
}
