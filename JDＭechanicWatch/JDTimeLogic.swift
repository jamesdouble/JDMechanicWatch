//
//  JDTimeLogic.swift
//  JDＭechanicWatch
//
//  Created by 郭介騵 on 2016/10/31.
//  Copyright © 2016年 james12345. All rights reserved.
//

import UIKit

protocol JDTimeTickingDelegate {
    func secondTicking()
    func minuteTicking()
    func hourTicking()
    func DirectSetTime(h:Int,m:Int,s:Int)
}

class JDTimeLogic{
    
    var delegate:JDTimeTickingDelegate?
    
    init()
    {
        
    }

    
}
