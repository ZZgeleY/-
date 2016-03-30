//
//  DownLoad.h
//  封装下载
//
//  Created by dllo on 16/3/7.
//  Copyright © 2016年 巨兔. All rights reserved.
//

#import <Foundation/Foundation.h>

//下载完成的block
typedef void(^Complted)(NSString *savePath, NSString *url);

//下载中的block
typedef void(^Downloading)(long bytesWritten, NSInteger progess);

//定义一个下载完成后的协议,用来对下载完成后的对象进行删除
@protocol DownloadDelegate <NSObject>

//- (void)didFinlishDownloadWithURL:(NSString *)url;

- (void)getWithspeed:(float)speed done:(float)done total:(float)total;

@end

@interface DownLoad : NSObject

@property (nonatomic, assign) id<DownloadDelegate> delegate;

- (instancetype)initWithURL:(NSString *)str;

- (void)start;

- (void)suspend;

//- (void)DownloadWithUrl:(NSString *)str;

@end
