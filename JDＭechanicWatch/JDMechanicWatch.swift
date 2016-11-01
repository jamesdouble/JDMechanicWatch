//
//  JDMechanicWatch.swift
//  JDＭechanicWatch
//
//  Created by 郭介騵 on 2016/10/29.
//  Copyright © 2016年 james12345. All rights reserved.
//

import UIKit

class JDMechanicWatch:UIView {
    
    //UI letout
    var watchtitles:UILabel = UILabel()
    var watchtimeslogic:JDTimeLogic!
    var watchface:JDClockBackGround!
    var HourHand:JDWatchHand?
    var MinuteHand:JDWatchHand?
    var SecondHand:JDWatchHand?
    
    //Variable
    var watchmiddlePoint:CGPoint!
    
    //Custom Boolen
    var showHour:Bool = true
    var showMinute:Bool = true
    var showSecond:Bool = true
    
    init(frame:CGRect,bgcolor:UIColor,GraduationColor g:UIColor){
        super.init(frame: frame)
        
        let watchfaceframe:CGRect = CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height)
        watchface = JDClockBackGround(frame: watchfaceframe, bgcolor: UIColor.white,GraduationColor: UIColor.black)
        self.addSubview(watchface)
        
        drawtimeHand()
        setTitleLabel(input: "JDMW\n 2016")
    }
    
    func setTitleLabel(input:String){
        watchtitles.removeFromSuperview()
        let titlesframe:CGRect = CGRect(x: 0.25 * self.frame.width, y: 1/9 * self.frame.height, width: 0.5 * self.frame.width, height: 30)
        watchtitles = UILabel(frame: titlesframe)
        watchtitles.numberOfLines = 0
        watchtitles.textAlignment = .center
        watchtitles.text = input
        watchtitles.font = UIFont.systemFont(ofSize: 10.0)
        self.addSubview(watchtitles)
        
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
        let dotcenter:CGPoint = CGPoint(x: self.frame.width/2 - 2, y: self.frame.height/2 - 2)
        let dotpath:UIBezierPath = UIBezierPath(arcCenter: dotcenter, radius: 2, startAngle: 0, endAngle:  CGFloat(2*M_PI), clockwise: true)
        centerdot.path = dotpath.cgPath
        centerdot.fillColor = UIColor.gray.cgColor
        self.layer.addSublayer(centerdot)
        //
        let ticking:Timer = Timer(timeInterval: 1.0, repeats: true, block: {_ in 
       // self.MinuteHand?.ticking(steps: 6.0)
        })
        RunLoop.main.add(ticking, forMode: .defaultRunLoopMode)
    }
    
    func initHourhand(){
        let hourhandscolor:UIColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
        HourHand = JDWatchHand(HandsTypes: .Hours, HandsColor: hourhandscolor.cgColor, HandsLong: self.frame.height/2 * 0.5,frame: self.frame)
        self.addSubview(HourHand!)
    }
    
    func initmiuntehand(){
        let minutescolor:UIColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
        MinuteHand = JDWatchHand(HandsTypes: .Minute, HandsColor: minutescolor.cgColor, HandsLong: self.frame.height/2 * 0.8,frame: self.frame)
        self.addSubview(MinuteHand!)
    }
    
    func initsecondhand(){
        
    }
    
    func testticking(){
    //    self.MinuteHand!.tickMinute()
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
