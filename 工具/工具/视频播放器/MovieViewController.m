//
//  MovieViewController.m
//  Tour
//
//  Created by 张张烨 on 16/3/13.
//  Copyright © 2016年 张中烨. All rights reserved.
//

#import "MovieViewController.h"
#import <AVFoundation/AVFoundation.h>


@interface MovieViewController ()
// 播放器属性
@property (nonatomic, retain) UIView *playView;/**< 播放视图 */
@property (nonatomic, retain) AVPlayer *player;/**< 播放器对象 */
@property (nonatomic, retain) AVPlayerLayer *playerLayer;/**< 播放图层 */
@property (nonatomic, retain) AVPlayerItem *playItem;/**< 播放对象 */
@property (nonatomic, assign) CGFloat totalDurantion;/**< 总时长 */
@property (nonatomic, assign) BOOL isPlay;/**< 播放状态 */
@property (nonatomic, assign) BOOL isDismiss;/**< 隐藏状态 */

// 播放器控制属性
@property (nonatomic, retain) UIView *controlView;/**< 控制视图 */
@property (nonatomic, retain) UIButton *horizontalButton;/**< 横屏按钮 */
@property (nonatomic, retain) UISlider *slider;/**< 进度控制条 */
@property (nonatomic, retain) UILabel *timeLabel;/**< 时间 */
@property (nonatomic, retain) UILabel *titleLabel;/**< 标题 */
@property (nonatomic, retain) UIButton *switchButton;/**< 开关按钮 */
@property (nonatomic, retain) UIButton *closeButton;/**< 关闭按钮 */
@property (nonatomic, retain) UIView *topControlView;/**< 顶部视图 */
@end

@implementation MovieViewController
/**<  这个强制横屏 太强制了,强制了之后就竖不会来了*/
-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
//        SEL selector = NSSelectorFromString(@"setOrientation:");
//        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
//        [invocation setSelector:selector];
//        [invocation setTarget:[UIDevice currentDevice]];
//        int val = UIInterfaceOrientationLandscapeRight;
//        [invocation setArgument:&val atIndex:2];
//        [invocation invoke];
//    }
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    // 创建播放器
    // 创建播放器视图
    self.playView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width)];
    //_playView.backgroundColor = [UIColor redColor];
    self.navigationController.navigationBarHidden = YES;
    [self.view addSubview:_playView];
    
    // 创建播放器对象
    self.playItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:self.string]];
    
    // 创建播放器
    self.player = [AVPlayer playerWithPlayerItem:_playItem];
    
    // 创建显示layer
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    // layer大小
    _playerLayer.frame = self.playView.bounds;
    
    // 视频填充模式
    _playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    // 将显示的图层放在页面里显示
    [_playView.layer insertSublayer:_playerLayer atIndex:0];
    
    // 添加控制器
    [self control];
    
    self.titleLabel.text = self.title;
    
    [_player play];
    
    _isPlay = YES;
    
}


- (void)control
{
    // 底部视图
    self.controlView = [[UIView alloc] initWithFrame:CGRectMake(0, self.playView.frame.size.height - 50, self.playView.frame.size.width, 50)];
    _controlView.backgroundColor = [UIColor grayColor];
    _controlView.alpha = 0.8;
    [self.playView addSubview:_controlView];
    
    // 暂停开关
    self.switchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.switchButton setImage:[UIImage imageNamed:@"zanting"] forState:(UIControlStateNormal)];
    [self.switchButton addTarget:self action:@selector(switchBo) forControlEvents:(UIControlEventTouchUpInside)];
    _switchButton.frame = CGRectMake(0, 10, 30, 30);
    [self.controlView addSubview:_switchButton];
    
    // 滑动控制器
    self.slider = [[UISlider alloc] initWithFrame:CGRectMake(30, 0, self.controlView.frame.size.width - 120 - 60 , 50)];
    [self.controlView addSubview:_slider];
    [_slider addTarget:self action:@selector(progressControl) forControlEvents:(UIControlEventValueChanged)];
    
    // 时间
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.controlView.frame.size.width - 140 , 10, 100, 30)];
    _timeLabel.textColor = [UIColor whiteColor];
    // _timeLabel.backgroundColor = [UIColor yellowColor];
    [self.controlView addSubview:_timeLabel];
    
    // 初始化时间显示
    _timeLabel.text = @"00:00/00:00";
    
    // 控制横屏
    self.horizontalButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _horizontalButton.frame = CGRectMake(self.controlView.frame.size.width - 30, 10, 30, 30);
    [_horizontalButton setImage:[UIImage imageNamed:@"full"] forState:(UIControlStateNormal)];
    [self.controlView addSubview:_horizontalButton];
    [_horizontalButton addTarget:self action:@selector(fullBoundl) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    // 头部视图
    self.topControlView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.controlView.frame.size.width, 50)];
    
    self.topControlView.backgroundColor = [UIColor grayColor];
    _topControlView.alpha = 0.8;
    [self.playView addSubview:_topControlView];
    
    // 顶部标题
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, self.topControlView.frame.size.width - 70, 40)];
//    _titleLabel.text = self.name;
//    _titleLabel.textColor = [UIColor blackColor];
//     _titleLabel.backgroundColor = [UIColor yellowColor];
    [self.topControlView addSubview:_titleLabel];
    
    // 关闭按钮
    self.closeButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_closeButton setImage:[UIImage imageNamed:@"close"] forState:(UIControlStateNormal)];
    self.closeButton.frame = CGRectMake(self.topControlView.frame.size.width - 50, 5, 40, 40);
    [self.closeButton addTarget:self action:@selector(fullBoundl) forControlEvents:(UIControlEventTouchUpInside)];
    [self.topControlView addSubview:_closeButton];
    
    // 创建tap手势  点击隐藏
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction1:)];
    [_playView addGestureRecognizer:tap];
    

    
    // 进度条监听
    [self progressObserving];
    
}


#pragma mark - 屏幕横屏
- (void)fullBoundl
{
    [_player pause];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - 进图条监听
- (void)progressObserving
{
    __weak MovieViewController *vc = self;
    [_player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        // 获取总时长
        CGFloat duration = CMTimeGetSeconds(vc.playItem.duration);
        // 获取当前时间
        CGFloat current = CMTimeGetSeconds(vc.player.currentTime);
        
        
        // 总时间
        NSString *totalT = [NSString stringWithFormat:@"%02d:%02d", (int)duration / 60, (int)duration % 60];
        // 当前时间
        NSString *currentT = [NSString stringWithFormat:@"%02d:%02d", (int)current / 60, (int)current % 60];
        // 拼接
        NSString *timeStr = [NSString stringWithFormat:@"%@/%@", currentT, totalT];
        vc.timeLabel.text = timeStr;
        // 保存总时长 用于slider手动控制进度
        vc.totalDurantion = duration;
        // 控制slider的当前进度
        vc.slider.value = current / duration ;
        
        vc.titleLabel.text = vc.name;
        
    }];
}

#pragma mark - 关闭播放视图
- (void)closeView
{
    [self.playView removeFromSuperview];
    [_player pause];
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark - 暂停/播放按钮
- (void)switchBo
{
    // BOOL判断
    if (_isPlay) {
        // 正在播放时 暂停
        [_player pause];
        [_switchButton setImage:[UIImage imageNamed:@"bofang"] forState:(UIControlStateNormal)];
    } else {
        [_player play];
        [_switchButton setImage:[UIImage imageNamed:@"zanting"] forState:(UIControlStateNormal)];
    }
    _isPlay = !_isPlay;
}

#pragma mark - 滑动控制视频进度
- (void)progressControl
{
    [_player pause];
    // 当前时间
    CGFloat current = _slider.value * _totalDurantion;
    // 创建CMTime
    CMTime time = CMTimeMake(current, 1);
    // 把time赋值给服务器 跳转到对应的时间点
    [_player seekToTime:time completionHandler:^(BOOL finished) {
        [_player play];
    }];
}

#pragma mark - 隐藏边栏
- (void)tapAction1:(UITapGestureRecognizer *)tap
{
    // 初始播放 还未隐藏 isDismiss = NO
    // 隐藏
    if (!_isDismiss) {
        // 隐藏边栏
        [UIView animateWithDuration:0.5 animations:^{
            _topControlView.alpha = 0;
            _controlView.alpha = 0;
        }];
    } else {
        // 显示边栏
        [UIView animateWithDuration:0.5 animations:^{
            _topControlView.alpha = 0.8;
            _controlView.alpha = 0.8;
        }];
    }
    _isDismiss = !_isDismiss;
}



- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeRight;
}- (void)didReceiveMemoryWarning {
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
