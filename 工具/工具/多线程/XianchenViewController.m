//
//  XianchenViewController.m
//  工具
//
//  Created by 李锐 on 16/3/30.
//  Copyright © 2016年 张中烨. All rights reserved.
//

#import "XianchenViewController.h"

@interface XianchenViewController ()

@end

@implementation XianchenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    
}
//基本代码
- (IBAction)GCD:(UIButton *)sender {
    
    // 调用前，查看下当前线程
    NSLog(@"当前调用线程：%@", [NSThread currentThread]);
    
    // 创建一个串行queue
    dispatch_queue_t queue = dispatch_queue_create("cn.itcast.queue", NULL);
    
    dispatch_async(queue, ^{
        NSLog(@"开启了一个异步任务，当前线程：%@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"开启了一个同步任务，当前线程：%@", [NSThread currentThread]);
    });
   

}
//并发的执行
- (IBAction)GCD1:(id)sender {
    // 获得全局并发queue
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    size_t count = 10;
    dispatch_apply(count, queue, ^(size_t i) {
        printf("%zd ", i);
    });
    // 销毁队列
   
}
- (IBAction)GCD2:(id)sender {
    // 异步下载图片
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = [NSURL URLWithString:@"http://car0.autoimg.cn/upload/spec/9579/u_20120110174805627264.jpg"];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        
        // 回到主线程显示图片
        dispatch_async(dispatch_get_main_queue(), ^{
//            self.imageView.image = image;
        });
    });
}
- (IBAction)GCD3:(id)sender {

}

// 根据url获取UIImage
- (UIImage *)imageWithURLString:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    return [UIImage imageWithData:data];
}

- (void)downloadImages {
    // 异步下载图片
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 下载第一张图片
        NSString *url1 = @"http://car0.autoimg.cn/upload/spec/9579/u_20120110174805627264.jpg";
        UIImage *image1 = [self imageWithURLString:url1];
        
        // 下载第二张图片
        NSString *url2 = @"http://hiphotos.baidu.com/lvpics/pic/item/3a86813d1fa41768bba16746.jpg";
        UIImage *image2 = [self imageWithURLString:url2];
        
        // 回到主线程显示图片
        dispatch_async(dispatch_get_main_queue(), ^{
//            self.imageView1.image = image1;
            
//            self.imageView2.image = image;
            });
                       
    });
                       }



//采用dispatch group异步获取图片

- (void)downloadImages1{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // 异步下载图片
    dispatch_async(queue, ^{
        // 创建一个组
        dispatch_group_t group = dispatch_group_create();
        
        __block UIImage *image1 = nil;
        __block UIImage *image2 = nil;
        
        // 关联一个任务到group
        dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 下载第一张图片
            NSString *url1 = @"http://car0.autoimg.cn/upload/spec/9579/u_20120110174805627264.jpg";
            image1 = [self imageWithURLString:url1];
        });
        
        // 关联一个任务到group
        dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 下载第一张图片
            NSString *url2 = @"http://hiphotos.baidu.com/lvpics/pic/item/3a86813d1fa41768bba16746.jpg";
            image2 = [self imageWithURLString:url2];
        });
        
        // 等待组中的任务执行完毕,回到主线程执行block回调
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//            self.imageView1.image = image1;
//            self.imageView2.image = image2;
            
            // 千万不要在异步线程中自动释放UIImage，因为当异步线程结束，异步线程的自动释放池也会被销毁，那么UIImage也会被销毁
            
            // 在这里释放图片资源
         
        });
        
      
    });
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
