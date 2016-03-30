//
//  MBProgressHUDManager.h
//  工具
//
//  Created by 张张烨 on 16/3/25.
//  Copyright © 2016年 张中烨. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIView;
@class MBProgressHUD;

typedef NS_ENUM(NSUInteger, MBProgressHUDshowPlace) {
    Top,
    Center,
    Bottom,
};

@interface MBProgressHUDManager : NSObject

/*
 *brief 在view上添加文字提示HUD
 *param view 要添加在的view
 *param text 提示文字
 *param showPlace 显示位置
 *param height 高度
 */
+ (void)showTextHUDtoView:(UIView *)view string:(NSString *)text showPlace:(MBProgressHUDshowPlace)showPlace height:(float)height;


/*
 *brief 在view上添加描述文字(多行长文字)提示HUD
 *param view 要添加在的view
 *param detailsText  描述文字
 *param showPlace 显示位置
 */
+ (void)showDetailsTextHUDtoView:(UIView *)view string:(NSString *)detailsText showPlace:(MBProgressHUDshowPlace)showPlace;

/*
 *brief 在view上添加小菊花
 *param view 要添加在的view
 *param text  提示文字
 */
+ (void)showHUDtoView:(UIView *)view string:(NSString *)text;

// 移除HUD
+ (void)removeHUD;

@end
