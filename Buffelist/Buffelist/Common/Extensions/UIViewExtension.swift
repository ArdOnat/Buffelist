//
//  UIViewExtension.swift
//  Buffelist
//
//  Created by Arda Onat on 1.10.2020.
//


import UIKit

extension UIView {

    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }

    @IBInspectable var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else {
                return nil
            }

            return UIColor(cgColor: color)
        }
        set { layer.borderColor = newValue?.cgColor }
    }
}

extension UIView {
    func embed(_ childView: UIView) {
        childView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(childView)
        NSLayoutConstraint.activate([
            childView.leftAnchor.constraint(equalTo: leftAnchor),
            childView.topAnchor.constraint(equalTo: topAnchor),
            childView.centerXAnchor.constraint(equalTo: centerXAnchor),
            childView.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        layoutIfNeeded()
    }
    
    func makeShadow()
    {
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 1.0
        self.clipsToBounds = false
        self.layer.masksToBounds = false
    }
    
    func makeShadow(color: UIColor, size: CGSize, shadowOpacity: Float, shadowRadius: CGFloat)
    {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = size
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        self.clipsToBounds = false
        self.layer.masksToBounds = false
    }
    
    func removeShadow()
    {
        self.layer.shadowOpacity = 0
    }
    
    func makeButtonShadow()
    {
        self.layer.shadowColor = UIColor(red: 59.0/255.0, green: 59.0/255.0, blue: 59.0/255.0, alpha: 0.3).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 5.0
        self.clipsToBounds = false
        self.layer.masksToBounds = false
    }
}

extension UIScrollView {

    /**
     * Set scrollView contenInset and also adjusts scrollIndicatorInsets by specified value
     * - parameter insets: value which will specify contentInset and scrollIndicatorInsets
     */
    func setupInsets(_ insets: UIEdgeInsets) {
        scrollIndicatorInsets = insets
        contentInset = insets
    }

    /**
     * Set scrollView contenInset.top and scrollIndicatorInsets.top by specified value
     * - parameter inset: top inset value. Has default value -  StyleManager.values.topInset
     */
    func setupTopInset(_ inset: CGFloat) {
        let insets = UIEdgeInsets(top: inset, left: 0, bottom: 0, right: 0)
        setupInsets(insets)
    }
}

extension UIView {
    func roundCorners(corners:CACornerMask, radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = corners
    }
}
