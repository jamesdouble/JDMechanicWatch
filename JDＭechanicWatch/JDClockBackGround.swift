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
    var Gearcontainer:UIView?
    var Gearbackground:UIImageView?
    
    var linelength:CGFloat = 15
    var linelength2:CGFloat = 10
    

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
        
        if(self.superview?.superview != nil)
        {
            print("Sub  \(rect.width),\(self.superview?.superview?.frame.width)")
            linelength *= rect.width/(self.superview?.superview?.frame.width)!
            linelength2 *= rect.width/(self.superview?.superview?.frame.width)!
        }
        
        ctx?.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rad, startAngle: 0, endAngle: endAngle, clockwise: true)
        
        ctx?.setFillColor(Clockbgcolor)
        ctx?.setStrokeColor(UIColor.gray.cgColor)
        ctx?.setLineWidth(2.0)
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
                drawSecondMarker(ctx: ctx!, x: rad-linelength, y:0, radius:rad, color: Clockdegreecolor)
            }
            else {
                drawSecondMarker(ctx: ctx!, x: rad-linelength2, y:0, radius:rad, color: Clockdegreecolor)
            }
            // restore state before next translation
            ctx?.restoreGState()
        }
        
       
        
    }
    
    func drawGearBackground()
    {
        let containerframe:CGRect = CGRect(x:1/8 * self.frame.width , y: 1/5 * self.frame.width, width: 1/2 * self.frame.width, height: 1/2 * self.frame.width)
        Gearcontainer = UIView(frame: containerframe)
        self.addSubview(Gearcontainer!)
        
        let gearframe:CGRect = CGRect(x:0 , y:0, width: 1/2 * self.frame.width, height: 1/2 * self.frame.width)
        let gear_img:UIImage = #imageLiteral(resourceName: "SilverGear")
        Gearbackground = UIImageView(image: gear_img)
        Gearbackground?.frame = gearframe
        self.Gearcontainer?.addSubview(Gearbackground!)
        
        gearmask(gearframe: containerframe)
        tickingGear()
    }
    
    func gearmask(gearframe:CGRect){
        let middlepoint:CGPoint = CGPoint(x: 1/2 * gearframe.width, y:  1/2 * gearframe.height)
        let masklayer:CAShapeLayer = CAShapeLayer()
        let maskpath:UIBezierPath = UIBezierPath()
        maskpath.addArc(withCenter: middlepoint, radius: 1/2 * gearframe.width, startAngle: CGFloat(0.7 * M_PI), endAngle: CGFloat(1.5*M_PI), clockwise: true)
        maskpath.addLine(to: middlepoint)
        masklayer.path = maskpath.cgPath
        Gearcontainer?.layer.mask = masklayer
    }
    
    var geardegree:Double = 0.0
    func tickingGear()
    {
        let timer:Timer = Timer(timeInterval: 1.0, repeats: true, block: {_ in
            self.geardegree += 6.0
            self.Gearbackground?.transform = CGAffineTransform(rotationAngle: CGFloat(self.geardegree/180 * M_PI))
        })
        RunLoop.main.add(timer, forMode: .defaultRunLoopMode)
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
