//
//  MineViewController.m
//  Travel_W
//
//  Created by 王萌 on 15/9/20.
//  Copyright (c) 2015年 WM. All rights reserved.
//

#import "MineViewController.h"

@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //事件的监听,按钮的操作
    [_imgButton addTarget:self action:@selector(avatarAction:forEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    //创建10个数组
    _array=[[NSMutableArray alloc]initWithObjects:@"a",@"f",@"g",@"e",@"t",@"y",@"u",@"h",@"i",@"q", nil];
    
    //把tableViewcell下面的下划线部分去掉
    _tableView.tableFooterView = [[UIView alloc]init];

}

//表格行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_array count];
}
//单元格内容设置
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *myId = @"demoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myId forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myId];
    }
    //    NSInteger rowInt = indexPath.row;
    //    NSString *titlestr = [_array objectAtIndex:rowInt];
    //    cell.textLabel.text = titlestr;
    cell.textLabel.text = [_array objectAtIndex:indexPath.row];
    return cell;
    
}

//avatarAction方法的实现（打开照片选择器）
-(void)avatarAction:(UIButton *)sender forEvent:(UIEvent *)event
{
    //添加这段代码要在。h文件里添加协议
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择", nil];
    [actionSheet setExclusiveTouch:YES];//setExclusiveTouch同时触发事件解决的方法,不能忘记添加
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];//现在是桌面上
}
//委托的方法
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==2) {
        return;//buttonIndex=2时结束该方法
    }
    
    UIImagePickerControllerSourceType temp;
    if (buttonIndex==0) {
        temp=UIImagePickerControllerSourceTypeCamera;//如果是第一个，类型是相机
    }
    else if (buttonIndex==1)
    {
        temp=UIImagePickerControllerSourceTypePhotoLibrary;//如果是第二个，类型是相册
        
    }
    //拍照不能相应操作
    if ([UIImagePickerController isSourceTypeAvailable:temp]) {
        //加载相册，更改头像
        _imagePickerController=nil;
        _imagePickerController=[[UIImagePickerController alloc]init];
        _imagePickerController.delegate=self;//在。h中加上协议
        _imagePickerController.allowsEditing=YES;//可编辑设为no(设置照片为不可编辑),如果设置成YES则编辑图片
        _imagePickerController.sourceType=temp;
        [self presentViewController:_imagePickerController animated:YES completion:nil];//用动画的方式加载在上面
        //加载相册，更改头像
        
    }else{
        if (temp==UIImagePickerControllerSourceTypeCamera) {
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"没有相应的设备" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
            [alertView show];//让alertView显示出来
        }
        else {
            //不支持相册
        }
    }
    
}

//照片编辑方法的实现
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];//选择原始图片
    UIImage *image=[info objectForKey:UIImagePickerControllerEditedImage];//编辑后的图片
    [_imgButton setBackgroundImage:image forState:UIControlStateNormal];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//照片编辑方法的实现

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
