//
//  ModifiesPasswordViewController.m
//  Travel_W
//
//  Created by 王萌 on 15/9/24.
//  Copyright (c) 2015年 WM. All rights reserved.
//

#import "ModifiesPasswordViewController.h"

@interface ModifiesPasswordViewController ()
- (IBAction)Confirm:(UIButton *)sender forEvent:(UIEvent *)event;

- (IBAction)returnAction:(UIBarButtonItem *)sender;


- (IBAction)Return:(UIBarButtonItem *)sender;

@end

@implementation ModifiesPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//点击return返回键盘
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}

//点击空白处返回键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}


- (IBAction)Confirm:(UIButton *)sender forEvent:(UIEvent *)event {
    PFUser *currentUser = [PFUser currentUser];
    NSString *password = _t1.text;
    NSString *newpassword = _t2.text;
    NSString *newpassword2 = _t3.text;
    
    if ([password isEqualToString:[Utilities getUserDefaults:@"passWord"]]) {
        if ([newpassword isEqualToString:newpassword2]) {
            
            currentUser[@"password"] = _t2.text;
            UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
            
            
            [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)/*如果成功的插入数据库*/ {
                [aiv stopAnimating];
                
                if (succeeded) {
                    //  [Utilities setUserDefaults:@"password" content:_newpasswordTF.text];
                    
                    [Utilities setUserDefaults:@"passWord" content:_t3.text];
                    [Utilities popUpAlertViewWithMsg:@"成功修改！" andTitle:nil];
                    
                    [PFUser logOut];//退出Parse
                    [aiv stopAnimating];
                    
                    [PFUser logInWithUsernameInBackground:currentUser.username password:_t2.text block:^(PFUser *user, NSError *error) {
                        [aiv stopAnimating];
                        if (user) {
                            [self dismissViewControllerAnimated:YES completion:nil];
                        } else if (error.code == 101) {
                            [Utilities popUpAlertViewWithMsg:@"用户名或密码错误" andTitle:nil];
                        } else if (error.code == 100) {
                            [Utilities popUpAlertViewWithMsg:@"网络不给力，请稍后再试" andTitle:nil];
                        } else {
                            [Utilities popUpAlertViewWithMsg:nil andTitle:nil];
                            
                        }
                    }];
                } else {
                    [Utilities popUpAlertViewWithMsg:nil andTitle:nil];
                }
            }];
            
            
        }else{
            [Utilities popUpAlertViewWithMsg:@"俩次密码不一致，请重新输入" andTitle:nil];
        }
        
    }else{
        [Utilities popUpAlertViewWithMsg:@"与原密码不同，请重新输入" andTitle:nil];
    }

}

- (IBAction)returnAction:(UIBarButtonItem *)sender {
    //跳转到上一级页面
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
