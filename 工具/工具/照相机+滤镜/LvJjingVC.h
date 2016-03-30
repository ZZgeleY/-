//
//  LvJjingVC.h
//  工具
//
//  Created by 张张烨 on 16/3/28.
//  Copyright © 2016年 张中烨. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LvJjingVC : UIViewController
@property (nonatomic, strong) UIImage* originalImage;
@property (nonatomic, strong) UIImage* image;
@property (nonatomic, strong) NSArray *pickerViewData;
@property (nonatomic, assign) void (^changeImgBlock) (NSString*);
+ (UIImage *) effectImage: (UIImage *)uIImage byFilterName:(NSString *)filterName;

@end
