//
//  KeyboardHandler.swift
//  Buffelist
//
//  Created by Arda Onat on 1.10.2020.
//

import Foundation
import UIKit

class KeyboardHandler {
    
    let scrollView: UIScrollView
    let responders: [UIView]
    
    var bottomContentMargin: CGFloat?
    
    init(with scrollView: UIScrollView, responders: [UIView]) {
        self.scrollView = scrollView
        self.responders = responders
        registerNotifications()
    }
    
    deinit {
        unregisterNotifications()
    }
    
    func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardHandler.willShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardHandler.willHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardHandler.willChangeFrame(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    func unregisterNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func willShow(notification: Notification) {
        /*
         UIKeyboardFrameBeginUserInfoKey {0, 667}, {375, 216}
         UIKeyboardFrameEndUserInfoKey {0, 451}, {375, 216}
         UIKeyboardAnimationCurveUserInfoKey (7 << 16)
         UIKeyboardAnimationDurationUserInfoKey 0.25
         UIKeyboardIsLocalUserInfoKey
         */
        
        setContentInset(for: notification)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.scrollToVisible()
        }
    }
    
    @objc func willHide(notification: Notification) {
        scrollView.contentInset = .zero
    }
    
    @objc func willChangeFrame(notification: Notification) {
        setContentInset(for: notification)
    }
    
    fileprivate func scrollToVisible() {
        if let view = getActiveView() {
            var frame = view.frame
            frame.size.height += (bottomContentMargin ?? 0.0)
            scrollView.scrollRectToVisible(frame, animated: true)
        }
    }
    
    fileprivate func setContentInset(for notification: Notification) {
        let intersect = getIntersection(endFrame: notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)
        let insets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: intersect.height, right: 0.0)
        scrollView.contentInset = insets
        scrollView.scrollIndicatorInsets = insets
    }
    
    fileprivate func getIntersection(endFrame: CGRect?) -> CGRect {
        if let endFrame = endFrame {
            let keyboardFrame = endFrame
            let scrollFrame = scrollView.convert(scrollView.frame, to: UIApplication.shared.keyWindow!)
            let intersect = keyboardFrame.intersection(scrollFrame)
            return intersect
        }
        return CGRect.zero
    }
    
    fileprivate func getActiveView() -> UIView? {
        if let activeView = responders.first(where: {$0.isFirstResponder}) {
            // If next after active object can't become first responder -
            // most likely it is a button. scroll to show it
            if let activeIdx = responders.firstIndex(of: activeView) {
                let nextIdx = responders.index(after: activeIdx)
                if nextIdx < responders.count {
                    let nextView = responders[nextIdx]
                    if !nextView.canBecomeFirstResponder {
                        return responders[nextIdx]
                    }
                }
            }
            return activeView
        }
        return nil
    }
}
