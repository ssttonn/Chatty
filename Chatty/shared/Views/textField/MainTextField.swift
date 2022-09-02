//
//  MainTextField.swift
//  Chatty
//
//  Created by GONOSEN on 11/08/2022.
//

import UIKit

class MainTextField: UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        font = UIFont(name: "kelson_regular.otf", size: 20)
        layer.cornerRadius = BorderRadius.defaultRadius
        borderStyle = .none
        backgroundColor = UIColor(rgb: 0xEEEEEE)
        tintColor = UIColor(rgb: 0xF66B0E)
    }
}

extension MainTextField{
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: getPadding())
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: getPadding())
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: getPadding())
    }
    
    func getPadding() -> UIEdgeInsets{
        var top: CGFloat = 0, left: CGFloat = 20, right: CGFloat = 20, bottom: CGFloat = 0
        if leftView != nil, let viewWidth = leftView?.frame.width {
            left = viewWidth + 20
        }
        if rightView != nil, let viewWidth = rightView?.frame.width {
            right = viewWidth + 20
        }
        return UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
}

extension MainTextField{
    func setLeftImage(withName imageName: String, withHeight height: Int = 20, withWidth width: Int = 20) {
        let imageView = UIImageView(frame: CGRect(x: 10, y: 0, width: width, height: height))
        imageView.image = UIImage(named: imageName)
        let imageContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        imageContainerView.addSubview(imageView)
        leftView = imageContainerView
        leftViewMode = .always
    }
    
    func setRightImage(withName imageName: String, withHeight height: Int = 20, withWidth width: Int = 20) {
        let imageView = UIImageView(frame: CGRect(x: -10, y: 0, width: width, height: height))
        imageView.image = UIImage(named: imageName)
        let imageContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        imageContainerView.addSubview(imageView)
        rightView = imageContainerView
        rightViewMode = .always
    }
    
}


