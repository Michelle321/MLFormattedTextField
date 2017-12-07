//
//  MLFormattedNumberField.swift
//  MLFormattedTextField_Example
//
//  Created by Michelle Li on 2017-12-07.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

// Copyright (c) 2017 Michelle <yunjuan.li@gmail.com>

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

public class MLFormattedTextField : UITextField {
    
    public static var numberPlaceHolderSymbol = "X"
    public static var letterPlaceHolderSymbol = "L"
    
    public var format : String? = nil
    public var prefix : String = ""
    public var originalDelegate : UITextFieldDelegate? = nil
    
    override public var delegate: UITextFieldDelegate? {
        get {
            return originalDelegate
        }
        set {
            originalDelegate = newValue
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        super.delegate = self
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        super.delegate = self
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        super.delegate = self
    }
}

extension MLFormattedTextField : UITextFieldDelegate {
    //delegete all the other work to super
    override public func responds(to aSelector: Selector!) -> Bool {
        var repondsToSelector = super.responds(to: aSelector)
        
        if (!repondsToSelector && self.originalDelegate != nil) {
            repondsToSelector = (self.originalDelegate?.responds(to: aSelector)) ?? false
        }
        
        return repondsToSelector
    }
    
    override public func forwardingTarget(for aSelector: Selector!) -> Any? {
        if (self.originalDelegate != nil  && self.originalDelegate?.responds(to: aSelector) == true) {
            return self.originalDelegate
        }
        return super.forwardingTarget(for: aSelector)
    }
    
    // UITextFieldDelegate Method
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if !self.prefix.isEmpty{
            if textField.text == nil || textField.text?.isEmpty == true{
                textField.text = self.prefix
            }
        }
        
        if (self.originalDelegate != nil && self.originalDelegate?.responds(to: #selector(textFieldShouldBeginEditing(_:))) == true){
            return self.originalDelegate!.textFieldShouldBeginEditing!(textField)
        }
        
        return true
    }
    
    func isAnumber(c: Unicode.Scalar) -> Bool{
        return CharacterSet.decimalDigits.contains(c)
    }
    
    func isALetter(c: Unicode.Scalar) -> Bool {
        return CharacterSet.letters.contains(c)
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if var formatString = self.format {
            formatString = self.prefix + formatString
            if string.isEmpty {
                if range.location  <= self.prefix.lengthOfBytes(using: String.Encoding.utf8){
                    textField.text = ""
                }else {
                    var startIndex = formatString.index(formatString.startIndex, offsetBy: range.location - 1)
                    while String(formatString[startIndex]) != MLFormattedTextField.numberPlaceHolderSymbol && String(formatString[startIndex]) != MLFormattedTextField.letterPlaceHolderSymbol && startIndex != formatString.startIndex {
                        startIndex = formatString.index(startIndex, offsetBy: -1)
                    }
                    if let textFieldText = textField.text{
                        textField.text = String(textFieldText[...startIndex])
                    }
                }
            }else {
                let textFieldText = textField.text ?? ""
                if range.location < formatString.lengthOfBytes(using: String.Encoding.utf8) {
                    var startIndex = formatString.index(formatString.startIndex, offsetBy: range.location)
                    var replacementString = startIndex < textFieldText.endIndex ? String(textFieldText[...startIndex]) : textFieldText
                    let endIndex = formatString.endIndex
                    if range.location < self.prefix.lengthOfBytes(using: String.Encoding.utf8) {
                        replacementString = self.prefix
                        startIndex = formatString.index(formatString.startIndex, offsetBy: self.prefix.lengthOfBytes(using: .utf8))
                    }
                    for letter in string.unicodeScalars {
                        var letterAdded = false
                        while startIndex < endIndex && letterAdded == false{
                            let currentPlaceHold = String(formatString[startIndex])
                            if currentPlaceHold == MLFormattedTextField.numberPlaceHolderSymbol {
                                if isAnumber(c: letter) {
                                    replacementString += String(letter)
                                }
                                letterAdded = true
                            }else if currentPlaceHold == MLFormattedTextField.letterPlaceHolderSymbol{
                                if isALetter(c: letter) {
                                    replacementString += String(letter)
                                }
                                letterAdded = true
                            }else {
                                replacementString += currentPlaceHold
                                letterAdded = false
                            }
                            startIndex = formatString.index(after: startIndex)
                        }
                    }
                    textField.text = replacementString
                }
            }
            return false
        }
        
        if (self.originalDelegate != nil && self.originalDelegate?.responds(to: #selector(textField(_:shouldChangeCharactersIn:replacementString:))) == true){
            return self.originalDelegate!.textField!(textField, shouldChangeCharactersIn:range, replacementString: string)
        }
        
        return true
    }
    
}
