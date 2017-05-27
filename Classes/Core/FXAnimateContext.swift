//
//  FXAnimateContext.swift
//  TTSwift
//
//  Created by 张大宗 on 2017/5/26.
//  Copyright © 2017年 张大宗. All rights reserved.
//

import Foundation
import UIKit

public typealias SuccessBlock = (_ success:Bool)->Void


public class FXAnimateContext{
    
    public static let sharedInstance = FXAnimateContext()
    
    public func shakeView(view:UIView,block:SuccessBlock?){
        let shake = CABasicAnimation.init(keyPath: "transform.translation.x")
        shake.fromValue = -5
        shake.toValue = 5
        shake.duration = 0.1
        shake.autoreverses = true
        shake.repeatCount = 2
        view.layer.add(shake, forKey: "shakeAnimation")
        UIView.animate(withDuration: 2.0, delay: 0.0, options: [UIViewAnimationOptions.curveEaseIn,UIViewAnimationOptions.allowUserInteraction], animations: {
            
        }, completion: block)
    }
    
    public func alertView(view:UIView,Duration duration:TimeInterval,Block block:SuccessBlock?){
        let origTransform = view.transform
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1/2.0, animations: {
                view.transform = CGAffineTransform.scaledBy(origTransform)(x: 1.2,y: 1.2)
            })
            UIView.addKeyframe(withRelativeStartTime: 1/2.0, relativeDuration: 1/2.0, animations: { 
                view.transform = origTransform
            })
        }, completion: block)
    }
    
    public func cancelAlert(view:UIView,Duration duration:TimeInterval,Block block:SuccessBlock?){
        let origTransform = view.transform
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1/4.0, animations: { 
                view.transform = CGAffineTransform.scaledBy(origTransform)(x: 1.1,y: 1.1)
            })
            UIView.addKeyframe(withRelativeStartTime: 1/4.0, relativeDuration: 3/4.0, animations: { 
                view.transform = CGAffineTransform.scaledBy(origTransform)(x: 0.8,y: 0.8)
            })
            UIView.addKeyframe(withRelativeStartTime: 1/4.0, relativeDuration: 3/4.0, animations: { 
                view.alpha = 0
            })
            UIView.addKeyframe(withRelativeStartTime: 3/4.0, relativeDuration: 1/4.0, animations: {
                view.alpha = 0
            })
        }, completion: block)
    }
    
    public func horizontalMove(view:UIView,Duration duration:TimeInterval,Distance dis:CGFloat,Block block:SuccessBlock?){
        UIView.animate(withDuration: duration, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: {
            var center = view.center
            center.x = center.x + dis
            view.center = center
        }, completion: block)
    }
    
    public func verticalMove(view:UIView,Duration duration:TimeInterval,Distance dis:CGFloat,Block block:SuccessBlock?){
        UIView.animate(withDuration: duration, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: {
            var center = view.center
            center.y = center.y + dis
            view.center = center
        }, completion: block)
    }
    
    public func move(view:UIView,Duration duration:TimeInterval,Point point:CGPoint,Block block:SuccessBlock?){
        UIView.animate(withDuration: duration, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: { 
            view.center = point
        }, completion: block)
    }
}
