//
//  CircleButton.swift
//  SpeechRecognitionApp
//
//  Created by Ammad on 06/04/2017.
//  Copyright © 2017 Ammad. All rights reserved.
//


import UIKit
@IBDesignable
class CircleButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 30.0 {
        didSet {
            setupView()
        }
    }
    
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    
    func setupView() {
        layer.cornerRadius = cornerRadius
    }

}
