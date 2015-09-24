//
//  ViewController.m
//  Travel_W
//
//  Created by WM on 15/9/19.
//  Copyright (c) 2015年 WM. All rights reserved.
//

#import "ViewController.h"
#import "MainViewController.h"
//这是关于Button的类实现
@implementation Button
@synthesize isAtTop;
@synthesize imageViewIndex;
@synthesize angle;
@end

//这是关于ZYImageView的类实现
@implementation ImageView
@synthesize isBtn;
@end

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIImageView *bgImg =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 380,680)];
    bgImg.image =[UIImage imageNamed:@"bg.jpg"];
    [self.view addSubview:bgImg];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(50, 50, 300, 100)];
    label.text = @"请输入随机密码，进入首页！";
    label.font = [UIFont boldSystemFontOfSize:50];
    label.adjustsFontSizeToFitWidth = YES;
    //label.numberOfLines = 1;
    [self.view addSubview:label];

    
    
    //创建10个解锁按钮
    for (int i=0; i<10; i++)
    {
        //行数
        int rows =i/5;
        
        //列数
        int column =i%5;
        
        //间隔  5是按钮的个数  6是间隔数
        int rowInterVal =(380 -5*40)/6;
        
        //按钮的宽高
        int buttonWidth =40,buttonHeight =40;
        
        //考虑需要一个属性来控制按钮是在上面还是在下面
        Button *button =[Button buttonWithType:UIButtonTypeCustom];
        
        //x =间隔+列数*(按钮的宽+间隔)
        //y =300 +行数*(按钮的高+间隔)
        button.frame =CGRectMake(rowInterVal+column*(buttonWidth +rowInterVal), 300+rows*(buttonHeight +rowInterVal), buttonWidth, buttonHeight);
        button.backgroundColor =[UIColor clearColor];
        
        //添加tag值
        button.tag =i+1;
        
        //添加图片
        /*
         1~~~0效果
         for  0~~~~9
         tag值 1~~~10
         
         tag%10 1~~~0
         */
        NSString *imgName =[NSString stringWithFormat:@"s_%d.png",(i+1)%10];
        [button setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
        
        //为按钮绑定方法
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:button];
    }
    
    //创建四个不重复的随机解锁图片
    
    
    numberArr =[[NSMutableArray alloc]initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    
    //切记 可变数组用之前一定要初始化
    passwordArr =[[NSMutableArray alloc]initWithCapacity:0];
    
    for (int i=0; i<4; i++)
    {
        //更改随机的4个数字的位置
        ImageView *imageView =[[ImageView alloc]initWithFrame:CGRectMake(50+i*75, 180, 50, 50)];
        imageView.backgroundColor =[UIColor clearColor];
        
        //取随机数
        //重复  防止越界
        //        int numArc =arc4random() %10;
        //
        int numArc =arc4random() %numberArr.count;
        //取出来数组里面的值
        NSString *numStr =[numberArr objectAtIndex:numArc];
        
        //因为没有办法获取到图片的内容 ，可以让imageView的Tag值和图片用成一样的，也就意味着找到tag就能知道图片的内容
        imageView.tag =[numStr intValue];
        
        //图片的名字
        NSString *imgName =[NSString stringWithFormat:@"b_%@.png",numStr];
        
        imageView.image =[UIImage imageNamed:imgName];
        
        [self.view addSubview:imageView];
        
        //用过之后从数组里面删除 防止重复
        [numberArr removeObject:numStr];
        
        //把创建好的四个密码图存到数组当中去  备用
        [passwordArr addObject:imageView];
    }
}
//点击按钮的时候会把按钮的对象传过来
-(void)btnClick:(Button *)button
{
    //想要让按钮上去  首先保证1，然后保证2
    
    //NO   1.表示该按钮在下面应该飞上去
    if (!button.isAtTop)
    {
        for (int i=0; i<passwordArr.count; i++)
        {
            //遍历数组里面的对象
            ImageView *imageView =[passwordArr objectAtIndex:i];
            //2. 上面没有覆盖按钮
            if (!imageView.isBtn)
            {
                //关闭当前屏幕的响应
                self.view.userInteractionEnabled =NO;
                
                //此时此刻才可以进行按钮的上移
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                //动画效果  就是让按钮的中心点=图片的中心点
                button.center =imageView.center;
                [UIView setAnimationDelegate:self];
                //动画完成之后会调用该方法
                [UIView setAnimationDidStopSelector:@selector(goMain)];
                
                [UIView commitAnimations];
                
                //改标记 按钮上去
                button.isAtTop =YES;
                //按钮已经覆盖上
                imageView.isBtn =YES;
                
                //记录当前是第几张图片上面覆盖按钮 方便一会从数组中查找
                button.imageViewIndex =i;
                
                //让按钮在最上层
                [self.view bringSubviewToFront:button];
                
                //i 表示当前循环到数组中第几个才产生的特效
                
                //BUTTON.Tag ==ImageView.tag
                
                //按钮的tag值为1~~10;
                //图片的tag值为 0~~~9
                //(1~~10)%10  1~~0
                //匹配成功
                if (button.tag %10 ==imageView.tag)
                {
                    rightCount ++;
                }
                
                //for循环  什么时候找到什么时候跳
                break;
            }
            //见到break  就跳出
            //不管找到没找到都只执行一次就跳出
            //            break;
        }
    }
    else  //按钮下落
    {
        //这样哪一个按钮点 取到的只是那一个按钮的tag值
        long i =button.tag - 1;
        
        //行数
        long rows =i/5;
        
        //列数
        int column =i%5;
        
        //间隔  5是按钮的个数  6是间隔数
        int rowInterVal =(380 -5*40)/6;
        
        //按钮的宽高
        int buttonWidth =40,buttonHeight =40;
        
        [UIView beginAnimations:nil context:nil];
        
        [UIView setAnimationDuration:1];
        //只是当前点击按钮的frame
        button.frame =CGRectMake(rowInterVal+column*(buttonWidth +rowInterVal), 300+rows*(buttonHeight +rowInterVal), buttonWidth, buttonHeight);
        [UIView commitAnimations];
        
        
        //按钮下来之后要设置成最初的NO状态  否则没办法飞上去
        button.isAtTop =NO;
        
        //需要找到当前上面盖有按钮的图片 标记变为no
        //把刚才记录的图片取出来
        ImageView *imageView =[passwordArr objectAtIndex:button.imageViewIndex];
        imageView.isBtn =NO;
        
        //下来的时候要--
        if (button.tag %10 ==imageView.tag)
        {
            rightCount --;
        }
    }
}

-(void)goMain
{
    self.view.userInteractionEnabled =YES;
    if (rightCount == 4)
    {
        NSLog(@"可以进入主界面");
        
        //获得TabViewController的名字，跳转到TabViewController
        MainViewController *tabVC=[Utilities getStoryboardInstanceByIdentity:@"Tab"];
        UINavigationController* naviVC = [[UINavigationController alloc] initWithRootViewController:tabVC];//创建导航控制器
        naviVC.navigationBarHidden = YES;//隐藏导航条
        
        //获得入口类的对象
        AppDelegate *app =[UIApplication sharedApplication].delegate;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:2];
        //动画效果
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:app.window cache:YES];
        [UIView commitAnimations];
        app.window.rootViewController =naviVC;
        
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
