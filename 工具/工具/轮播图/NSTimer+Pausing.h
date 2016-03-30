//
//  NSTimer+Pausing.h
//  Project
//
//  Created by dllo on 15/9/21.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Pausing)


- (NSMutableDictionary *)pauseDictionary;
- (void)pause;
- (void)resume;

@end
