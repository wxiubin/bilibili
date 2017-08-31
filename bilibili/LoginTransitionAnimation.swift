//
//  LoginTransitionAnimation.swift
//  bilibili
//
//  Created by Sanyucz on 2017/8/31.
//  Copyright © 2017年 Sanyucz. All rights reserved.
//

import UIKit

class LoginTransitionAnimation: NSObject {
    let duration: TimeInterval = 1
    var context: UIViewControllerContextTransitioning?
}

extension LoginTransitionAnimation: UIViewControllerTransitioningDelegate {
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
}

extension LoginTransitionAnimation: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        context = transitionContext
        let containerView = transitionContext.containerView
        let toView = transitionContext.viewController(forKey: .to)?.view.snapshotView(afterScreenUpdates: true)
        
        containerView.addSubview((toView)!)
        
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        
        let rect = CGRect(x: containerView.center.x-1, y: containerView.center.y-1, width: 2, height: 2)
        
        let startPath = UIBezierPath(ovalIn: rect)
        let endPath = UIBezierPath(arcCenter: containerView.center, radius: sqrt(height*height+width*width), startAngle: 0, endAngle: CGFloat(Double.pi*2), clockwise: true)
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = startPath.cgPath
        toView?.layer.mask = maskLayer
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = startPath.cgPath
        animation.toValue = endPath.cgPath
        animation.duration = duration
        animation.delegate = self
        animation.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        maskLayer.add(animation, forKey: "PointBackPath")
    }
}

extension LoginTransitionAnimation: CAAnimationDelegate {
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        context?.viewController(forKey: .from)?.view.removeFromSuperview()
        context?.completeTransition(true)
    }
}
