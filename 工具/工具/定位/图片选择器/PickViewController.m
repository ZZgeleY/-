//
//  PickViewController.m
//  工具
//
//  Created by 李锐 on 16/3/30.
//  Copyright © 2016年 张中烨. All rights reserved.
//

#import "PickViewController.h"
#import "ZYQAssetPickerController.h"
@interface PickViewController ()<UIScrollViewDelegate,UINavigationControllerDelegate,ZYQAssetPickerControllerDelegate>
@property(nonatomic,retain)UIScrollView *sView;
@property(nonatomic,retain)UIPageControl *pageControl;
@end

@implementation PickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [ UIColor whiteColor];
    self.sView=[[UIScrollView alloc] initWithFrame:CGRectMake(20, 20, self.view.frame.size.width-40, self.view.frame.size.height-200)];
    self.sView.pagingEnabled=YES;
    self.sView.backgroundColor=[UIColor lightGrayColor];
self.sView.delegate=self;
    [self.view addSubview:self.sView];
    
    
    _pageControl=[[UIPageControl alloc] initWithFrame:CGRectMake(_sView.frame.origin.x, _sView.frame.origin.y+_sView.frame.size.height-20, self.sView.frame.size.width, 20)];
    [self.view addSubview:_pageControl];
}
- (IBAction)btn:(id)sender {
  
    ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc] init];
    picker.maximumNumberOfSelection = 10;
    picker.assetsFilter = [ALAssetsFilter allPhotos];
    picker.showEmptyGroups=NO;
    picker.delegate=self;
    picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        if ([[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo]) {
            NSTimeInterval duration = [[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyDuration] doubleValue];
            return duration >= 5;
        } else {
           return YES;
        }
    }];
    
  [self presentViewController:picker animated:YES completion:^{
      
  }];
}
#pragma mark - ZYQAssetPickerController Delegate
-(void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets{
  
    [self.sView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    self.sView.contentSize = CGSizeMake(assets.count *_sView.frame.size.width, _sView.frame.size.height );
    dispatch_async(dispatch_get_main_queue(), ^{
       
        _pageControl.numberOfPages = assets.count;
    });
    
    for (int i = 0; i < assets.count; i++) {
        ALAsset *asset =assets[i];
        UIImageView *imgVew= [[ UIImageView alloc ]initWithFrame:CGRectMake(i*_sView.frame.size.width, 0, self.sView.frame.size.width,self.sView.frame.size.height)];
        
        imgVew.contentMode = UIViewContentModeScaleAspectFill;
        imgVew.clipsToBounds  = YES;
        UIImage *temp = [ UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        dispatch_async(dispatch_get_main_queue(), ^{
            [imgVew setImage:temp];
            [_sView addSubview:imgVew];
        });
    }
});

}


#pragma mark - UIScrollView Delegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _pageControl.currentPage=floor(scrollView.contentOffset.x/scrollView.frame.size.width);;
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
