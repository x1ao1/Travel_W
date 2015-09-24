//
//  homeObject.h
//  Travel_W
//
//  Created by 王亚丽 on 15/9/23.
//  Copyright (c) 2015年 WM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface homeObject : NSObject

@property (strong, nonatomic) NSString *imgUrl;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *content;
- (id)initWithDictionary:(NSDictionary *)dic;

@end
