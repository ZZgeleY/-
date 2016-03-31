//
//  ViewController.m
//  工具
//
//  Created by 张张烨 on 16/3/25.
//  Copyright © 2016年 张中烨. All rights reserved.
//

#import "ViewController.h"
#import "PubuViewController.h" // 瀑布流
#import <UIImageView+WebCache.h> // 图片加载
#import "AlertAndActionTool.h"  // 弹出封装
#import "UIViewController+NetJudge.h"//网络判断
#import "MBProgressHUDManager.h"//小菊花
#import <MBProgressHUD.h>  // 小菊花
#import "MovieViewController.h"//视频播放器
#import "LunboVCViewController.h" // 轮播图
#import "PlayerViewController.h" // 音频
#import "LvJingViewController.h" // 照相,滤镜
#import "DingweiVC.h" // 定位
#import "LiandongViewController.h"//联动效果
#import "XianchenViewController.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.dataArr = [ NSMutableArray array];
    self.dataArr = [@[@"collection瀑布",@"视频",@"轮播图",@"清除网络缓存数据",@"提示框1", @"提示框2",@"音乐播放器",@"下载",@"滤镜",@"定位",@"联动效果",@"多线程",@"图片选择器"] mutableCopy];
    /**<  网络解析自带本地缓存 */
    /**<  清除缓存方法在下方 */
    //判断网络
    [self networkJudgeWith:self];
   
    
    [self tableView1];
    
    
    
}


- (void)tableView1
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:(UITableViewStylePlain)];
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    [self.view addSubview:_tableView];
    

   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
   //这样为了搞掉重用池问题
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    
    cell.textLabel.text = _dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //collection瀑布流
    if (indexPath.row == 0) {
        PubuViewController *a = [[PubuViewController alloc]init];

        [self.navigationController pushViewController:a animated:YES];
    }
    // 视频
    if (indexPath.row == 1) {
        MovieViewController *moviee = [[MovieViewController alloc]init];
        moviee.name = @"视频";
        moviee.string =  @"http://flv2.bn.netease.com/videolib3/1505/24/HYUCE6348/SD/HYUCE6348-mobile.mp4";
       [self presentViewController:moviee animated:YES completion:^{
           
           
       }];
    }
    // 轮播图
    if (indexPath.row == 2) {
        LunboVCViewController *lunbo = [[LunboVCViewController alloc]init];
        [self.navigationController pushViewController:lunbo animated:YES];
    }
    //清缓
    if (indexPath.row == 3) {
        [self qingchuhuancun];
    }
    //弹窗
    if(indexPath.row == 4){
        [AlertAndActionTool showAlertWith:@"提示" AndContent:@"点击成功" AndViewController:self AndCallBack:^{
            //写实现的方法
        }];
        }
    //弹窗2
        if (indexPath.row == 5) {
            [AlertAndActionTool showActionSheetWithTitle:@"" Item1:@"张中烨傻" AndItem2:@"张中烨二傻" AndItem3:@"取消" AndViewController:self AndCallBack:^(int index) {
                if(index == 1)
                {
                    NSLog(@"第一个item干的事");
                }
                if(index == 2)
                {
                    NSLog(@"第二个item干的事");
                }
            }];
        
        
    }//音频播放器
     if(indexPath.row == 6)
     {
         UIStoryboard *sb =[ UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle] ];
         //通过id获取VC
         UIViewController *vc =[ sb instantiateViewControllerWithIdentifier:@"player"];
         [self.navigationController pushViewController:vc animated:YES];

     }
    //下载
    if(indexPath.row == 7)
    {
        UIStoryboard *sb =[ UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle] ];
        //通过id获取VC
        UIViewController *vc =[ sb instantiateViewControllerWithIdentifier:@"down"];
        [self.navigationController pushViewController:vc animated:YES];
    }
//滤镜
    if (indexPath.row == 8) {
        LvJingViewController *vc = [[LvJingViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    //定位
    if (indexPath.row == 9 ) {
        DingweiVC *vc = [[DingweiVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    //联动效果
    if(indexPath.row == 10)
    {
        LiandongViewController *liandong =[[ LiandongViewController alloc] init];
        [self.navigationController pushViewController:liandong animated:YES];
    }
    if (indexPath.row == 11) {
        UIStoryboard *sb =[ UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle] ];
        //通过id获取VC
        UIViewController *vc =[ sb instantiateViewControllerWithIdentifier:@"xiancheng"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if(indexPath.row == 12){
        UIStoryboard *sb =[ UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle] ];
        UIViewController *vc =[ sb instantiateViewControllerWithIdentifier:@"pick"];
        [self.navigationController pushViewController:vc animated:YES];
        
}

}
/**<  强制竖屏 */
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}


/**<  清除缓存 */
- (void)qingchuhuancun
{
    float tmpSize = [[SDImageCache sharedImageCache] getSize];
    
    NSString *clearMessage = tmpSize >= 1024 * 1024 ? [NSString stringWithFormat:@"清理缓存(%.2fM)" , tmpSize / 1024 / 1024] : [NSString stringWithFormat:@"清理缓存(%.2fK)", tmpSize / 1024];
    
    [AlertAndActionTool showAlertWith:@"提示" AndContent:clearMessage AndViewController:self AndCallBack:^{
        [[SDImageCache sharedImageCache]clearDisk];
    
        //清除内存缓存
        [[[SDWebImageManager sharedManager] imageCache] clearMemory];
        
        //清除系统缓存
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        
    }];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
