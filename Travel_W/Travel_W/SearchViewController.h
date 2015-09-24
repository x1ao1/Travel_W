//
//  SearchViewController.h
//  Travel_W
//
//  Created by 王亚丽 on 15/9/22.
//  Copyright (c) 2015年 WM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSMutableDictionary * cities;
@property (nonatomic,strong)NSMutableArray *keys;

@end
