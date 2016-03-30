//
//  PubuModel.m
//  工具
//
//  Created by 张张烨 on 16/3/25.
//  Copyright © 2016年 张中烨. All rights reserved.
//

#import "PubuModel.h"

@implementation PubuModel
// 初始化
- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
// 便利构造器
+ (instancetype)modelWithDic:(NSDictionary *)dic
{
    id m = [[[self class] alloc]initWithDic:dic] ;
    return m;
}

+ (NSMutableArray *)modelHanderWithArray:(NSArray *)arr
{
    // 1. 创建空数组 保存处理后的model 对象
    NSMutableArray *mArr= [NSMutableArray array];
    // 2.遍历传入的数组参数 得到每个字典信息
    for (NSDictionary *dic in arr) {
        id m = [[self class] modelWithDic:dic];
        [mArr addObject:m];
    }
    return mArr;
}
- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    // 当key找不到对应的属性时 表示不需要该数据
}

@end
