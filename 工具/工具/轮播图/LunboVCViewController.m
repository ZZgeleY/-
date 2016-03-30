//
//  LunboVCViewController.m
//  工具
//
//  Created by 张张烨 on 16/3/25.
//  Copyright © 2016年 张中烨. All rights reserved.
//

#import "LunboVCViewController.h"
#import "LunBoTu.h"
@interface LunboVCViewController ()<LunBoTuDelegate>
@property (nonatomic,strong) NSMutableArray *dataArr;
@end

@implementation LunboVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    self.dataArr = [NSMutableArray array];
    self.dataArr = [@[@"1.jpg",@"22.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg",@"7.jpg",@"8.jpg",@"9999.jpg"] mutableCopy];
    
    LunBoTu *lun = [[LunBoTu alloc]init];
    lun.delegate = self;   //需要一个数组
    lun.time = 2; //时间
    [lun imageWithUrlArray:_dataArr frame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height / 2)];
    self.view =[lun pageControl]; //加下面的小点
    [self.view addSubview:[lun collectionView]];
}





/**<  轮播图点击 */
-(void)didSelectCollectionView:(UICollectionView *)collectionView atItemImdexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",indexPath.row);
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
