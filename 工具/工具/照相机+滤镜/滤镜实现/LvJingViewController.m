//
//  LvJingViewController.m
//  工具
//
//  Created by 张张烨 on 16/3/28.
//  Copyright © 2016年 张中烨. All rights reserved.
//
#import "LvJjingVC.h"
#import <MobileCoreServices/MobileCoreServices.h>

#import "LvJingViewController.h"
//屏幕宽
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
//屏幕高
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
@interface LvJingViewController ()<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong) UIImageView *userImageView;
@end

@implementation LvJingViewController
/**<  在视图出现的时候传入图片 */
- (void)viewWillAppear:(BOOL)animated
{
    NSString *userImg = [[NSUserDefaults standardUserDefaults]objectForKey:@"userImg"];
    if (userImg) {
        
        //将字符串转化Data
        NSData *userimg = [[NSData alloc] initWithBase64EncodedString:userImg options:NSDataBase64DecodingIgnoreUnknownCharacters];
        [self.userImageView setImage:[UIImage imageWithData:userimg]];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH / 5, SCREEN_WIDTH / 3)];
    /**<  设置在中心 */
    _userImageView.center = CGPointMake(self.view.center.x, self.view.center.y);
    _userImageView.contentMode = UIViewContentModeScaleAspectFill;
    /**<  切圆角 */
    _userImageView.layer.cornerRadius = _userImageView.frame.size.width / 2;
    _userImageView.clipsToBounds = YES;
    /**<  开启用户交互 */
    _userImageView.userInteractionEnabled = YES;
    _userImageView.image = [UIImage imageNamed:@"touxiang.jpg"];
    [self.view addSubview:_userImageView];
    
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeImgAction)];
    [self.userImageView addGestureRecognizer:tap];
    
    [self.view addSubview:_userImageView];
    
}

//更换头像
- (void)changeImgAction
{
    // 下方弹出选择框
    UIActionSheet *actinSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册选择", nil];
    [actinSheet showInView:self.view];
}
// UIActionSheet点击协议方法
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        return;
    }else if (buttonIndex == actionSheet.destructiveButtonIndex) {
        [self camera];
    }else {
        [self library];
    }
    
}

- (void)library
{
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeSavedPhotosAlbum])
    {
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType =
        UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.mediaTypes = [NSArray arrayWithObjects:
                                  (NSString *) kUTTypeImage,
                                  nil];
        imagePicker.allowsEditing = NO;
        [self presentViewController:imagePicker animated:YES completion:^(void){}];
    }
}

// 调用照相机的方法
- (void)camera
{
    //判断是否可以打开相机，模拟器此功能无法使用
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController * picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.allowsEditing = YES;  //是否可编辑
        //摄像头
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:^{
            
        }];
        
    }else{
        //如果没有提示用户
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"你没有摄像头" delegate:nil cancelButtonTitle:@"Drat!" otherButtonTitles:nil];
        [alert show];
    }
}


//图片选中照片后
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    [picker dismissViewControllerAnimated:YES completion:^(void){}];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = [info
                          objectForKey:UIImagePickerControllerOriginalImage];
        
        [self presentEditViewController:image];
    }
}

- (void)presentEditViewController:(UIImage*) uiimage {
    UIImage *newImage = [LvJjingVC effectImage:uiimage byFilterName:@"None"];
    
    LvJjingVC *viewController = [[LvJjingVC alloc] init];
    
    [viewController setOriginalImage:uiimage];
    [viewController setImage:newImage];
    
    //    [self presentViewController:navi animated:YES completion:^{
    //    }];
    [self.navigationController pushViewController:viewController animated:YES];
    NSLog(@"push");
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
