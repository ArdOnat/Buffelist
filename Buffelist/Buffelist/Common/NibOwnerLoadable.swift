//
//  NibLoadOwnalbed.swift
//  Buffelist
//
//  Created by Arda Onat on 18.10.2020.
//

import UIKit
import Cartography

/// Make your UIView subclasses conform to this protocol when:
///  * they are NIB-based, and
///  * this class is used as the XIB's File's Owner
///
/// to be able to instantiate them from the NIB in a type-safe manner
public protocol NibOwnerLoadable: class {
    /// The nib file to use to load a new instance of the View designed in a XIB
    static var nib: UINib { get }
}

// MARK: Default implementation
public extension NibOwnerLoadable {
    // By default, use the nib which have the same name as the name of the class, and located in the bundle of that class
    static var nib: UINib {
        print(self)
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
}

// MARK: Support for instantiation from NIB
public extension NibOwnerLoadable where Self: UIView {

    // Adds content loaded from the nib to the end of the receiver's list of subviews and adds constraints automatically.

    func loadNibContent() {
        for view in Self.nib.instantiate(withOwner: self, options: nil) {
            if let view = view as? UIView {
                view.translatesAutoresizingMaskIntoConstraints = false
                self.addSubview(view)
                constrain(view, self) { view, this in
                    view.leading == this.leading
                    view.trailing == this.trailing
                    view.top == this.top
                    view.bottom == this.bottom
                }
            }
        }
    }
}
