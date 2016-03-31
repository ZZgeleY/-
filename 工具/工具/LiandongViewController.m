//
//  LiandongViewController.m
//  工具
//
//  Created by 张中烨 on 16/3/30.
//  Copyright © 2016年 张中烨. All rights reserved.
//

#import "LiandongViewController.h"
#import "TopScView.h"
#define WIDTH    [UIScreen mainScreen].bounds.size.width / 375
#define HEIGHT   [UIScreen mainScreen].bounds.size.height / 667
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface LiandongViewController ()<TopScViewOriginDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,retain)TopScView *top;
@property(nonatomic,retain)UICollectionView *collectionView;
@end

@implementation LiandongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.top =[[TopScView alloc]initWithFrame:CGRectMake(0, 0,WIDTH * 375 ,HEIGHT * 40)];
    
    self.top.dataArr = @[@"11",@"22",@"33",@"44",@"55"].mutableCopy;
    self.top.delegate = self;
    [self.view addSubview:self.top];
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.itemSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height - 40);
    flow.minimumLineSpacing = 0;
    flow.minimumInteritemSpacing = 0;
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height - 40) collectionViewLayout:flow];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.pagingEnabled = YES;
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.top.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr = @[[UIColor cyanColor], [UIColor cyanColor], [UIColor yellowColor], [UIColor grayColor], [UIColor purpleColor], [UIColor greenColor], [UIColor redColor]];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = arr[indexPath.row];
    return cell;
}

- (void)PassOriginWithX:(CGFloat)x
{
    [_collectionView setContentOffset:CGPointMake(x, 0) animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"%f", scrollView.contentOffset.x);
    // 把collectionView的位移传入TopScView中
    [self.top changeContentOffsetWithH:scrollView.contentOffset.x];

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
