//
//  AlertAndActionTool.h
//  MaiYi
//
//  Created by 1 on 16/1/4.
//  Copyright © 2016年 张中烨. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^alertClickBlock)(void);
typedef void(^actionClickBlock)(int index);

@interface AlertAndActionTool : NSObject


/**<
 
 #这是对UIAlertController提示框的接口封装 这是出现两个选项的提示框,即确定和取消
 #第一个参数:是提示框的名字
 #第二个参数:是具体提示的信息 比如:收藏成功 发送成功 清理缓存
 #第三个参数:是由哪个VC来调用
 #第四个参数:利用block来调用点击确定之后的要实现的事情

*/



+ (void)showAlertWith:(NSString *)title AndContent:(NSString *)content AndViewController:(id)vController AndCallBack:(alertClickBlock)alertClick;


/**<  
 
 #这是有多个提示信息的提示框
 #第一个参数:提示框的名字 可写可不写
 #第二个参数:第一个提示信息
 #第三个参数:第二个提示信息
 #第四个参数:第三个提示信息 一般写取消
 #第五个参数:哪个VC来调用  一般写self
 #第六个参数:利用block来调用点击每个提示信息之后要实现的事情 并根据index的值来判断具体是哪一个提示信息的实现方法
 */
+ (void)showActionSheetWithTitle:(NSString *)title Item1:(NSString *)item1 AndItem2:(NSString *)item2  AndItem3:(NSString *)item3 AndViewController:(id)vController AndCallBack:(actionClickBlock)alertClick;

@end
