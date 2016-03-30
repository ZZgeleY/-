//
//  GaoViewController.m
//  工具
//
//  Created by 张张烨 on 16/3/25.
//  Copyright © 2016年 张中烨. All rights reserved.
//

#import "GaoViewController.h"

@interface GaoViewController ()

@end

@implementation GaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    return siteViewHeight + textHeight + (30 * GAO);
    
#endif
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
