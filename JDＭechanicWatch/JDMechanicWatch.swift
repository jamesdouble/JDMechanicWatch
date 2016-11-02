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
    var watchdateLabel:UILabel = UILabel()
    static var watchtimeslogic:JDTimeLogic!
    var watchface:JDClockBackGround!
    var watchhandcontroller:JDWathcHandController!
    var childwatch:JDChildMechanicWatch?
    
    //Variable
    //var watchmiddlePoint:CGPoint!
    var watchbackground:UIColor  = UIColor()
    var watchGraduationColor:UIColor = UIColor()
    
    
    //Custom Boolen
    var showHour:Bool = true
    var showMinute:Bool = true
    var showSecond:Bool = true
    var showChildWatch:Bool = true
    static var isChlid:Bool = false
    
    
    init(frame:CGRect,bgcolor:UIColor,GraduationColor g:UIColor,showchildwatch show:Bool){
        super.init(frame: frame)
        
        self.showChildWatch = show
        
        //鏡面
        let watchfaceframe:CGRect = CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height)
        watchface = JDClockBackGround(frame: watchfaceframe, bgcolor: UIColor.black,GraduationColor: UIColor.white)
        self.addSubview(watchface)
        
        //childwatch first
        setChildWatch()
        
        //Watch Hand
        watchhandcontroller = JDWathcHandController(parentview: self, showh: showHour, showm: showHour, shows: showHour)
        
        //Time logic
        if(JDMechanicWatch.watchtimeslogic == nil)
        {
            JDMechanicWatch.watchtimeslogic = JDTimeLogic()
        }
        if(showChildWatch && (!JDMechanicWatch.isChlid) && (childwatch != nil))
        {
        //Main Watch with child
        JDMechanicWatch.watchtimeslogic.delegate = watchhandcontroller
        self.watchface.drawGearBackground()
        }
        else if(!showChildWatch && (!JDMechanicWatch.isChlid) && (childwatch == nil))
        {
        //There are only Main
        JDMechanicWatch.watchtimeslogic.delegate = watchhandcontroller
        }
        else if((JDMechanicWatch.isChlid) && !showChildWatch)
        {
        //Child Watch
        JDMechanicWatch.watchtimeslogic.childdelegate = self.watchhandcontroller
        }
        
        //標題
        setTitleLabel(input: "JDMW\n 2016",titlecolor: UIColor.white)
        setDateLabel(inputday: 1)
        
        }
    
    
    
    func setChildWatch(){
        if(showChildWatch)
        {
            JDMechanicWatch.isChlid = true
            let childFrame:CGRect = CGRect(x: 1/3 * self.frame.width , y: 1/2 * self.frame.height + 20, width: 1/3 * self.frame.width , height: 1/2 * self.frame.height - 40)
            childwatch = JDChildMechanicWatch(frame: childFrame, bgcolor: self.watchbackground, GraduationColor: self.watchGraduationColor,showchildwatch: false)
            self.addSubview(childwatch!)
            JDMechanicWatch.isChlid = false //next must not child
        }
    }
    
    func setTitleLabel(input:String,titlecolor c:UIColor){
        watchtitles.removeFromSuperview()
        let titlesframe:CGRect = CGRect(x: 0.25 * self.frame.width, y: 1/9.3 * self.frame.height, width: 0.5 * self.frame.width, height: 30)
        watchtitles = UILabel(frame: titlesframe)
        watchtitles.numberOfLines = 0
        watchtitles.textAlignment = .center
        watchtitles.textColor = c
        watchtitles.text = input
        watchtitles.font = UIFont.systemFont(ofSize: 11.0)
        self.addSubview(watchtitles)
    }
    
    func setDateLabel(inputday d:Int)
    {
        watchdateLabel.removeFromSuperview()
        let dateframe:CGRect = CGRect(x: 0.8 * self.frame.width, y: 1/2 * self.frame.height - 10, width: 20, height: 15)
        watchdateLabel = UILabel(frame: dateframe)
        watchdateLabel.textAlignment = .center
        watchdateLabel.textColor = UIColor.black
        watchdateLabel.text = String(d)
        watchdateLabel.font = UIFont.systemFont(ofSize: 11.0)
        watchdateLabel.backgroundColor = UIColor.white
        self.addSubview(watchdateLabel)
    }
    
    func removeTitleLabel(){
        watchtitles.removeFromSuperview()
    }
    
    func removeDateLabel(){
        watchdateLabel.removeFromSuperview()
    }
    
    func timesPause(){
        JDMechanicWatch.watchtimeslogic.timerStop()
    }
    
    func timeStart()
    {
       JDMechanicWatch.watchtimeslogic.timerStart()
    }
    
    func setTime(hour:Int,minute:Int,second:Int){
        if((0 < hour) && (hour < 24) && (minute > 0) && (minute < 61) && (0 < second) && (second < 61)){
        JDMechanicWatch.watchtimeslogic.setTimer(h: hour, m: minute, s: second)
        }
        return
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class JDChildMechanicWatch:JDMechanicWatch{
    
    
     override init(frame:CGRect,bgcolor:UIColor,GraduationColor g:UIColor,showchildwatch show:Bool)
    {
        super.init(frame: frame, bgcolor: bgcolor, GraduationColor: g, showchildwatch: show)
        removeTitleLabel()
        removeParentHands()
        addChildHand()
        removeDateLabel()
    }
    
    func addChildHand(){
        self.watchhandcontroller.initchildsecond()
    }
    
    func removeParentHands(){
        self.watchhandcontroller.removeParentHands()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}



