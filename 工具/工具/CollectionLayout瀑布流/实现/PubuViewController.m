//
//  PubuViewController.m
//  工具
//
//  Created by 张张烨 on 16/3/25.
//  Copyright © 2016年 张中烨. All rights reserved.
//

#import "PubuViewController.h"
#import "AFN.h"
#import <UIImageView+WebCache.h>
#import "AotuLayout.h"
#import "PubuCell.h"
#import "PubuModel.h"

#import "MBProgressHUDManager.h"
#import <MBProgressHUD.h>  // 小菊花

@interface PubuViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,LayoutItemHeightDelegate>
{
    MBProgressHUD *HUD;
}
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *arr;
@end

@implementation PubuViewController

- (void)viewDidAppear:(BOOL)animated
{
    /**<  写在鸡肋呢 */
    [self showTextDialog];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self data];
    
    AotuLayout *layout = [[AotuLayout alloc]init];
    /**< 列数 */
    layout.columCounts = 2;
    /**< 列间距 */
    layout.columSpace = 5;
    /**< 行间距 */
    layout.rowSpace = 5;
    /**< 边距 */
    layout.edgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    
    layout.delegate = self;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , self.view.frame.size.height) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    // 滚动条隐藏
    _collectionView.showsVerticalScrollIndicator =NO;
    [self.view addSubview:_collectionView];
    //
    [_collectionView registerClass:[PubuCell class] forCellWithReuseIdentifier:@"collectioncell"];
    
}
#pragma mark - 小菊花实现
- (void)showTextDialog
{
    //初始化进度框，置于当前的View当中
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    //如果设置此属性则当前的view置于后台
    HUD.dimBackground = YES;
    
    //设置对话框文字
    HUD.labelText = @"请稍等";
    
    //显示对话框
    [HUD showAnimated:YES whileExecutingBlock:^{
        //对话框显示时需要执行的操作
        sleep(1);
    } completionBlock:^{
        //操作执行完后取消对话框
        [HUD removeFromSuperview];
        
        HUD = nil;
    }];
}

-(void)data
{
    [AFN getUrl:@"http://chanyouji.com/api/users/likes/268717.json?per_page=18&page=1" body:nil response:(LHJSON) requestHeadFile:nil success:^(NSURLSessionDataTask *task, id resposeObject) {
        NSArray *arr1 = resposeObject;
        self.arr = [PubuModel modelHanderWithArray:arr1];
        [_collectionView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma mark - 协议方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _arr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PubuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectioncell" forIndexPath:indexPath];
    cell.model = _arr[indexPath.item];
    
    
    return cell;
}

// 设置图片高度
- (CGFloat) layout:(QpLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexpath width:(CGFloat)width
{
    PubuModel *q = _arr[indexpath.item];
    CGFloat h = width *q.height.doubleValue / q.width.doubleValue;
    return h;
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
