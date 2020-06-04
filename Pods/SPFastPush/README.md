# SPFastPush

#pod 'SPFastPush'                 

#Use Macro push VC,KVC assign parameter,Pop a VC,Present a VC,Dismiss VC.使用宏pushVC,KVC赋值参数,弹出VC,收回VC,一个vc跳转路由"

#本公开库非常实用，代替了经常使用导航控制器需要写很多代码的需要
一个ViewController跳转的路由Router，遍历获取当前APP最上层topVC，NavigationVC，TabVC使用宏快速push下一个Viewcontroller,也可以快速指定的VC，在非VC类想要实现顶层添加等功能很有用
#使用宏定义快速push一个VC，原理是遍历当前控制器的导航栈，使用导航控制器push方法，dict字典里面可以传参数，实现原理是KVC动态赋值，并返回push产生的VC对象

 1.使用宏帮助导航控制器快速push下一个VC(pushVC),
 2.利用KVC原理赋值参数,
 3.快速返回导航栈内指定的VC(popVC),
 4.快速弹出一个VC（presentVC）
 5.快速收回一个VC（dismissVC）
 6.get方法得到根视图控制器，导航控制器，标签控制器，最上层显示的控制器

#7.增加UIApplication OpenURL的宏定义快捷使用方法，以及打开系统通知，系统定位等
