//
//  JDTimeLogic.swift
//  JDＭechanicWatch
//
//  Created by 郭介騵 on 2016/10/31.
//  Copyright © 2016年 james12345. All rights reserved.
//

import UIKit

protocol JDTimeTickingDelegate {
    func secondTicking(degree:Double)
    func minuteTicking(degree:Double)
    func hourTicking(degree:Double)
    func DirectSetTime(h:Int,m:Int,s:Int)
}

class JDTimeLogic{
    
    var delegate:JDTimeTickingDelegate?
    var childdelegate:JDTimeTickingDelegate?
    var MainTimer:Timer!
    var secondcount:Int = 0
    var minutecount:Int = 0
    var hourcount:Int = 0
    
    init()
    {
               timerStart()
    }
    
    func secondIncrease(){
        let secondDegress = 6.0
        let minuteDegress = 0.1
        let hourDegress = 0.1/12.0
 
        if(delegate != nil)
        {
        self.delegate?.secondTicking(degree: secondDegress)
        self.delegate?.minuteTicking(degree: minuteDegress)
        self.delegate?.hourTicking(degree: hourDegress)
        }
        if(childdelegate != nil)
        {
        self.childdelegate?.secondTicking(degree: secondDegress)
        }
        
        secondcount += 1
        if(secondcount == 60)
        {
            secondcount = 0
            minutecount += 1
        }
        if(minutecount == 60)
        {
            minutecount = 0
            hourcount += 1
        }
        if(hourcount == 12)
        {
            hourcount = 0
        }
    }
    
    func setTimer(h:Int,m:Int,s:Int){
        timerStop()
        secondcount = s
        minutecount = m
        hourcount = h
        self.delegate?.DirectSetTime(h: h, m: m, s: s)
        self.childdelegate?.DirectSetTime(h: h, m: m, s: s)
        timerStart()
    }
    
    
    func timerStop(){
        MainTimer.invalidate()
    }
    
    func timerStart()
    {
        MainTimer = Timer(timeInterval: 1.0, repeats: true, block: {_ in
            self.secondIncrease()
        })
        RunLoop.main.add(MainTimer, forMode: .defaultRunLoopMode)
    }

    
}
