//
//  AMExtensions.swift
//  Ekeif
//
//  Created by Amr Mohamed on 9/15/16.
//  Copyright © 2016 Amr Mohamed. All rights reserved.
//

import Foundation
import UIKit
import CWStatusBarNotification
import SVProgressHUD
import NVActivityIndicatorView

extension NVActivityIndicatorType {
    static var random : NVActivityIndicatorType {
        let randomTypes = [3,5,6,7,9,10,11,12,13,16,21,22,23,29,20]
        let count = UInt32(randomTypes.count - 1)
        return NVActivityIndicatorType.init(rawValue: randomTypes[Int(arc4random_uniform(count))])!
    }
}

extension UIView {
    func showActivityIndicator(shouldAdjustYAxis: Bool = true) {
        var ai = self.viewWithTag(1000) as? NVActivityIndicatorView
        if ai == nil {
            DispatchQueue.main.async {
                let frame = CGRect(x: 0, y: 0, width: 80, height: 80)
                ai = NVActivityIndicatorView(frame: frame, type: NVActivityIndicatorType.init(rawValue: 29), color: #colorLiteral(red: 0.9803921569, green: 0.7176470588, blue: 0.1921568627, alpha: 1), padding: 10)
                ai?.tag = 1000
            }
        }
        DispatchQueue.main.async {
            ai?.center = CGPoint.init(x: self.bounds.midX, y: self.bounds.midY)
            if let button = self as? UIButton {
                button.setTitleColor(UIColor.clear, for: .normal)
                ai?.color = UIColor.white
                self.superview?.insertSubview(ai!, aboveSubview: self)
            } else {
                if shouldAdjustYAxis {
                    ai?.center.y -= 100
                }
                self.addSubview(ai!)
            }
            ai?.startAnimating()
        }
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            if let ai = self.viewWithTag(1000) as? NVActivityIndicatorView {
                ai.stopAnimating()
                ai.removeFromSuperview()
            }
            if let button = self as? UIButton {
                button.setTitleColor(UIColor.white, for: .normal)
            }
        }
    }
}

extension UIButton {
    override func showActivityIndicator(shouldAdjustYAxis: Bool = true) {
        var ai = self.viewWithTag(1000) as? NVActivityIndicatorView
        if ai == nil {
            DispatchQueue.main.async {
                let frame = CGRect(x: 0, y: 0, width: 60, height: 60)
                ai = NVActivityIndicatorView(frame: frame, type: NVActivityIndicatorType.init(rawValue: 29), color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), padding: 10)
                ai?.tag = 1000
            }
        }
        DispatchQueue.main.async {
            ai?.center = self.center
            self.setTitleColor(UIColor.clear, for: .normal)
            self.superview?.insertSubview(ai!, aboveSubview: self)
            ai?.startAnimating()
        }
    }
    
    override func hideActivityIndicator() {
        self.superview?.viewWithTag(1000)?.removeFromSuperview()
        self.setTitleColor(UIColor.white, for: .normal)
    }
}

extension UIViewController {
    func showAlert(title: String , message: String) {
        let alert = UIAlertController(title: title as String, message: message as String, preferredStyle:.alert)
        alert.addAction(UIAlertAction(title: "موافق", style: UIAlertActionStyle.cancel, handler:nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showStatusBarNotification(_ title: String) {
        let ProgressHUD = CWStatusBarNotification()
        ProgressHUD.notificationStyle = .navigationBarNotification
        ProgressHUD.notificationAnimationType = .overlay
        ProgressHUD.notificationAnimationInStyle = .top
        ProgressHUD.notificationAnimationOutStyle = .top
        ProgressHUD.notificationLabelBackgroundColor = #colorLiteral(red: 0.9803921569, green: 0.7176470588, blue: 0.1921568627, alpha: 1)
        ProgressHUD.display(withMessage: title, forDuration: 1.5)
    }
    
    func segueToStartVC() {
        let storyboard = UIStoryboard(name: "Start", bundle: Bundle.main)
        let rootViewController = storyboard.instantiateViewController(withIdentifier: "StartViewController")
        self.present(rootViewController, animated: false, completion: nil)
    }
    
    func segueToLoginTVC() {
        let storyboard = UIStoryboard(name: "Start", bundle: Bundle.main)
        let rootViewController = storyboard.instantiateViewController(withIdentifier: "LoginTableViewController")
        self.present(rootViewController, animated: false, completion: nil)
    }
    
    func segueToMainTabBar() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mainTabBar = storyboard.instantiateViewController(withIdentifier: "MainTabBar")
        self.present(mainTabBar, animated: false, completion: nil)
    }
    
    
   
}

extension String {
    func replace(_ string:String, replacement:String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }
    
    func removeWhitespaces() -> String {
        return self.replace(" ", replacement: "+")
    }
    
    func encode() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
    }
}

extension Date {
    
    var readableDate : String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .long
        dateFormatter.locale = Locale.init(identifier: "ar")
        return dateFormatter.string(from: self)
    }
    
}

extension UIColor {
    func Image(_ size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        self.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}

extension UIViewController {
    func addText(_ text: String) {
        var label = self.view.viewWithTag(100) as? UILabel
        if label == nil {
            label = UILabel()
            label!.tag = 100
            label!.font = UIFont(name: "GE SS", size: 20)
            label!.numberOfLines = 0
            label!.textAlignment = .center
            label!.textColor = UIColor(red:0.25, green:0.75, blue:0.82, alpha:1.00)
            self.view.insertSubview(label!, at: 0)
        }
        label!.text = text
        label!.frame.size = label!.sizeThatFits(CGSize(width: self.view.bounds.size.width - 16, height: self.view.bounds.size.height))
        label!.center = CGPoint.init(x: self.view.bounds.midX, y: self.view.bounds.midY)
        label!.center.y -= 100
    }
    
    func addText(_ text: String, image: UIImage) {
        
        var label = self.view.viewWithTag(101) as? UILabel
        if label == nil {
            label = UILabel()
            label!.tag = 100
            label!.font = UIFont(name: "GE SS", size: 20)
            label!.numberOfLines = 0
            label!.textAlignment = .center
            label!.textColor = UIColor(red:0.25, green:0.75, blue:0.82, alpha:1.00)
        }
        
        var imageView = self.view.viewWithTag(102) as? UIImageView
        if imageView == nil {
            imageView = UIImageView(image: image)
            imageView?.contentMode = .scaleAspectFit
        }
        
        label?.text = text
        imageView?.image = image
        
        var stackview = self.view.viewWithTag(100) as? UIStackView
        if stackview == nil {
            stackview = UIStackView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width - 20, height: 300))
            stackview?.center = self.view.center
            stackview?.axis = .vertical
            stackview?.alignment = .center
            stackview?.distribution = .fill
            stackview?.spacing = 8.0
            stackview!.addArrangedSubview(label!)
            stackview!.addArrangedSubview(imageView!)
            self.view.insertSubview(stackview!, at: 0)
        }
        
    }
    
}

public extension UIWindow {
    public var visibleViewController: UIViewController? {
        return UIWindow.getVisibleViewControllerFrom(self.rootViewController)
    }
    
    public static func getVisibleViewControllerFrom(_ vc: UIViewController?) -> UIViewController? {
        if let nc = vc as? UINavigationController {
            return UIWindow.getVisibleViewControllerFrom(nc.visibleViewController)
        } else if let tc = vc as? UITabBarController {
            return UIWindow.getVisibleViewControllerFrom(tc.selectedViewController)
        } else {
            if let pvc = vc?.presentedViewController {
                return UIWindow.getVisibleViewControllerFrom(pvc)
            } else {
                return vc
            }
        }
    }
}

extension UITextView {
    
    func resolveHashTags(){
        
        // turn string in to NSString
        let nsText = self.text as NSString
        
        // this needs to be an array of NSString.  String does not work.
        let words = nsText.components(separatedBy: " ")
        
        // you can't set the font size in the storyboard anymore, since it gets overridden here.
        let attrs = [
            NSFontAttributeName : UIFont(name: "GE SS", size: 15)!
        ]
        
        self.textAlignment = .right
        
        // you can staple URLs onto attributed strings
        let attrString = NSMutableAttributedString(string: nsText as String, attributes:attrs)
        
        // tag each word if it has a hashtag
        for word in words {
            
            // found a word that is prepended by a hashtag!
            // homework for you: implement @mentions here too.
            if word.hasPrefix("#") {
                
                // a range is the character position, followed by how many characters are in the word.
                // we need this because we staple the "href" to this range.
                let matchRange:NSRange = nsText.range(of: word as String)
                
                // convert the word from NSString to String
                // this allows us to call "dropFirst" to remove the hashtag
                var stringifiedWord:String = word as String
                
                // drop the hashtag
                stringifiedWord = String(stringifiedWord.characters.dropFirst())
                
                // check to see if the hashtag has numbers.
                // ribl is "#1" shouldn't be considered a hashtag.
                let digits = NSCharacterSet.decimalDigits
                
                if stringifiedWord.rangeOfCharacter(from: digits) != nil {
                    // hashtag contains a number, like "#1"
                    // so don't make it clickable
                } else {
                    // set a link for when the user clicks on this word.
                    // it's not enough to use the word "hash", but you need the url scheme syntax "hash://"
                    // note:  since it's a URL now, the color is set to the project's tint color
                    let str = stringifiedWord.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
                    attrString.addAttribute(NSLinkAttributeName, value: str, range: matchRange)
                }
                
            }
        }
        
        // we're used to textView.text
        // but here we use textView.attributedText
        // again, this will also wipe out any fonts and colors from the storyboard,
        // so remember to re-add them in the attrs dictionary above
        self.attributedText = attrString
    }
    
}

extension UIView {
    func addBottomBorder(_ color: UIColor, thickness: CGFloat) {
        DispatchQueue.main.async {
            let border = CALayer()
            border.frame = CGRect(x: 0, y: self.layer.frame.height - thickness, width: self.layer.frame.width, height: thickness)
            border.backgroundColor = color.cgColor;
            self.layer.addSublayer(border)
        }
    }
}


extension UIView {
    @IBInspectable var isCircled: Bool {
        get {
            return false
        }
        set {
            if newValue {
                self.cornerRadius = self.bounds.height / 2
            }
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = true
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor.init(cgColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var isBottomBordered: Bool {
        get {
            return false
        }
        set {
            if newValue {
                self.addBottomBorder(UIColor.white, thickness: 1.0)
            }
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }
    
}

extension UISegmentedControl {
    @IBInspectable var fontName: String {
        get {
            return (self.titleTextAttributes(for: .normal)![NSFontAttributeName] as! UIFont).fontName
        }
        set {
            self.setTitleTextAttributes([NSFontAttributeName : UIFont(name: newValue, size: 15)!], for: .normal)
            
        }
    }
}

extension UIButton {
    @IBInspectable var naturalAlinemnted: Bool {
        get {
            return true
        }
        set {
            if UIView.userInterfaceLayoutDirection(for: self.semanticContentAttribute) == UIUserInterfaceLayoutDirection.rightToLeft {
                self.contentHorizontalAlignment = .right
            } else {
                self.contentHorizontalAlignment = .left
            }
        }
    }
}

extension UILabel {
    
    var substituteFontName : String {
        get { return self.font.fontName }
        set {
            if self.font.fontName.range(of:"Medium") == nil {
                self.font = UIFont(name: newValue, size: self.font.pointSize)
            }
        }
    }
    
}

extension UITextView {
    
    var substituteFontName : String {
        get { return self.font!.fontName }
        set {
            if self.font?.fontName.range(of:"Medium") == nil {
                self.font = UIFont(name: newValue, size: self.font?.pointSize ?? 17.0)
            }
        }
    }
    
}

extension UINavigationBar {
    
    var substituteFontName : (String, CGFloat) {
        get { return ((self.titleTextAttributes![NSFontAttributeName] as! UIFont).fontName, 20.0) }
        set {
            self.titleTextAttributes = [NSFontAttributeName : UIFont(name: newValue.0, size: newValue.1)!]
        }
    }
    
}




