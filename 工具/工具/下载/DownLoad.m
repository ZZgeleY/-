//
//  DownLoad.m
//  封装下载
//
//  Created by dllo on 16/3/7.
//  Copyright © 2016年 巨兔. All rights reserved.
//

#import "DownLoad.h"

@interface DownLoad ()<NSURLSessionDownloadDelegate, NSURLSessionDelegate>

@property (nonatomic, retain) NSURLSessionDownloadTask *task;
@property (nonatomic, copy) Complted complted;
@property (nonatomic, copy) Downloading downloading;
@property (nonatomic, assign) float speed;
@property (nonatomic, assign) float done;
@property (nonatomic, assign) float total;

@end

@implementation DownLoad

- (instancetype)initWithURL:(NSString *)str
{
    self = [super init];
    if (self) {
        NSURL *url = [NSURL URLWithString:str];
        /* 创建session对象 */
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        /* session中添加一个下载任务 */
        self.task = [session downloadTaskWithURL:url];
    }
    return self;
}

//开始下载
- (void)DownloadWithUrl:(NSString *)str
{
    NSURL *url = [NSURL URLWithString:str];
    /* 创建session对象 */
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    /* session中添加一个下载任务 */
    self.task = [session downloadTaskWithURL:url];
    /* 任务执行 */
    [self.task resume];
}

//开始
- (void)start
{
    [self.task resume];
    NSLog(@"已开始");
}

//暂停
- (void)suspend
{
    [self.task suspend];
    NSLog(@"已暂停");
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    NSLog(@"当前下载速度:%lld KB/s", bytesWritten / 1024);
    NSLog(@"已经下载:%lld KB", totalBytesWritten / 1024);
    NSLog(@"共:%lld KB", totalBytesExpectedToWrite / 1024);
    
    [self.delegate getWithspeed:bytesWritten / 1024 done:totalBytesWritten / 1024 / 1024 total:totalBytesExpectedToWrite / 1024 / 1024];
    
//    self.speed = bytesWritten / 1024 * .2f;
//    self.done = totalBytesWritten / 1024 * .2f;
//    self.total = totalBytesExpectedToWrite / 1024 * .2f;
    
//    /* 进度条设置 */
//    float progress = totalBytesWritten * 1.0f / totalBytesExpectedToWrite;
}

/* 当下载任务完成时调用此方法 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    /* 输出下载的路径 */
    NSLog(@"%@", location);
    
    // FileManager 文件管理器
    NSFileManager *fManager = [NSFileManager defaultManager];
    // 添加文件夹
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 文件夹路径(不需要后缀)
    NSString *filePath = [path stringByAppendingPathComponent:@"下载的视频"];
    // 创建文件夹
    [fManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    
    /* 根据服务器传来的数据,给下载的文件命名, lastPathComponent最后一个路径 */
    NSString *fileName = [location lastPathComponent];
    NSLog(@"fileName:%@", fileName);
    
    /* 从response属性中获取 */
    NSString *fileName2 = downloadTask.response.suggestedFilename;
    NSLog(@"fileName2:%@", fileName2);
    
    /* 将下载之后的数据拷贝到沙盒相关文件夹 */
    NSString *filePath2 = [filePath stringByAppendingPathComponent:fileName2];
    
    //[str writeToFile:[filePath stringByAppendingPathComponent:@"lol.txt"] atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    /* 通过文件管理类复制文件 */
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager copyItemAtURL:location toURL:[NSURL fileURLWithPath:filePath2] error:nil];
    
    NSLog(@"%@", NSHomeDirectory());
}

@end
