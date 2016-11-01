//
//  JDClockBackGround.swift
//  JDＭechanicWatch
//
//  Created by 郭介騵 on 2016/10/29.
//  Copyright © 2016年 james12345. All rights reserved.
//

import UIKit

class JDClockBackGround: UIView {
    
    var Clockbgcolor: CGColor!
    var Clockdegreecolor:UIColor!
    
    init(frame:CGRect,bgcolor:UIColor,GraduationColor g:UIColor){
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        Clockbgcolor = bgcolor.cgColor
        Clockdegreecolor = g
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func draw(_ rect:CGRect)
    {
        
        let ctx = UIGraphicsGetCurrentContext()
        
        // MARK: Create back of watchface
        let rad = rect.width/2.1
        let endAngle = CGFloat(2*M_PI)
        
        ctx?.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rad, startAngle: 0, endAngle: endAngle, clockwise: true)
        
        ctx?.setFillColor(Clockbgcolor)
        ctx?.setStrokeColor(UIColor.gray.cgColor)
        ctx?.setLineWidth(4.0)
        ctx?.drawPath(using: CGPathDrawingMode.fillStroke)
        
        for i in 1...60 {
            
            // save the original position and origin
            ctx?.saveGState()
            // make translation
            ctx?.translateBy(x: rect.midX, y: rect.midY)
            // make rotation
            ctx?.rotate(by: degree2radian(a: CGFloat(i)*6))
            
            if i % 5 == 0 {
                // if an hour position we want a line slightly longer
                drawSecondMarker(ctx: ctx!, x: rad-15, y:0, radius:rad, color: Clockdegreecolor)
            }
            else {
                drawSecondMarker(ctx: ctx!, x: rad-10, y:0, radius:rad, color: Clockdegreecolor)
            }
            // restore state before next translation
            ctx?.restoreGState()
        }
        
    }
    
    func degree2radian(a:CGFloat)->CGFloat {
        let b = CGFloat(M_PI) * a/180
        return b
    }
    
    func drawSecondMarker(ctx:CGContext, x:CGFloat, y:CGFloat, radius:CGFloat, color:UIColor) {
        let path = CGMutablePath();
        path.move(to: CGPoint(x:radius,y: 0))
        path.addLine(to: CGPoint(x: x,y: y))
        path.closeSubpath()
        ctx.addPath(path)
        ctx.setLineWidth(1.5)
        ctx.setStrokeColor(color.cgColor)
        ctx.strokePath()
    }
 
    
}
