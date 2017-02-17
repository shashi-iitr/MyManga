//
//  GenericExtension.swift
//  MyManga
//
//  Created by shashi kumar on 17/02/17.
//  Copyright © 2017 Iluminar Media Private Limited. All rights reserved.
//

import Foundation
import UIKit

let kAccessToken = "kAccessToken"

extension UserDefaults {
    
    func accessToken() -> String? {
        return self.value(forKey: kAccessToken) as? String
    }
    
    func setAccessToken(token: String) -> Void {
        self.set(token, forKey: kAccessToken)
        self.synchronize()
    }
}

import Foundation

extension NSObject {
    class func className() -> String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}

//MARK: UIView
extension UIView {
    class func nib() -> UINib {
        return UINib(nibName: className(), bundle: nil)
    }
    
    class func reuseIdentifier() -> String {
        return className()
    }
    
    class func loadFromNib() -> UIView? {
        return nib().instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
    
    func top() -> CGFloat {
        return self.frame.origin.y
    }
    func bottom() -> CGFloat {
        return self.frame.origin.y + self.frame.size.height
    }
    func left() -> CGFloat {
        return self.frame.origin.x
    }
    func right() -> CGFloat {
        return self.frame.origin.x + self.frame.size.width
    }
    func width() -> CGFloat {
        return self.bounds.width
    }
    func height() -> CGFloat {
        return self.bounds.height
    }
    
    func setBottom(bottom: CGFloat) -> Void {
        var frame = self.frame
        frame.origin.y = bottom - self.height()
        self.frame = frame
    }
    func setTop(top: CGFloat) -> Void {
        var frame = self.frame
        frame.origin.y = top
        self.frame = frame
    }
}

protocol ReusableView: class {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}

//MARK: UICollectionView

extension UICollectionViewCell: ReusableView {
}

protocol NibLoadableView: class {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}

extension UICollectionViewCell : NibLoadableView {
    
}

//MARK: UITableView

extension UITableViewCell: ReusableView {
}

extension UITableViewCell : NibLoadableView {
    
}

//MARK: UIColor

extension UIColor {
    class func colorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

//MARK: String

extension String {
    func getHeightWidthGivenWidthAndLineHeight(font:UIFont,lineHeight: CGFloat, labelWidth: CGFloat) -> CGFloat {
        let attributeString = NSMutableAttributedString(string: self)
        let style = NSMutableParagraphStyle()
        //        let font = UIFont.init(name: "Lato-Regular", size: 12)
        style.lineSpacing = lineHeight
        attributeString.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSMakeRange(0, attributeString.length))
        attributeString.addAttribute(NSFontAttributeName, value: font, range: NSMakeRange(0, attributeString.length))
        let height = attributeString.heightWithWidth(width: labelWidth)
        
        return height
    }
    
    func sizeForMultilineLabelWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGSize {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let options : NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]
        let boundingBox = self.boundingRect(with: constraintRect, options: options, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.size
    }
    
    func sizeForSingleLineLabelWithFont(font: UIFont) -> CGSize {
        let boundingBox = self.size(attributes: [NSFontAttributeName: font])
        
        return boundingBox
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return emailTest.evaluate(with: self)
    }
    
}

//MARK: UIButton

extension UIButton {
    func setTitleWithoutAnimation(title: String?) {
        UIView.setAnimationsEnabled(false)
        setTitle(title, for: .normal)
        layoutIfNeeded()
        UIView.setAnimationsEnabled(true)
    }
    
    func setAttributedTitleWithoutAnimation(title: NSAttributedString?) {
        UIView.setAnimationsEnabled(false)
        setAttributedTitle(title, for: .normal)
        layoutIfNeeded()
        UIView.setAnimationsEnabled(true)
    }
}

extension NSAttributedString {
    func heightWithWidth(width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let options : NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]
        let boundingBox = self.boundingRect(with: constraintRect, options: options, context: nil)
        
        return boundingBox.height
    }
}
