//
//  FXViewContext.swift
//  TTSwift
//
//  Created by 张大宗 on 2017/5/26.
//  Copyright © 2017年 张大宗. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import ReactiveSwift
import ReactiveCocoa

public class FXViewContext {

//    var animatedDuration:TimeInterval = 0.25
//    
//    var hasBackground = true
//    
//    var backgroundAlpha = 0.3
//    
//    var pushType = FXViewPushType.FXViewPushTypeAlert
//    
//    var touchClose = true
    
    public static let sharedInstance = FXViewContext()
    
    public func formatView<T:UIView>(view:T,Root root:UIView)->UIView where T:IFXViewShowProtocol{
        let hasbg = view.hasBackground()
        let alpha = view.backgroundAlpha()
        let father = UIView.init()
        father.backgroundColor = UIColor.clear
        root.addSubview(father)
        father.snp.makeConstraints { (make) in
            make.edges.equalTo(root)
        }
        if hasbg {
            let bgv = UIButton.init()
            bgv.backgroundColor = UIColor.black
            bgv.alpha = alpha
            weak var selfObject = self
        bgv.reactive.controlEvents(UIControlEvents.touchUpInside).observeValues({ (x) in
                selfObject?.closeView(view: view)
            })
            father.addSubview(bgv)
            bgv.snp.makeConstraints({ (make) in
                make.edges.equalTo(father)
            })
        }
        father.addSubview(view)
        root.layoutIfNeeded()//强制绘制
        return father
    }
    
    public func showView<T:UIView>(view:T,Root root:UIView) where T:IFXViewShowProtocol{
        if view.superview != nil {
            let _ = self.formatView(view: view, Root: root)
            let type = view.pushType()
            let duration = view.animatedDuration()
            switch type {
            case .FXViewPushTypeAlert:
                view.snp.makeConstraints({ (make) in
                    make.centerX.equalTo(view.superview!.snp.centerX)
                    make.centerY.equalTo(view.superview!.snp.centerY)
                    make.width.equalTo(view.viewSize().width)
                    make.height.equalTo(view.viewSize().height)
                })
                view.superview?.layoutIfNeeded()
                FXAnimateContext.sharedInstance.alertView(view: view, Duration: duration, Block: nil)
            case .FXViewPushTypeLeft:
                view.snp.makeConstraints({ (make) in
                    make.top.equalTo(view.superview!.snp.top)
                    make.bottom.equalTo(view.superview!.snp.bottom)
                    make.left.equalTo(-view.viewSize().width)
                    make.width.equalTo(view.viewSize().width)
                })
                view.superview?.layoutIfNeeded()//强制绘制
                FXAnimateContext.sharedInstance.horizontalMove(view: view, Duration: duration, Distance: view.viewSize().width, Block: nil)
            case .FXViewPushTypeRight:
                view.snp.makeConstraints({ (make) in
                    make.top.equalTo(view.superview!.snp.top)
                    make.bottom.equalTo(view.superview!.snp.bottom)
                    make.left.equalTo(view.superview!.snp.right)
                    make.width.equalTo(view.viewSize().width)
                })
                view.superview?.layoutIfNeeded()//强制绘制
                FXAnimateContext.sharedInstance.horizontalMove(view: view, Duration: duration, Distance: -view.viewSize().width, Block: nil)
            case .FXViewPushTypeTop:
                view.snp.makeConstraints({ (make) in
                    make.left.equalTo(view.superview!.snp.left)
                    make.right.equalTo(view.superview!.snp.right)
                    make.top.equalTo(-view.viewSize().height)
                    make.height.equalTo(view.viewSize().height)
                })
                view.superview?.layoutIfNeeded()//强制绘制
                FXAnimateContext.sharedInstance.verticalMove(view: view, Duration: duration, Distance: view.viewSize().height, Block: nil)
            case .FXViewPushTypeBottom:
                view.snp.makeConstraints({ (make) in
                    make.left.equalTo(view.superview!.snp.left)
                    make.right.equalTo(view.superview!.snp.right)
                    make.top.equalTo(view.superview!.snp.bottom)
                    make.height.equalTo(view.viewSize().height)
                })
                view.superview?.layoutIfNeeded()//强制绘制
                FXAnimateContext.sharedInstance.verticalMove(view: view, Duration: duration, Distance: -view.viewSize().height, Block: nil)
            }
        }
    }
    
    public func closeView<T:UIView>(view:T) where T:IFXViewShowProtocol{
        if view.superview != nil {
            view.superview?.layoutIfNeeded()
            let type = view.pushType()
            let duration = view.animatedDuration()
            switch type {
            case .FXViewPushTypeAlert:
                FXAnimateContext.sharedInstance.cancelAlert(view: view, Duration: duration, Block: { (success) in
                    view.superview?.removeFromSuperview()
                })
            case .FXViewPushTypeLeft:
                FXAnimateContext.sharedInstance.horizontalMove(view: view, Duration: duration, Distance: view.viewSize().width, Block: { (success) in
                    view.superview?.removeFromSuperview()
                })
            case .FXViewPushTypeTop:
                FXAnimateContext.sharedInstance.verticalMove(view: view, Duration: duration, Distance: -view.viewSize().height, Block: { (success) in
                    view.superview?.removeFromSuperview()
                })
            case .FXViewPushTypeBottom:
                FXAnimateContext.sharedInstance.verticalMove(view: view, Duration: duration, Distance: view.viewSize().height, Block: { (success) in
                    view.superview?.removeFromSuperview()
                })
            default:break
            }
        }
    }
}
