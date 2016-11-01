//
//  ViewController.swift
//  JDＭechanicWatch
//
//  Created by 郭介騵 on 2016/10/29.
//  Copyright © 2016年 james12345. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var watchView: UIView!
    var newView:JDMechanicWatch?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //畫面經過autolayout後 才會call這
    override func viewDidLayoutSubviews() {
        self.watchView.backgroundColor = UIColor.clear
        newView = JDMechanicWatch(frame: self.watchView.frame, bgcolor: UIColor.white,GraduationColor: UIColor.black)
        self.view.addSubview(newView!)

    }
    
    @IBAction func rotate(_ sender: AnyObject) {
        self.newView?.MinuteHand!.tickMinute()
    }
  
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}





