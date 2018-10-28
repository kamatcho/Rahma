//
//  AMTextField.swift
//  Ekeif
//
//  Created by Amr Mohamed on 9/13/16.
//  Copyright © 2016 Amr Mohamed. All rights reserved.
//

import Foundation
import UIKit

class AMTextField : UITextField {
    
    var imageView : UIImageView?
    
    @IBInspectable var image : UIImage! {
        didSet {
            self.imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
            self.imageView?.image = image
            self.leftView = imageView
            self.leftViewMode = .always
            self.imageView?.tintColor = self.unselectedColor
        }
    }
    
    @IBInspectable var placeholderColor: UIColor = UIColor.white.withAlphaComponent(0.5) {
        didSet {
            let placeholderString = NSAttributedString(string: placeholder!, attributes: [NSForegroundColorAttributeName: self.placeholderColor])
            self.attributedPlaceholder = placeholderString
        }
    }
    
    @IBInspectable var missingColor: UIColor = UIColor.red
    @IBInspectable var selectedColor: UIColor = UIColor(red:0.99, green:0.72, blue:0.07, alpha:1.00)
    @IBInspectable var unselectedColor: UIColor = UIColor.white
    
    var border = CALayer()
    override var isSelected : Bool {
        didSet {
            self.imageView?.tintColor = self.isSelected ? self.selectedColor : self.unselectedColor
            self.border.backgroundColor = self.isSelected ? self.selectedColor.cgColor : self.unselectedColor.cgColor
        }
    }
    
    var isMissing : Bool = false {
        didSet {
            self.imageView?.tintColor = self.isMissing ? self.missingColor : self.unselectedColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    func commonInit() {
        self.isSelected = false
        self.addBorder(self.unselectedColor, thickness: 1.0)
        self.placeholderColor = UIColor.white
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.updateBorder(thickness: 1.0)
    }
    
    override func becomeFirstResponder() -> Bool {
        let value = super.becomeFirstResponder()
        if value {
            self.isSelected = true
        }
        return value
    }
    
    override func resignFirstResponder() -> Bool {
        let value = super.resignFirstResponder()
        if value {
            self.isSelected = false
        }
        return value
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let padding = self.imageView!.bounds.width + 15
        if UIView.userInterfaceLayoutDirection(for: self.semanticContentAttribute) == UIUserInterfaceLayoutDirection.rightToLeft {
            return CGRect(x: bounds.origin.x + 8, y: bounds.origin.y + 8, width: bounds.size.width - padding, height: bounds.size.height - 16)
        }
        return CGRect(x: bounds.origin.x + padding, y: bounds.origin.y + 8, width: bounds.size.width, height: bounds.size.height - 16)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return self.textRect(forBounds: bounds);
    }
    
    func addBorder(_ color: UIColor, thickness: CGFloat) {
        DispatchQueue.main.async {
            self.border.frame = CGRect(x: 0, y: self.layer.frame.height - thickness, width: self.layer.frame.width, height: thickness)
            self.border.backgroundColor = color.cgColor;
            self.layer.addSublayer(self.border)
        }
    }
    
    func updateBorder(thickness: CGFloat) {
        self.border.frame = CGRect(x: 0, y: self.layer.frame.height - thickness, width: self.layer.frame.width, height: thickness)
    }
    
}
