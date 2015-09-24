//
//  SearchViewController.m
//  Travel_W
//
//  Created by 王亚丽 on 15/9/22.
//  Copyright (c) 2015年 WM. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self dataPreparation];//数据准备
    [self uiSetUp];        //界面操作
}

- (void)dataPreparation
{
    //初始化
    self.keys = [NSMutableArray array];
    //文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"citydict" ofType:@"plist"];
    //文件的内容
    self.cities = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    //通过keys获取所有的allkeys值，然后进行compare排序比较
    [self.keys addObjectsFromArray:[[self.cities allKeys] sortedArrayUsingSelector:@selector(compare:)]];
}
- (void)uiSetUp
{
    //把tableViewCell下面的下划线部分去掉
    _tableView.tableFooterView = [[UIView alloc] init];
}

#pragma mark - tableView

//分组标题的行高(不写系统也默认20)
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0;
}


//分组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return [_keys count];
}

//显示分组标题 titleForHeaderInSection显示文字用这个
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_keys objectAtIndex:section];
}

//显示右侧的内容
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _keys;
}
//表格行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //keys把所有的ABCD..提取出来，cities是把ABCD..里面的值显示出来
    NSString *key = [_keys objectAtIndex:section];
    NSArray *citySection = [_cities objectForKey:key];
    return [citySection count];
}

//单元格内容设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = [_keys objectAtIndex:indexPath.section];
    NSArray *cities = [_cities objectForKey:key];
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        [cell.textLabel setTextColor:[UIColor blackColor]];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
    }
    //cell.textLabel.text = [[[_cities objectForKey:key] objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.textLabel.text = [[cities objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    return cell;
}

//行选择
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
