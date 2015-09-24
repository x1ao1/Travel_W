//
//  MineViewController.m
//  Travel_W
//
//  Created by 王萌 on 15/9/20.
//  Copyright (c) 2015年 WM. All rights reserved.
//

#import "MineViewController.h"
#import "LoginViewController.h"
#import "SetViewController.h"
@interface MineViewController ()
- (IBAction)LoginAction:(UIButton *)sender forEvent:(UIEvent *)event;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //把tableViewcell下面的下划线部分去掉
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.separatorColor = [UIColor clearColor];
    //获得当前用户
    PFUser *curentUser = [PFUser currentUser];
    _nameLabel.text = curentUser.username;
    
    //创建数组
    _imageArray=[[NSMutableArray alloc]initWithObjects:@"地址",@"标记",@"去过",@"积分",@"设置", nil];
    _array=[[NSMutableArray alloc]initWithObjects:@"地址",@"标记",@"去过",@"积分",@"设置", nil];



}
//跳转第二个页面
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SetViewController*dertails=[storyboard instantiateViewControllerWithIdentifier:@"Set"];
    
    //dertails.data = _data[indexPath.row];
    //dertails.rank=[dic objectForKey:@"text"];
    [self.navigationController pushViewController:dertails animated:YES];
}
//表格行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_array count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}
//单元格内容设置
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *myId = @"demoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myId forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myId];
    }
    cell.textLabel.text = [_array objectAtIndex:indexPath.row];
    
    NSString *name=[NSString stringWithFormat:@"%@.png",[self.imageArray objectAtIndex:[indexPath row]]];
    cell.imageView.image=[UIImage imageNamed:name];
    return cell;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)LoginAction:(UIButton *)sender forEvent:(UIEvent *)event {
     LoginViewController *login = [self.storyboard instantiateViewControllerWithIdentifier:@"Login"];
    
    //初始化导航控制器
    UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:login];
    //动画效果
    //nc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    //导航条隐藏掉
    nc.navigationBarHidden = YES;
    //类似那个箭头 跳转到第二个界面
    [self presentViewController:nc animated:YES completion:nil];
}

@end
