//
//  UIViewController+NetJudge.m
//  工具
//
//  Created by 张张烨 on 16/3/25.
//  Copyright © 2016年 张中烨. All rights reserved.
//

#import "UIViewController+NetJudge.h"
#import <AFNetworking.h>
@implementation UIViewController (NetJudge)
-(void)networkJudgeWith:(UIViewController *)viewController
{
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    // 2.设置网络状态改变后的处理
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        // 当网络状态改变了, 就会调用这个block
        switch (status) {
                
            case AFNetworkReachabilityStatusUnknown: // 未知网络
            {
                if ([[[UIDevice currentDevice]systemVersion] floatValue] > 8.0) {
                    
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"当前为未知网络" preferredStyle:UIAlertControllerStyleAlert];
                    /* 创建action对象 */
                    UIAlertAction *actionConfirm = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                        
                    }];
                    
                    /* alert添加action对象 */
                    [alert addAction:actionConfirm];
                    
                    [viewController presentViewController:alert animated:YES completion:^{
                        
                    }];
                }else {
                    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:nil message:@"当前网络未知" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
                    [alert show];
                    [alert dismissWithClickedButtonIndex:0 animated:YES];
                }
                
                break;
                
            }
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
            {
                if ([[[UIDevice currentDevice]systemVersion] floatValue] > 8.0){
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"亲!无网络!请查看网络设置" preferredStyle:UIAlertControllerStyleAlert];
                    /* 创建action对象 */
                    UIAlertAction *actionConfirm = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                        
                    }];
                    
                    /* alert添加action对象 */
                    [alert addAction:actionConfirm];
                    
                    [viewController presentViewController:alert animated:YES completion:^{
                        
                    }];
                }else {
                    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:nil message:@"当前网络不佳哦~请前往设置进行网络设置" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
                    [alert show];
                    [alert dismissWithClickedButtonIndex:0 animated:YES];
                }
                
                break;
                
            }
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
            {
                if ([[[UIDevice currentDevice]systemVersion] floatValue] > 8.0){
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"亲!正在使用手机3G/4G网" preferredStyle:UIAlertControllerStyleAlert];
                    /* 创建action对象 */
                    UIAlertAction *actionConfirm = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                        
                    }];
                    
                    /* alert添加action对象 */
                    [alert addAction:actionConfirm];
                    
                    [viewController presentViewController:alert animated:YES completion:^{
                        
                    }];
                }else {
                    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:nil message:@"当前网络状态为2G/3G/4G网络状态" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
                    [alert show];
                    [alert dismissWithClickedButtonIndex:0 animated:YES];
                }
                
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
            {
                if ([[[UIDevice currentDevice]systemVersion] floatValue] > 8.0){
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"当前为WIFI网络状态" preferredStyle:UIAlertControllerStyleAlert];
                    //                /* 创建action对象 */
                    UIAlertAction *actionConfirm = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                        
                    }];
                    
                    /* alert添加action对象 */
                    [alert addAction:actionConfirm];
                    //
                    [viewController presentViewController:alert animated:YES completion:^{
                        
                    }];
                }else {
                    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:nil message:@"当前网络状态为WIFI网络状态" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
                    [alert show];
                    [alert dismissWithClickedButtonIndex:0 animated:YES];
                }
                NSLog(@"WIFI");
                
                break;
            }
        }
    }];
    
    // 3.开始监控
    [manager startMonitoring];
    
}
@end
