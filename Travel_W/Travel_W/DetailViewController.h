//
//  DetailViewController.h
//  Travel_W
//
//  Created by 王亚丽 on 15/9/23.
//  Copyright (c) 2015年 WM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property(nonatomic,strong) PFObject *Attractions;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic)NSArray *objectsForShow;

@property (weak, nonatomic) IBOutlet UIImageView *photoIV;

@end
