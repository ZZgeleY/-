//
//  DownLoadViewController.m
//  工具
//
//  Created by lirui on 16/3/26.
//  Copyright © 2016年 张中烨. All rights reserved.
//

#import "DownLoadViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "DoneViewController.h"

@interface DownLoadViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, retain) NSArray *files;

@end

@implementation DownLoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [ UIColor whiteColor];
    // 获取沙盒主目录路径
    NSString *homeDir = NSHomeDirectory();
    // 获取Documents目录路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSLog(@"%@\n%@\n%@", homeDir, paths, docDir);
    
    // FileManager 文件管理器
    NSFileManager *fManager = [NSFileManager defaultManager];
    // 添加文件夹
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 文件夹路径(不需要后缀)
    NSString *filePath = [path stringByAppendingPathComponent:@"下载的视频"];
    //取得一个目录下得所有文件名
    self.files = [fManager subpathsAtPath:filePath];
    NSLog(@"%@", self.files);
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _files.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [ tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.textLabel.text =_files[indexPath.row];
    return  cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 添加文件夹
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 文件夹路径(不需要后缀)
    NSString *filePath = [path stringByAppendingPathComponent:@"下载的视频"];
    NSString *strPath = [filePath stringByAppendingPathComponent:_files[indexPath.row]];
    NSURL *url = [[NSURL alloc] initFileURLWithPath:strPath];
    if ([_files[indexPath.row] containsString:@".jpg"] | [_files[indexPath.row] containsString:@".png"] | [_files[indexPath.row] containsString:@".jpeg"]) {
        DoneViewController *done = [[ DoneViewController alloc] init];
        done .str = strPath;
        [self.navigationController pushViewController:done animated:YES];
    } else {
        AVPlayerItem *item =[AVPlayerItem playerItemWithURL:url];
        AVPlayerViewController *viewController =[[AVPlayerViewController alloc]init];
        [self presentViewController:viewController animated:YES completion:^{
            
            viewController.player =[AVPlayer playerWithPlayerItem:item];
            
        }];
    }
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
