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
   case Child
}

class JDWathcHandController{
    
    var HourHand:JDWatchHand?
    var MinuteHand:JDWatchHand?
    var SecondHand:JDWatchHand?
    var childHand:JDWatchHand?
    var ParentView:UIView!
    
    //
    var Seconddegrees:Double = 0.0
    var Minutedegress:Double = 0.0
    var Hoursdegress:Double = 0.0
    
    //Custom Boolen
    var showHour:Bool = true
    var showMinute:Bool = true
    var showSecond:Bool = true
    
    init(parentview p:UIView,showh:Bool,showm:Bool,shows:Bool){
        ParentView = p
        showHour = showh
        showMinute = showm
        showSecond = shows
        
        drawtimeHand()
        
    }
    
    func drawtimeHand(){
        //畫出指針
        if(showHour)
        {
            initHourhand()
        }
        if(showMinute)
        {
            initmiuntehand()
        }
        if(showSecond)
        {
            initsecondhand()
        }
        //畫出中央點
        let centerdot:CAShapeLayer = CAShapeLayer()
        let dotcenter:CGPoint = CGPoint(x: self.ParentView.frame.width/2 , y:  self.ParentView.frame.height/2 )
        let dotpath:UIBezierPath = UIBezierPath(arcCenter: dotcenter, radius: 2, startAngle: 0, endAngle:  CGFloat(2*M_PI), clockwise: true)
        centerdot.path = dotpath.cgPath
        centerdot.fillColor = UIColor.gray.cgColor
        self.ParentView.layer.addSublayer(centerdot)
    }
    
    func initHourhand(){
        let hourhandscolor:UIColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
        HourHand = JDWatchHand(HandsTypes: .Hours, HandsColor: hourhandscolor.cgColor, HandsLong:  self.ParentView.frame.height/2 * 0.5,frame:  self.ParentView.frame)
         self.ParentView.addSubview(HourHand!)
    }
    
    func initmiuntehand(){
        let minutescolor:UIColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
        MinuteHand = JDWatchHand(HandsTypes: .Minute, HandsColor: minutescolor.cgColor, HandsLong:  self.ParentView.frame.height/2 * 0.8,frame:  self.ParentView.frame)
         self.ParentView.addSubview(MinuteHand!)
    }
    
    func initsecondhand(){
        let secondscolor:UIColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
        SecondHand = JDWatchHand(HandsTypes: .Second, HandsColor: secondscolor.cgColor, HandsLong:  self.ParentView.frame.height/2 * 0.95,frame:  self.ParentView.frame)
        self.ParentView.addSubview(SecondHand!)
    }
    
    func initchildsecond(){
        let childcolor:UIColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
        childHand = JDWatchHand(HandsTypes: .Child, HandsColor: childcolor.cgColor, HandsLong:  self.ParentView.frame.height/2 * 0.88,frame:  self.ParentView.frame)
        self.ParentView.addSubview(childHand!)
    }
    
    func removeParentHands(){
        SecondHand?.removeFromSuperview()
        SecondHand = nil
        MinuteHand?.removeFromSuperview()
        MinuteHand = nil
        HourHand?.removeFromSuperview()
        HourHand = nil
    }

    
    
}

extension JDWathcHandController:JDTimeTickingDelegate{
    
    func secondTicking(degree:Double)
    {
        if((SecondHand) != nil)
        {
            Seconddegrees += degree
            let radians = CGFloat(Seconddegrees * Double.pi / 180)
            SecondHand?.layer.transform = CATransform3DMakeRotation(radians, 0.0, 0.0, 1.0)
        }
        if((childHand) != nil)
        {
            Seconddegrees += degree
            let radians = CGFloat(Seconddegrees * Double.pi / 180)
            childHand?.layer.transform = CATransform3DMakeRotation(radians, 0.0, 0.0, 1.0)
        }
        
        if(Seconddegrees == 360.0)
        {
            Seconddegrees = 0.0
        }
    }
    func minuteTicking(degree:Double)
    {
       if((MinuteHand) != nil)
       {
            Minutedegress += degree
            let radians = CGFloat(Minutedegress * Double.pi / 180)
            MinuteHand?.layer.transform = CATransform3DMakeRotation(radians, 0.0, 0.0, 1.0)
        }
        
        if(Minutedegress == 360.0)
        {
            Minutedegress = 0.0
        }
    }
    func hourTicking(degree:Double)
    {
        if((HourHand) != nil)
        {
            Hoursdegress += degree
            let radians = CGFloat(Hoursdegress * Double.pi / 180)
            HourHand?.layer.transform = CATransform3DMakeRotation(radians, 0.0, 0.0, 1.0)
        }
        
        if(Hoursdegress == 360.0)
        {
            Hoursdegress = 0.0
        }
    }
    
    func DirectSetTime(h:Int,m:Int,s:Int)
    {
        let targethourdegress = Double(h) * 30.0
        if(targethourdegress >= Hoursdegress)   //順時鐘
        {
            Hoursdegress = targethourdegress
            let radians = CGFloat(Hoursdegress * Double.pi / 180)
            HourHand?.layer.transform = CATransform3DMakeRotation(radians, 0.0, 0.0, 1.0)
        }
        else{
            Hoursdegress = targethourdegress
            let radians = CGFloat((targethourdegress - Hoursdegress) * Double.pi / 180)
            HourHand?.layer.transform = CATransform3DMakeRotation(radians, 0.0, 0.0, -1.0)
        }
        
        let targetminutedegress = Double(m) * 6.0
        if(targetminutedegress >= Minutedegress)   //順時鐘
        {
            Minutedegress = targetminutedegress
            let radians = CGFloat(Minutedegress * Double.pi / 180)
            MinuteHand?.layer.transform = CATransform3DMakeRotation(radians, 0.0, 0.0, 1.0)
        }
        else{
            Minutedegress = targetminutedegress
            let radians = CGFloat((targetminutedegress - Minutedegress) * Double.pi / 180)
            MinuteHand?.layer.transform = CATransform3DMakeRotation(radians, 0.0, 0.0, -1.0)
        }
        
        let targetseconddegress = Double(s) * 6.0
        if(targetseconddegress >= Seconddegrees)   //順時鐘
        {
            Seconddegrees = targetseconddegress
            let radians = CGFloat(Seconddegrees * Double.pi / 180)
            SecondHand?.layer.transform = CATransform3DMakeRotation(radians, 0.0, 0.0, 1.0)
            childHand?.layer.transform = CATransform3DMakeRotation(radians, 0.0, 0.0, 1.0)
        }
        else{
            Seconddegrees = targetseconddegress
            let radians = CGFloat((targetseconddegress - Seconddegrees) * Double.pi / 180)
            SecondHand?.layer.transform = CATransform3DMakeRotation(radians, 0.0, 0.0, -1.0)
            childHand?.layer.transform = CATransform3DMakeRotation(radians, 0.0, 0.0, -1.0)
        }

    
    
    }
}



class JDWatchHand :UIView {
    
    var middlePoint:CGPoint = CGPoint()
    var handslong:CGFloat = 0.0
    var handlayer:CAShapeLayer = CAShapeLayer()
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
        handlayer.strokeColor = UIColor.lightGray.cgColor
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
            drawSecondPath()
        }
        else if(t == .Child)
        {
            drawChildPath()
        }
         self.layer.addSublayer(handlayer)
    }
    
    
    func drawHoursPath(){
      //  let ctx = UIGraphicsGetCurrentContext()
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
    
    func drawSecondPath(){
        let secondpath:UIBezierPath = UIBezierPath()
        secondpath.move(to: self.middlePoint)
        secondpath.addLine(to: CGPoint(x:self.middlePoint.x - 2, y:self.middlePoint.y + 20))
        secondpath.addLine(to: CGPoint(x: self.middlePoint.x + 2, y: self.middlePoint.y + 20))
        secondpath.addLine(to: self.middlePoint)
        secondpath.addLine(to: CGPoint(x: self.middlePoint.x , y: self.middlePoint.y - self.handslong))
        secondpath.fill()
        secondpath.close()
        self.handlayer.path = secondpath.cgPath
    }
    
    func drawChildPath(){
        let childpath:UIBezierPath = UIBezierPath(arcCenter: self.middlePoint, radius: 4, startAngle: 0, endAngle:  CGFloat(2*M_PI), clockwise: true)
        childpath.move(to: CGPoint(x:self.middlePoint.x - 1,y: self.middlePoint.y + 1))
        childpath.addLine(to: CGPoint(x: self.middlePoint.x - 1 , y: self.middlePoint.y - self.handslong))
        childpath.addLine(to: CGPoint(x: self.middlePoint.x + 1 , y: self.middlePoint.y - self.handslong))
        childpath.addLine(to: CGPoint(x:self.middlePoint.x + 1,y: self.middlePoint.y + 1))
        childpath.fill()
        childpath.close()
        self.handlayer.path = childpath.cgPath
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

