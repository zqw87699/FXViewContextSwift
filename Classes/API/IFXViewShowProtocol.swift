//
//  IFXViewShowProtocol.swift
//  TTSwift
//
//  Created by 张大宗 on 2017/5/27.
//  Copyright © 2017年 张大宗. All rights reserved.
//

import Foundation
import UIKit

public enum FXViewPushType:Int {
    /*
     *  警告
     */
    case FXViewPushTypeAlert = 0
    /*
     *  左推入
     */
    case FXViewPushTypeLeft = 1
    /*
     *  右推入
     */
    case FXViewPushTypeRight = 2
    /*
     *  顶部推入
     */
    case FXViewPushTypeTop = 3
    /*
     *  底部推入
     */
    case FXViewPushTypeBottom = 4
}

public protocol IFXViewShowProtocol {
    /**
     *  页面尺寸
     */
    func viewSize()->CGSize
    
    /**
     *  页面推入方式
     *
     *  default FXViewPushTypeNone
     */
    func pushType()->FXViewPushType
    
    /**
     *  动画时长
     *
     *  default 0.25f
     */
    func animatedDuration()->TimeInterval
    
    /**
     *  是否拥有背景
     *
     *  default NO
     */
    func hasBackground()->Bool
    /**
     *  透明度
     *
     *  @return 0.0~1.0
     *
     *  default 0.3f
     */
    func backgroundAlpha()->CGFloat
    
    /**
     *  是否点击推出
     *
     *  default YES
     */
    func touchClose()->Bool
}
