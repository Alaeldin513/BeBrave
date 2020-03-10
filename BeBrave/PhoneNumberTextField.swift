//
//  NameTextField.swift
//  BeBrave
//
//  Created by Alaeldin Tirba on 2/22/20.
//  Copyright © 2020 Alaeldin Tirba. All rights reserved.
//

import Foundation
import ATGValidator
import UIKit
extension UITextField {
    func setLeft(image: UIImage) {
        self.leftViewMode = .always
        let imageView = UIImageView()
        let newImage = image.withRenderingMode(.alwaysTemplate)
        imageView.image = newImage
        imageView.tintColor = .white
        imageView.frame = CGRect(x:0, y: 0, width: self.frame.height-10, height: self.frame.height-10)
        self.leftView = imageView
    }
    
    func addSingleLineSublayer(color: UIColor){
        let borderLayer = CALayer()
        borderLayer.borderColor = color.cgColor
        borderLayer.name = "line"
        borderLayer.frame = CGRect(origin: CGPoint(x: 0.0, y: (self.frame.size.height-3)), size: CGSize(width: self.frame.size.width, height: 3.0))
        borderLayer.borderWidth = 3.0
        layer.borderColor = UIColor.clear.cgColor
        borderStyle = .none
        layer.addSublayer(borderLayer)
    }
    
    func getTextfieldErrorFrom(formValidatorErrors: [ValidationError]) -> ValidationError? {
        if let textFieldPossibleErrors = self.validationRules?.flatMap({$0.error}) as! [ValidationError]?{
            for textFieldError in textFieldPossibleErrors {
                if formValidatorErrors.contains(textFieldError) ?? false {
                    return textFieldError
                }
        }
        }
        return nil
    }
    
    func setPlaceHolder(text: String) {
        let color = UIColor.lightText
        self.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor:color])
    }
}

class NameTextField: UITextField {
    var validationErrorMessage = String.nameFieldTooShortErrorMessage
    override func awakeFromNib() {
        super.awakeFromNib()
        self.validationRules = [StringLengthRule.min(1)]
        if let image = UIImage(named: "icons8-contacts-50") {
            self.setLeft(image: image)
        }
        setPlaceHolder(text: "First Name")
        addSingleLineSublayer(color: .white)
    }
    
}

class PhoneNumberTextField: UITextField {
    var validationErrorMessage = String.enterValidPhoneNumberErrorMessage
    override func awakeFromNib() {
        super.awakeFromNib()
        self.validationRules = [
            StringRegexRule.numbersOnly,
            StringLengthRule.equal(to: 10)
        ]
        if let image = UIImage(named: "icons8-phone-50") {
            self.setLeft(image: image)
        }
        setPlaceHolder(text: "Phone Number")
        addSingleLineSublayer(color: .white)
    }
}

class EmailTextField: UITextField {
    var validationErrorMessage = String.nameFieldTooShortErrorMessage
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.validationRules = [
            StringRegexRule.email
        ]
        if let image = UIImage(named: "icons8-email-open-50") {
            self.setLeft(image: image)
        }
        setPlaceHolder(text: "Email")
        addSingleLineSublayer(color: .white)
    }
}

class PasswordTextField: UITextField {
    var validationErrorMessage = String.passwordTooShortErrorMessage
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.validationRules = [
            StringLengthRule.min(8)
        ]
        if let image = UIImage(named: "icons8-password-50") {
            self.setLeft(image: image)
        }
        addSingleLineSublayer(color: .white)
        setPlaceHolder(text: "Password")
    }
}


