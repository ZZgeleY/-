//
//  ZIshiyinggaodu.h
//  工具类,张中烨
//
//  Created by 张张烨 on 16/3/25.
//  Copyright © 2016年 张中烨. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZIshiyinggaodu : NSObject

#if 0
在自定义文字高度那高度用
参数一:需要存的文字,
参数二:字体大小
参数三:需要的字体宽度
CGFloat labelHeight = [ZIshiyinggaodu AutoSizeOfHeightWithText:self.cellContent.descriptionF andFont:[UIFont systemFontOfSize:15] andLabelWidth:self.contentView.frame.size.width - 20]; 接收一下
图片高度
CGFloat photoHeight = ([参数高 floatValue] /[self.参数款 floatValue]) * (view宽 - 20);


table返回高度:
文字高度+图片高度+加需要的间距;
return siteViewHeight + textHeight + (30);

#endif
/**<  自适应高度封装 */
+ (CGFloat)AutoSizeOfHeightWithText:(NSString *)text andFont:(UIFont *)font andLabelWidth:(CGFloat)width;

+ (CGFloat)AutoSizeOfWidthWithText:(NSString *)text andFont:(UIFont *)font andLabelHeight:(CGFloat)height;
@end
