//
//  homecellTableViewController.m
//  Travel_W
//
//  Created by 王亚丽 on 15/9/23.
//  Copyright (c) 2015年 WM. All rights reserved.
//

#import "homecellTableViewController.h"
#import "homeObject.h"
@interface homecellTableViewController ()

@end

@implementation homecellTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self naviConfigration];//导航设置
    [self dataPreparation];//数据准备
    [self uiConfiguration];//界面操作
}

-(void)naviConfigration
{
    //标题字体颜色whiteColor
    NSDictionary* textTitleOpt = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil];
    //导航控制器对象
    [self.navigationController.navigationBar setTitleTextAttributes:textTitleOpt];
    //导航条标题
    self.navigationItem.title = @"活动";
    //导航条的背景色
    self.navigationController.navigationBar.barTintColor = [UIColor brownColor];
    //导航条上面左右的返回按钮色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //导航条隐藏  NO
    self.navigationController.navigationBar.hidden = NO;
    //导航条是否设置半透明
    [self.navigationController.navigationBar setTranslucent:YES];
}
-(void)dataPreparation
{
    NSDictionary *dicA = [NSDictionary dictionaryWithObjectsAndKeys:@"http://7u2h3s.com2.z0.glb.qiniucdn.com/activityImg_1_885E76C7-7EA0-423D-B029-2085C0F769E6", @"imgUrl", @"骑马", @"name", @"我们将提供马匹，从活动起点往西南至太湖畔，再沿太湖往西北至蠡湖，最后沿原路策马奔跑回起点", @"content", @30, @"like", @1, @"unlike", @0, @"applied", nil];//NSString NSNumber
    NSDictionary *dicB = [NSDictionary dictionaryWithObjectsAndKeys:@"http://7u2h3s.com2.z0.glb.qiniucdn.com/activityImg_3_2ADCF0CE-0A2F-46F0-869E-7E1BCAF455C1", @"imgUrl", @"浮潜", @"name", @"爸爸去哪儿路线重走，活动包含机票及住宿", @"content", @4, @"like", @3, @"unlike", @1, @"applied", nil];
    NSDictionary *dicC = [NSDictionary dictionaryWithObjectsAndKeys:@"http://7u2h3s.com2.z0.glb.qiniucdn.com/activityImg_2_0B28535F-B789-4E8B-9B5D-28DEDB728E9A", @"imgUrl", @"骑行", @"name", @"自备单车，骑行路线活动当日规划", @"content", @20, @"like", @2, @"unlike", @0, @"applied", nil];
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:dicA, dicB, dicC, nil];
    
    //  ****初始化 不然是空的****//
    _objectsForShow = [NSMutableArray new];
    //  ****初始化 不然是空的****//
    
    for (NSDictionary *dic in arr) {
        
        homeObject *object =[[homeObject alloc] initWithDictionary:dic];
        [_objectsForShow addObject:object];
        //[_objectsForShow addObject:[[ActivityObject alloc] initWithDictionary:dic]];
    }
    [self.tableView reloadData];
    
}
-(void)uiConfiguration
{
    //把tableViewcell下面的下划线部分去掉
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    //在可以滚动的控件里执行刷新的控件
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    NSString *title = [NSString stringWithFormat:@"下拉即可刷新"];
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setAlignment:NSTextAlignmentCenter];
    [style setLineBreakMode:NSLineBreakByWordWrapping];
    
    //设置的属性字典
    NSDictionary *attrsDictionary = @{NSUnderlineStyleAttributeName:
                                          @(NSUnderlineStyleNone),
                                      NSFontAttributeName:[UIFont preferredFontForTextStyle:UIFontTextStyleBody],
                                      NSParagraphStyleAttributeName:style,
                                      NSForegroundColorAttributeName:[UIColor brownColor]};
    
    
    NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
    refreshControl.attributedTitle = attributedTitle;
    //tintColor旋转的小花的颜色
    refreshControl.tintColor = [UIColor brownColor];
    //背景色 浅灰色
    refreshControl.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //执行的动作
    [refreshControl addTarget:self action:@selector(refreshData:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
}

//下拉刷新执行的方法
- (void)refreshData:(UIRefreshControl *)rc
{
    [self.tableView reloadData];
    //怎么样让方法延迟执行的
    [self performSelector:@selector(endRefreshing:) withObject:rc afterDelay:1.f];
}

- (void)endRefreshing:(UIRefreshControl *)rc {
    [rc endRefreshing];//闭合
}


#pragma mark - Table view data source
//

//每行的自适高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    homeObject *object = [_objectsForShow objectAtIndex:indexPath.row];
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityCell"];
    //屏幕的宽度
//    NSLog(@"%@", cell.label4.font);
    CGSize maxSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width - 30, 1000);
    
    //    //这段文字的尺寸大小
    CGSize contentLabelSize = [object.content boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:cell.nameLabel.font} context:nil].size;
    return cell.nameLabel.frame.origin.y + contentLabelSize.height + 18;
    //   //这段文字的尺寸大小
    
}
//行选择
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


//实现 点按出现大图片
- (void)photoTapAtIndexPath:(NSIndexPath *)indexPath
{
    // NSLog(@"top");
    homeObject *object = [_objectsForShow objectAtIndex:indexPath.row];
    _zoomedIV = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _zoomedIV.userInteractionEnabled = YES;
    _zoomedIV.image = [self imageUrl:object.imgUrl];
    //UIViewContentModeScaleAspectFit达到最长边
    _zoomedIV.contentMode = UIViewContentModeScaleAspectFit;
    _zoomedIV.backgroundColor = [UIColor blackColor];
    UITapGestureRecognizer *ivTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ivTap:)];
    [_zoomedIV addGestureRecognizer:ivTap];
    [[[UIApplication sharedApplication] keyWindow] addSubview:_zoomedIV];
}

//显示大图后让它回去
-(void)ivTap:(UITapGestureRecognizer *)tap
{
    if (tap.state == UIGestureRecognizerStateRecognized) {
        //移除
        [_zoomedIV removeFromSuperview];
        _zoomedIV = nil;
    }
}

//返回图片
- (UIImage *)imageUrl:(NSString *)url {
    if (nil == url || url.length == 0) {
        return nil;
    }
    static dispatch_queue_t backgroundQueue;
    if (backgroundQueue == nil) {
        backgroundQueue = dispatch_queue_create("com.beilyton.queue", NULL);
    }
    //获得了一个所有路径的集合
    NSArray *directories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //获得根目录documentDirectory
    NSString *documentDirectory = [directories objectAtIndex:0];
    __block NSString *filePath = nil;
    filePath = [documentDirectory stringByAppendingPathComponent:[url lastPathComponent]];//url网络地址（命名的）
    UIImage *imageInFile = [UIImage imageWithContentsOfFile:filePath];
    //拿文件
    if (imageInFile) {
        return imageInFile;
    }
    
    /*
     还未下载图片
     */
    
    //下载图片 NSData数据流
    __block NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    if (!data) {
        NSLog(@"Error retrieving %@", url);
        return nil;
    }
    //初始化数据流
    UIImage *imageDownloaded = [[UIImage alloc] initWithData:data];
    //写入文件
    dispatch_async(backgroundQueue, ^(void) {
        [data writeToFile:filePath atomically:YES];
        NSLog(@"Wrote to: %@", filePath);
    });
    return imageDownloaded;//二级缓存的意义
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
