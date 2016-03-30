//
//  DoneViewController.m
//  工具
//
//  Created by 李锐 on 16/3/27.
//  Copyright © 2016年 张中烨. All rights reserved.
//

#import "DoneViewController.h"

@interface DoneViewController ()

@end

@implementation DoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *ima = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 400)];
    ima.center = self.view.center;
    [self.view addSubview:ima];
    UIImage *img = [UIImage imageWithContentsOfFile:_str];
    ima.image = img;
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
