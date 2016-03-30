//
//  PubuModel.h
//  工具
//
//  Created by 张张烨 on 16/3/25.
//  Copyright © 2016年 张中烨. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PubuModel : NSObject
@property (nonatomic, strong)NSString *photo_url;
@property (nonatomic, strong)NSNumber *width;
@property (nonatomic, strong)NSNumber *height;
- (instancetype)initWithDic:(NSDictionary *)dic;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

+ (instancetype)modelWithDic:(NSDictionary *)dic;
// 数组+字典 -> 数组 +对象
+ (NSMutableArray *)modelHanderWithArray:(NSArray *)arr;
@end
