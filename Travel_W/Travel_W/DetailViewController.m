//
//  DetailViewController.m
//  Travel_W
//
//  Created by 王亚丽 on 15/9/23.
//  Copyright (c) 2015年 WM. All rights reserved.
//

#import "DetailViewController.h"
#import "DetTableViewCell.h"
@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //到parse读取数据
    [self requestData];
    //去掉tableView多余的下划线
    _tableView.tableFooterView=[[UIView alloc]init];
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@", _Attractions[@"Name"]];
    //*************下载图片*************
    PFFile *photo = _Attractions[@"Photo"];
    [photo getDataInBackgroundWithBlock:^(NSData *photoData, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:photoData];
            dispatch_async(dispatch_get_main_queue(), ^{
                _photoIV.image = image;
            });
        }
    }];
    //*************下载图片*************
     //_textviewIV.text = _Attractions[@"description"];
   
}
//返回tableview的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _objectsForShow.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];//复用Cell
    //获得数据
    PFObject *object = [_objectsForShow objectAtIndex:indexPath.row];
    //得到名字
    //NSLog(@"%@", object[@"Name"]);
    //cell.miaoshu.text = object[@"Name"];
    cell.miaoshu.text =object[@"Pirce"];
//    cell.citynameLabel.text =object[@"City"];
    
     return cell;
}

//通知 到parse读取数据
- (void)requestData {
    //查询Attractions表中当前用户所有字段
    PFQuery *query = [PFQuery queryWithClassName:@"Attractions"];

    //菊花 指示器
    //UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
    [query findObjectsInBackgroundWithBlock:^(NSArray *returnedObjects, NSError *error) {
        //[aiv stopAnimating];//停止动画
        if (!error) {
            _objectsForShow = returnedObjects;
            NSLog(@"%@", _objectsForShow);
            [_tableView reloadData];
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

//取消选择tableView
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


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
