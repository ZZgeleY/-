//
//  PlayerViewController.m
//  工具
//
//  Created by lirui on 16/3/25.
//  Copyright © 2016年 张中烨. All rights reserved.
//

#import "PlayerViewController.h"
#import "AppDelegate.h"
#import "MusicModel.h"
@interface PlayerViewController ()
@property(nonatomic, retain)AppDelegate *delegate;
@property (weak, nonatomic) IBOutlet UISlider *slid;
@property(nonatomic, retain)NSMutableArray *arr;
@property(nonatomic,retain)MusicModel *model;
@property(nonatomic, assign)BOOL isPlay;
@property (weak, nonatomic) IBOutlet UIButton *bofang;
@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        [self data];
    
}
-(void)data
{  /**单例播放 退出不会停止*/
    self.delegate = [[UIApplication sharedApplication] delegate];
    //获取全局队列(并) 进行图片网址的网络请求 如果在请求过多的话会卡死
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       /**判断  再次进来从当时退出的位置进行播放*/
        if (_delegate.manager == nil) {
            _delegate.manager = [ PlayerManager defaultManager];
            NSString *path = [[ NSBundle mainBundle] pathForResource:@"MusicInfoList" ofType:@"plist"];
            NSArray *tempArr = [ NSArray arrayWithContentsOfFile:path];
            self.arr = [NSMutableArray array];
            for (NSDictionary *dic in tempArr) {
                self.model =[[ MusicModel alloc] init];
                [_model setValuesForKeysWithDictionary:dic];
                [self.arr addObject:_model.mp3Url];
                          }

        /**传数组*/
        _delegate.manager.musicArray = [NSMutableArray arrayWithArray:self.arr];
        
        }
    });
    
}
- (IBAction)sliderAction:(UISlider *)sender {
    [_delegate.manager pause];
    CGFloat current = sender.value *_delegate.manager.totalTime;
    [_delegate.manager seekToNewTime:current];
    [_delegate.manager play];

    
}

-(void)progressObserving{
    __weak PlayerViewController *VC = self;
    [self.delegate.manager.avPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {

        VC.slid.value = VC.delegate.manager.currentTime /VC.delegate.manager.totalTime;
        
        if (VC.slid.value == 1) {
            [VC.delegate.manager playerDidFinish];
        }
        
        
    }];
}

- (IBAction)bofang:(UIButton *)sender {
    _isPlay = !_isPlay;
    if (_isPlay) {
        _bofang.selected = NO;
        [_delegate.manager  play];
        [self progressObserving];
    }
    else
    { _bofang.selected = YES;
        [_delegate.manager pause];
    }
    
   
}
- (IBAction)next:(UIButton *)sender {
    
    [_delegate.manager nextMusic];
    
}
- (IBAction)last:(UIButton *)sender {
    [_delegate.manager lastMusic];
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
