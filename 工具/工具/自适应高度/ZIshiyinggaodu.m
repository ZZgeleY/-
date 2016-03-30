//
//  ZIshiyinggaodu.m
//  工具类,张中烨
//
//  Created by 张张烨 on 16/3/25.
//  Copyright © 2016年 张中烨. All rights reserved.
//

#import "ZIshiyinggaodu.h"

@implementation ZIshiyinggaodu

+ (CGFloat)AutoSizeOfHeightWithText:(NSString *)text andFont:(UIFont *)font andLabelWidth:(CGFloat)width{
    CGSize size = CGSizeMake(width, MAXFLOAT);
    NSDictionary *attributesDic = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    CGRect frame = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDic context:nil];
    return frame.size.height;
}

+ (CGFloat)AutoSizeOfWidthWithText:(NSString *)text andFont:(UIFont *)font andLabelHeight:(CGFloat)height{
    CGSize size = CGSizeMake(MAXFLOAT, height);
    NSDictionary *attributesDic = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    CGRect frame = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDic context:nil];
    return frame.size.width;
}

@end
