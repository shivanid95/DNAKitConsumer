//
//  ColorsModel.swift
//  DNAKitConsumer
//
//  Created by Shivani on 27/01/20.
//  Copyright © 2020 designSystem. All rights reserved.
//

import UIKit
import DNAKit


protocol ColorsModelProtocol {
    func numberOfColors() -> Int
    func colorObject(at index: Int) -> ColorObject
}


struct ColorObject {
    var color: UIColor
    var displayName: String
    var textTintColor: UIColor
    
}

struct ColorsModel: ColorsModelProtocol {
    
    private let colors = [
        ColorObject(color: Color.appPrimary, displayName: "App primary", textTintColor: Color.appWhite),
        ColorObject(color: Color.backgroundDark, displayName: "Background Dark", textTintColor: Color.appWhite),
        ColorObject(color: Color.backgroundLight, displayName: "Background Light", textTintColor: Color.fontDark),
        ColorObject(color: Color.accentDark, displayName: "Accent Dark",  textTintColor: Color.appWhite),
        ColorObject(color: Color.accentLight, displayName: "Accent Light", textTintColor: Color.fontDark),
        ColorObject(color: Color.borderLight, displayName: "Border Light", textTintColor: Color.fontDark),
        ColorObject(color: Color.borderRegular, displayName: "Border Regualr", textTintColor: Color.appWhite),
        ColorObject(color: Color.backgroundDark, displayName: "Border Dark", textTintColor: Color.appWhite),
        ColorObject(color: Color.fontLight, displayName: "Font Light", textTintColor: Color.fontDark),
        ColorObject(color: Color.fontNormal, displayName: "Font Normal", textTintColor: Color.appWhite),
        ColorObject(color: Color.fontDark, displayName: "Font Dark", textTintColor: Color.appWhite),
        ColorObject(color: Color.link, displayName: "Link", textTintColor: Color.appWhite),
        ColorObject(color: Color.brandWarning, displayName: "Warning", textTintColor: Color.fontDark),
        ColorObject(color: Color.dangerRed, displayName: "Danger Red", textTintColor: Color.appWhite),
        ColorObject(color: Color.successGreen, displayName: "Success Green", textTintColor: Color.appWhite),
        
    ]
    
    func numberOfColors() -> Int {
        return colors.count
    }
    
    func colorObject(at index: Int) -> ColorObject {
        return colors[index]
    }
    
}
