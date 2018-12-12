//
//  UIViewController+Extension.swift
//  MVPTest
//
//  Created by Ryan on 2018/9/21.
//  Copyright © 2018年 Ryan. All rights reserved.
//

import UIKit


extension UIViewController {
    
    private struct AssociatedKeys {
        static var presentedKey = "UIViewController.presentedAnimatedTransitioning"
        static var dismissedKey = "UIViewController.dismissedANimatedTransitioning"
        static var presentationKey = "UIViewController.presentationController"
        
        static var operaionKey = "UIViewController.operaion"
    }
    
    private var transitionOperation: TransitionOperation? {
        get {
            return objc_getAssociatedObject(self,
                                            &AssociatedKeys.operaionKey) as? TransitionOperation
        }
        set {
            objc_setAssociatedObject(self,
                                     &AssociatedKeys.operaionKey,
                                     newValue,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var presentedAnimatedTransitioning: UIViewControllerAnimatedTransitioning? {
        get {
            return objc_getAssociatedObject(self,
                                            &AssociatedKeys.presentedKey) as? UIViewControllerAnimatedTransitioning
        }
        set {
            objc_setAssociatedObject(self,
                                     &AssociatedKeys.presentedKey,
                                     newValue,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            if transitionOperation == nil { transitionOperation = TransitionOperation() }
            transitionOperation?.ownerVc = self
            self.transitioningDelegate = transitionOperation
            self.modalPresentationStyle = .custom
        }
    }
    
    var dismissedAnimatedTransitioning: UIViewControllerAnimatedTransitioning? {
        get {
            return objc_getAssociatedObject(self,
                                            &AssociatedKeys.dismissedKey) as? UIViewControllerAnimatedTransitioning
        }
        set {
            objc_setAssociatedObject(self,
                                     &AssociatedKeys.dismissedKey,
                                     newValue,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            if transitionOperation == nil { transitionOperation = TransitionOperation() }
            transitionOperation?.ownerVc = self
            self.transitioningDelegate = transitionOperation
            self.modalPresentationStyle = .custom
        }
    }
    
    var presentationController: UIPresentationController? {
        get {
            return objc_getAssociatedObject(self,
                                            &AssociatedKeys.presentationKey) as? UIPresentationController
        }
        set {
            objc_setAssociatedObject(self,
                                     &AssociatedKeys.presentationKey,
                                     newValue,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            if transitionOperation == nil { transitionOperation = TransitionOperation() }
            transitionOperation?.ownerVc = self
            self.transitioningDelegate = transitionOperation
            self.modalPresentationStyle = .custom
        }
    }
}


fileprivate class TransitionOperation: NSObject, UIViewControllerTransitioningDelegate {
    
    weak var ownerVc: UIViewController?
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let vc = ownerVc,
            let dismissedAnimatedTransitioning = vc.dismissedAnimatedTransitioning,
            dismissed == vc else {
                return nil
        }
        return dismissedAnimatedTransitioning
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let vc = ownerVc,
            let presentedAnimatedTransitioning = vc.presentedAnimatedTransitioning,
            presented == vc else {
                return nil
        }
        return presentedAnimatedTransitioning
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        guard let vc = ownerVc,
            let presentationController = vc.presentationController,
            presented == vc else {
                return nil
        }
        return presentationController
    }
}


