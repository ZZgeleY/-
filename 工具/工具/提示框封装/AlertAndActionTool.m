//
//  AlertAndActionTool.m
//  MaiYi
//
//  Created by 1 on 16/1/4.
//  Copyright © 2016年 张中烨. All rights reserved.
//

#import "AlertAndActionTool.h"

@implementation AlertAndActionTool


+ (void)showAlertWith:(NSString *)title AndContent:(NSString *)content AndViewController:(id)vController AndCallBack:(alertClickBlock)alertClick
{
    UIAlertController  *alertVC = [UIAlertController alertControllerWithTitle:title message:content preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *acionCon = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        alertClick();
    }];
    UIAlertAction *acionCancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //模态取消alertview
        [alertVC dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    [alertVC addAction:acionCon];
    [alertVC addAction:acionCancle];
    [vController presentViewController:alertVC animated:YES completion:^{
        
    }];
}


+ (void)showActionSheetWithTitle:(NSString *)title Item1:(NSString *)item1 AndItem2:(NSString *)item2  AndItem3:(NSString *)item3 AndViewController:(id)vController AndCallBack:(actionClickBlock)alertClick
{
    UIAlertController  *alertVC = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *acionCon1 = [UIAlertAction actionWithTitle:item1 style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        alertClick(1);
    }];
    UIAlertAction *acionCon2 = [UIAlertAction actionWithTitle:item2 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        alertClick(2);
    }];
   
 
    UIAlertAction *acionCancle = [UIAlertAction actionWithTitle:item3 style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //模态取消alertview
        [alertVC dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];

    [alertVC addAction:acionCon1];
    [alertVC addAction:acionCon2];
    [alertVC addAction:acionCancle];

    [vController presentViewController:alertVC animated:YES completion:^{
        
    }];

}

@end
