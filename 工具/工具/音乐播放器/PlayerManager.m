//
//  PlayerManager.m
//  AVAudioplayer
//
//  Created by 张中烨 on 16/3/7.
//  Copyright © 2016年 张中烨. All rights reserved.
//

#import "PlayerManager.h"

@implementation PlayerManager
#pragma mark -实现单例方法
+(instancetype)defaultManager
{
    static PlayerManager *playerManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        playerManager = [[PlayerManager alloc] init];
    });
    return playerManager;
}
#pragma mark -初始化
-(instancetype) init
{
    if (self = [super init]) {
        /**默认播放为列表播放*/
        _playerType = PlayTypeList;
        _playerState = PlayerStatePause;
    }
    return  self;
}
#pragma mark -重写musicArray的set方法
@synthesize musicArray = _musicArray;
- (void)setMusicArray:(NSMutableArray *)musicArray
{
    /**将播放列表清空 重新给列表赋值*/
       [_musicArray removeAllObjects];
    _musicArray= [ musicArray mutableCopy];
    /**创建播放单元*/
    AVPlayerItem *avPlayerItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:musicArray[_playindex]]];
    /**根据播放单元创建播放器对象*/
    /**首先判断播放器对象是否存在 , 如果不存在创建,存在直接切换播放资源*/
    if (!_avPlayer) {
        _avPlayer = [[ AVPlayer alloc] initWithPlayerItem:avPlayerItem];
        
    }else
    {
        [_avPlayer replaceCurrentItemWithPlayerItem:avPlayerItem];
    }
    
}
-(NSMutableArray *)musicArray
{
     return _musicArray;
}
#pragma mark -播放方法
-(void)play
{
    [_avPlayer play];
    _playerState = PlayStatePlay;
  
}
#pragma mark -暂停方法
-(void)pause
{
    
    [_avPlayer pause];
    _playerState = PlayerStatePause;
}
#pragma mark -停止播放方法
-(void)stop
{
    [self seekToNewTime:0];
    [self pause];
    
}
#pragma mark -指定时间播放的方法
-(void)seekToNewTime:(float)time
{
    //value表示的是播放的位置
    //timescale表示的是每秒的帧数
    CMTime newTime = _avPlayer.currentTime;
    newTime.value = newTime.timescale *time;
    [_avPlayer seekToTime:newTime];
}
#pragma mark -重写currentTime的get方法
-(float)currentTime
{
    if (_avPlayer.currentItem.timebase == 0) {
        return 0;
    }
    
    return _avPlayer.currentTime.value/_avPlayer.currentTime.timescale;
}
#pragma mark -重写totalTime的get方法
- (float)totalTime
{
    if (_avPlayer.currentItem.duration.timescale== 0) {
        return 0;
        
    }
    return _avPlayer.currentItem.duration.value/_avPlayer.currentItem.duration.timescale;
    
}
#pragma mark -改变播放资源的方法
-(void)changeMusicWithIndex:(NSInteger)index
{
    _playindex = index;
    AVPlayerItem *avPlayerItem =[[ AVPlayerItem alloc] initWithURL:[NSURL URLWithString:_musicArray[index]]];
    [_avPlayer replaceCurrentItemWithPlayerItem:avPlayerItem];
    [self play];
}
#pragma mark -上一首
-(void)lastMusic
{
    if (_playerType == PlayTypeRandom) {
        _playindex = arc4random() %_musicArray.count;
        
    }else
    {
        if (_playindex == 0) {
            _playindex = _musicArray.count -1;
        }
        else{
            _playindex--;
        }
    }
    [self changeMusicWithIndex:_playindex];
}
#pragma mark -下一首
-(void)nextMusic
{
    if (_playerType == PlayTypeRandom){
        _playindex = arc4random()%_musicArray.count;
    }else{
       
        if (_playindex == _musicArray.count - 1) {
            _playindex = 0;
        }else{
            _playindex ++;

        }
        
    }
    [self changeMusicWithIndex:_playindex];
//    [self playerDidFinish];
   
    
}
#pragma mark -播放结束
-(void)playerDidFinish
{
    
    if (_playerType == PlayTypeSingle) {
        [self stop];
    }else
    {
        [self nextMusic];
    }
}
@end
