//
//  DownViewController.m
//  工具
//
//  Created by lirui on 16/3/26.
//  Copyright © 2016年 张中烨. All rights reserved.
//

#import "DownViewController.h"
#import "DownLoad.h"
@interface DownViewController ()<DownloadDelegate>
@property (weak, nonatomic) IBOutlet UILabel *total;
@property (weak, nonatomic) IBOutlet UILabel *now;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property(nonatomic ,retain)DownLoad *download;
@end

@implementation DownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.download = [[DownLoad alloc] initWithURL:@"http://img5.duitang.com/uploads/blog/201408/01/20140801151328_RrurB.jpeg"];
    _download.delegate = self;
    self.total.text = @"0/0";
    self.now.text = @"0";
    
}
- (IBAction)look:(UIButton *)sender {
    
    
}
- (IBAction)start:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        [_download start];
    }
    else{
        [_download suspend];
    }
}
-(void)getWithspeed:(float)speed done:(float)done total:(float)total
{
    self.total.text = [ NSString stringWithFormat:@"%.2fMB/%.2fMB",done,total];
    self.now.text = [ NSString stringWithFormat:@"%.2fKB/s",speed];
    float progress =  done *0.1f / total;
    [self.progress setProgress:progress];
    
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
