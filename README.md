# JDMechanicWatch

###Preview：

![Alt text](/../master/Readme_img/JDMechanicWatch.gif?raw=true "") 

***
#Introduction

JDMechanicWatch can show time in a MechanicWatch look.
Thanks for using.

p.s. the background is image.
***
#Usage

var MW:JDMechanicWatch = JDMechanicWatch(frame: self.watchView.frame, bgcolor: UIColor.white,GraduationColor: UIColor.black,showchildwatch: true)
self.view.addSubview(newView!)

`showchildwatch`: Show the small watch on the main watch (BackgroundColor & GraduationColor same as Main Watch).

###Method:

`setTitleLabel(input:String,titlecolor c:UIColor)`:Set the title(default is JDMW/n 2016).

`setDateLabel(inputday d:Int)`:Change Date display on the right.

`timesPause()`:Pause the watch

`timeStart()`:Continue the watch

`setTime(hour:Int,minute:Int,second:Int)`:Directly Set the time u want.
