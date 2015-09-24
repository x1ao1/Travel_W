//
//  homecellTableViewController.h
//  Travel_W
//
//  Created by 王亚丽 on 15/9/23.
//  Copyright (c) 2015年 WM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeTableViewCell.h"

@interface homecellTableViewController : UITableViewController
<HomeTableViewCellDelegate,UIActionSheetDelegate>
{
    NSIndexPath *ip;
    
}
@property (strong, nonatomic) UIImageView *zoomedIV;
@property (strong, nonatomic) NSMutableArray *objectsForShow;

@end
