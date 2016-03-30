//
//  MBProgressHUDManager.m
//  工具
//
//  Created by 张张烨 on 16/3/25.
//  Copyright © 2016年 张中烨. All rights reserved.
//
#define HEIGHT [UIScreen mainScreen].bounds.size.height

#import "MBProgressHUDManager.h"
#import <MBProgressHUD.h>
@implementation MBProgressHUDManager

+ (MBProgressHUD *)defaults {
    static MBProgressHUD *hud;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hud = [[MBProgressHUD alloc] init];
    });
    return hud;
}

// 文字提示
+ (void)showTextHUDtoView:(UIView *)view string:(NSString *)text showPlace:(MBProgressHUDshowPlace)showPlace height:(float)height {
    MBProgressHUD *hud = [self defaults];
    [view addSubview:hud];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    switch (showPlace) {
        case Top:
            hud.yOffset = -240 * HEIGHT / 667.0;
            break;
        case Center:
            break;
            
        case Bottom:
            hud.yOffset = 280 * HEIGHT / 667.0;
            break;
            
        default:
            break;
    }
    hud.margin = height * HEIGHT / 667.0;
    hud.labelFont = [UIFont systemFontOfSize:15];
    [hud showAnimated:YES whileExecutingBlock:^{
        sleep(2);
    } completionBlock:^{
        [hud removeFromSuperview];
    }];
}


// 描述提示
+ (void)showDetailsTextHUDtoView:(UIView *)view string:(NSString *)detailsText showPlace:(MBProgressHUDshowPlace)showPlace{
    MBProgressHUD *hud = [self defaults];
    [view addSubview:hud];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelText = detailsText;
    switch (showPlace) {
        case Top:
            hud.yOffset = -280 * HEIGHT / 667.0;
            break;
        case Center:
            break;
            
        case Bottom:
            hud.yOffset = 280 * HEIGHT / 667.0;
            break;
            
        default:
            break;
    }
    [hud showAnimated:YES whileExecutingBlock:^{
        sleep(2);
    } completionBlock:^{
        [hud removeFromSuperview];
    }];
}

// 添加HUD
+ (void)showHUDtoView:(UIView *)view string:(NSString *)text {
    MBProgressHUD *hud = [self defaults];
    [view addSubview:hud];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = text;
    [hud show:YES];
}

// 移除
+ (void)removeHUD {
    MBProgressHUD *hud = [self defaults];
    [hud removeFromSuperview];
}
@end
