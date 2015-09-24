//
//  homeObject.m
//  Travel_W
//
//  Created by 王亚丽 on 15/9/23.
//  Copyright (c) 2015年 WM. All rights reserved.
//

#import "homeObject.h"

@implementation homeObject
- (id)initWithDictionary:(NSDictionary *)dic
{
    
self.imgUrl = [dic objectForKey:@"imgUrl"];
self.name = [dic objectForKey:@"name"];
self.content = [dic objectForKey:@"content"];
    
}

@end
