//
//  ViewController.swift
//  JDＭechanicWatch
//
//  Created by 郭介騵 on 2016/10/29.
//  Copyright © 2016年 james12345. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timepicker: UIDatePicker!
    @IBOutlet weak var watchView: UIView!
    var newView:JDMechanicWatch?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func pick_date(_ sender: AnyObject) {
        let chooseDate = timepicker.date
        let nowhour = Calendar.current.component(.hour, from: chooseDate)
        let nowminute = Calendar.current.component(.minute, from: chooseDate)
        let nowsecond = Calendar.current.component(.second, from: chooseDate)
        newView?.setTime(hour: nowhour, minute: nowminute, second: nowsecond)
    }
    
    //畫面經過autolayout後 才會call這
    override func viewDidLayoutSubviews() {
        self.watchView.backgroundColor = UIColor.clear
        newView = JDMechanicWatch(frame: self.watchView.frame, bgcolor: UIColor.white,GraduationColor: UIColor.black,showchildwatch: true)
        self.view.addSubview(newView!)
        
        let nowday = Calendar.current.component(.day, from: Date())
        let nowhour = Calendar.current.component(.hour, from: Date())
        let nowminute = Calendar.current.component(.minute, from: Date())
        let nowsecond = Calendar.current.component(.second, from: Date())
        newView?.setDateLabel(inputday: nowday)
        newView?.setTime(hour: nowhour, minute: nowminute, second: nowsecond)
    
    }
    
    @IBAction func startButton(_ sender: AnyObject) {
        newView?.timeStart()
    }
    
    @IBAction func stopButton(_ sender: AnyObject) {
        newView?.timesPause()
    }
    
       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}





