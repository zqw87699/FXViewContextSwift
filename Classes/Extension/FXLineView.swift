//
//  FXLineView.swift
//  TTSwift
//
//  Created by 张大宗 on 2017/5/26.
//  Copyright © 2017年 张大宗. All rights reserved.
//

import Foundation
import UIKit

/**
 *  线条绘制位置
 */
enum FXLineDrawPosition:Int {
    /**
     *  垂直居中
     */
    case FXLineDrawPositionVerticalCenter = 0
    /**
     *  水平居中
     */
    case FXLineDrawPositionHorizontalCenter = 1
    /**
     *  底部
     */
    case FXLineDrawPositionBottom = 2
    /**
     *  顶部
     */
    case FXLineDrawPositionTop = 3
    
    /**
     * 左边
     */
    case FXLineDrawPositionLeft = 4
    
    /**
     * 右边
     */
    case FXLineDrawPositionRight = 5
}

/**
 *  线条样式
 */

enum FXLineStyle:Int {
    /**
     * 实线
     */
    case FXLineStyleSolid = 0
    /**
     * 虚线
     */
    case FXLineStyleDotted = 1
}

/**
 *  线条视图
 */
class FXLineView:BaseFXView{
    /**
     *  线条颜色
     */
    var lineColor:UIColor = UIColor.gray{
        didSet {
            self.setNeedsDisplay()
        }
    }
    /**
     *  是否水平
     */
    var drawPosition:FXLineDrawPosition = .FXLineDrawPositionVerticalCenter{
        didSet {
            self.setNeedsDisplay()
        }
    }
    /**
     *  线条样式
     */
    var lineStyle:FXLineStyle = .FXLineStyleSolid
    /**
     *  线条宽度
     *  default     1/scale
     */
    var lineWidth:CGFloat = 1.0/UIScreen.main.scale{
        didSet{
            if self.lineWidth < 0{
                self.lineWidth = 0
            }
            self.setNeedsDisplay()
        }
    }
    
    override func fx_loadView() {
        super.fx_loadView()
        self.backgroundColor = UIColor.clear
    }

    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        if context != nil {
            context?.setLineCap(CGLineCap.butt)
            //CGContext.setLineCap(context!)
            if self.lineStyle == FXLineStyle.FXLineStyleDotted {
                let lenghts:Array<CGFloat> = [5,5]
                context?.setLineDash(phase: 0, lengths: lenghts)
            }
            context?.setLineWidth(self.lineWidth)
            
            context?.setStrokeColor(self.lineColor.cgColor)
            context?.beginPath()
            switch self.drawPosition {
            case .FXLineDrawPositionVerticalCenter:
                context?.move(to: CGPoint.init(x: (self.bounds.size.width-self.lineWidth)/2.0, y: 0))
            case .FXLineDrawPositionHorizontalCenter:
                context?.move(to: CGPoint.init(x: 0, y: (self.bounds.size.height-self.lineWidth)/2.0))
                context?.addLine(to: CGPoint.init(x: self.bounds.size.width, y: (self.bounds.size.height-self.lineWidth)/2.0))
            case .FXLineDrawPositionTop:
                context?.move(to: CGPoint.init(x: 0, y: self.lineWidth/2.0))
                context?.addLine(to: CGPoint.init(x: self.bounds.size.width, y: self.lineWidth/2.0))
            case .FXLineDrawPositionLeft:
                context?.move(to: CGPoint.init(x: self.lineWidth/2.0, y: 0))
                context?.addLine(to: CGPoint.init(x: self.lineWidth/2.0, y: self.bounds.size.height))
            case .FXLineDrawPositionRight:
                context?.move(to: CGPoint.init(x: self.bounds.size.width-self.lineWidth/2.0, y: 0))
                context?.addLine(to: CGPoint.init(x: self.bounds.size.width-self.lineWidth/2.0, y: self.bounds.size.height))
            case .FXLineDrawPositionBottom:
                context?.move(to: CGPoint.init(x: 0, y: self.bounds.size.height-self.lineWidth/2.0))
                context?.addLine(to: CGPoint.init(x: self.bounds.size.width, y: self.bounds.size.height-self.lineWidth/2.0))
            }
            context?.strokePath()
        }
    }
}
