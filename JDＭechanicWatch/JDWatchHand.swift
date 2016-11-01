//
//  JDWatchHand.swift
//  JDＭechanicWatch
//
//  Created by 郭介騵 on 2016/10/31.
//  Copyright © 2016年 james12345. All rights reserved.
//

import UIKit

enum HandsTypes{
   case Hours
   case Minute
   case Second
}

class JDWatchHand :UIView {
    
    var middlePoint:CGPoint = CGPoint()
    var handslong:CGFloat = 0.0
    var handlayer:CAShapeLayer = CAShapeLayer()
    var Seconddegrees = 0.0
    var Minutedegress = 0.0
    var Hoursdegress = 0.0
    var types:HandsTypes!
    
    init(HandsTypes t:HandsTypes,HandsColor c:CGColor,HandsLong l:CGFloat,frame:CGRect) {
        var frames = frame
        frames.origin.x = 0
        frames.origin.y = 0
        super.init(frame:frames)
        NSLog("JDWatch Hand init")
        self.handslong = l
        self.types = t
    
        handlayer.fillColor = c
        handlayer.lineWidth = 0.2
        handlayer.strokeColor = UIColor.black.cgColor
        self.middlePoint = CGPoint(x: frame.width/2, y: frame.height/2)
        
        if(t == .Hours)
        {
            drawHoursPath()
           
        }
        else if(t == .Minute)
        {
            drawMinutePath()
        }
        else if(t == .Second)
        {
            
        }
         self.layer.addSublayer(handlayer)
    }
    
    
    func drawHoursPath(){
        let hourspath:UIBezierPath = UIBezierPath()
        hourspath.move(to: CGPoint(x: self.middlePoint.x - 10, y: self.middlePoint.y))
        hourspath.addLine(to: CGPoint(x:self.middlePoint.x, y:self.middlePoint.y + 13))
        hourspath.addLine(to: CGPoint(x: self.middlePoint.x + 10, y: self.middlePoint.y))
        hourspath.addLine(to: CGPoint(x: self.middlePoint.x, y:self.middlePoint.y - self.handslong))
        hourspath.addLine(to: CGPoint(x: self.middlePoint.x - 10, y: self.middlePoint.y))
        hourspath.fill()
        hourspath.close()
        self.handlayer.path = hourspath.cgPath
    }
    
    func drawMinutePath(){
        let minutepath:UIBezierPath = UIBezierPath()
        minutepath.move(to: CGPoint(x: self.middlePoint.x - 5, y: self.middlePoint.y))
        minutepath.addLine(to: CGPoint(x:self.middlePoint.x, y:self.middlePoint.y + 10))
        minutepath.addLine(to: CGPoint(x: self.middlePoint.x + 5, y: self.middlePoint.y))
        minutepath.addLine(to: CGPoint(x: self.middlePoint.x, y:self.middlePoint.y - self.handslong))
        minutepath.addLine(to: CGPoint(x: self.middlePoint.x - 5, y: self.middlePoint.y))
        minutepath.fill()
        minutepath.close()
        self.handlayer.path = minutepath.cgPath
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension JDWatchHand:JDTimeTickingDelegate{
    
    func secondTicking()
    {
        if(self.types == .Second)
        {
           Seconddegrees += 6.0
           let radians = CGFloat(Seconddegrees * Double.pi / 180)
           self.layer.transform = CATransform3DMakeRotation(radians, 0.0, 0.0, 1.0)
        }
    }
    func minuteTicking()
    {
        if(self.types == .Minute)
        {
            Minutedegress += 6.0
            let radians = CGFloat(Minutedegress * Double.pi / 180)
            self.layer.transform = CATransform3DMakeRotation(radians, 0.0, 0.0, 1.0)
        }
    }
    func hourTicking()
    {
        if(self.types == .Hours)
        {
            Minutedegress += 30.0
            let radians = CGFloat(Minutedegress * Double.pi / 180)
            self.layer.transform = CATransform3DMakeRotation(radians, 0.0, 0.0, 1.0)
        }
    }
    func DirectSetTime(h:Int,m:Int,s:Int)
    {
        
    }
}
