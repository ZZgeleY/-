//
//  PlayerManager.h
//  AVAudioplayer
//
//  Created by 张中烨 on 16/3/7.
//  Copyright © 2016年 张中烨. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
/*
 
 #第二个封装 音频播放器
 #外部接口比较多 可直接调用 直接创建播放对象即可 ,需要从外部传给一个音频网址的数组给musicArray(一般利用这个方法NSMutableArray arrayWithArray ),一般在数据解析是直接把所有的音频网址的数组给musicArray,其他播放暂停等可直接写在button的点击方法里 利用在.h里定义好的属性可直接写出监听进度条
 
 
 
 
 */


#pragma mark -播放枚举类型
typedef NS_ENUM (NSInteger,PlayType)
{
    PlayTypeSingle,  //单曲
    PlayTypeRandom,  //随机
    PlayTypeList    //列表
    
};
#pragma mark -播放状态枚举类型
typedef NS_ENUM(NSInteger,PlayState){
    
    
    PlayStatePlay,    //播放
    PlayerStatePause  //暂停
};
@interface PlayerManager : NSObject
@property(nonatomic, assign)PlayType playerType; //播放类型属性
@property(nonatomic ,assign)PlayState playerState; //播放状态属性
@property(nonatomic, retain)AVPlayer *avPlayer;  //创建播放器
//创建单例对象
+(instancetype)defaultManager;
//用来接收和管理播放器的播放资源的数组
@property(nonatomic, strong)NSMutableArray  *musicArray;
//播放位置的属性 用来控制播放的位置
@property(nonatomic, assign) NSUInteger playindex;
//当前时间
@property(nonatomic,assign,readonly)float currentTime;
//总时长
@property(nonatomic,assign,readonly)float totalTime;
//播放
-(void)play;
//停止(回复播放时从当前位置继续)
-(void)pause;
//停止后从头开始
-(void)stop;
//将播放位置指向播放的起始位置 指定时间的播放的方法
-(void)seekToNewTime:(float)time;
//通过播放资源位置改变播放资源
-(void)changeMusicWithIndex:(NSInteger)index;
//上一首
-(void)lastMusic;
//下一首
-(void)nextMusic;
//播放完成
-(void)playerDidFinish;
@end
