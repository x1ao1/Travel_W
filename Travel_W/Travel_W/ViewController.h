//
//  ViewController.h
//  Travel_W
//
//  Created by WM on 15/9/19.
//  Copyright (c) 2015年 WM. All rights reserved.
//

#import <UIKit/UIKit.h>

//一个类里面可以声明出来多个类

//声明了一个继承自UIButton的ZYButton类 【和创建的一样】
@interface Button : UIButton
//添加属性  标记当前按钮是在上面还是下面  NO表示下面
//描述基本数据类型用assign
//描述对象数据类型用retain
//NSString  比较特殊 可以用retain  也可以用copy
@property (nonatomic,assign)BOOL isAtTop;
//用来记录当前有按钮的图片索引
@property (nonatomic,assign)int imageViewIndex;
//关联按钮的角度
@property (nonatomic,assign)int angle;
@end//@end为当前类的结束

//因为系统提供的类满足不了需求了  所以要考虑重定义类来实现
@interface ImageView : UIImageView

//该属性负责记录当前密码图上面有没有覆盖按钮  NO表示没有
@property (nonatomic,assign)BOOL isBtn;
@end

@interface ViewController : UIViewController

{
    //该数组负责装数字
    NSMutableArray *numberArr;
    
    //该数组存创建好的密码图
    NSMutableArray *passwordArr;
    
    //用来记录当前的正确次数
    int rightCount;
}

@end

