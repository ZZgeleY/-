//
//  LvJjingVC.m
//  工具
//
//  Created by 张张烨 on 16/3/28.
//  Copyright © 2016年 张中烨. All rights reserved.
//

#import "LvJjingVC.h"
//屏幕宽
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
//屏幕高
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface LvJjingVC ()

@property (nonatomic, strong) UIImageView *editImageView;
@property (nonatomic, strong) UIPickerView *effectPickerView;
@end

@implementation LvJjingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createSubviews];

}
- (void)createSubviews
{
    self.editImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH / 6 * 5, SCREEN_HEIGHT / 5 * 3)];
    self.editImageView.center = CGPointMake(self.view.center.x, _editImageView.center.y);
    self.editImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.editImageView.userInteractionEnabled = YES;
    [self.view addSubview:_editImageView];
    
    self.effectPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, _editImageView.frame.origin.y + _editImageView.frame.size.height, _editImageView.frame.size.width, SCREEN_HEIGHT / 5 - 10)];
    self.effectPickerView.center = CGPointMake(self.view.center.x, _effectPickerView.center.y);
    self.effectPickerView.delegate = (id)self;
    self.effectPickerView.backgroundColor = [UIColor whiteColor];
    
    self.editImageView.image = self.image;
    [self.view addSubview:_effectPickerView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(doneAction)] ;
    
    //滤镜名称
    NSArray *array=[[NSArray alloc] initWithObjects:@"None", @"CIFalseColor", @"CIPhotoEffectChrome", @"CIPhotoEffectFade", @"CIPhotoEffectInstant", @"CIPhotoEffectMono", @"CIPhotoEffectNoir", @"CIPhotoEffectProcess", @"CIPhotoEffectTonal",nil];
    self.pickerViewData = array;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.pickerViewData.count;
}

-(UIView *)pickerView:(UIPickerView *)pickerView
          titleForRow:(NSInteger)row
         forComponent:(NSInteger)component
{
    
    return [self.pickerViewData objectAtIndex:row];
}

// 选中 pickerview 的某行时会调用该函数。
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSString *filterName = [[self pickerViewData]objectAtIndex:row];
    UIImage *newImage = [LvJjingVC effectImage:[self originalImage] byFilterName:filterName];
    
    [self setImage:newImage];
    [self.editImageView setImage:newImage];
}

- (void)doneAction
{
    //当图片不为空的时候显示并保存图片
    if (self.image != nil) {
        //图片显示在界面
        
        
        // 将图片保存到沙盒路径下
        // 把图片转化成NSData类型的数据来保存文件
        NSData *data;
        // 如果图片是png图像
        if (UIImagePNGRepresentation(_image)) {
            // 返回png图像
            data = UIImagePNGRepresentation(_image);
        }else{
            // 返回JPEG图像
            data = UIImageJPEGRepresentation(_image, 1.0);
        }
        
        //NSData 转64位NSString
        NSString *result  = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        [[NSUserDefaults standardUserDefaults]setObject:result forKey:@"userImg"];
        //    self.changeImgBlock(result);
        //    [self dismissViewControllerAnimated:YES completion:^{
        //    }];
        [self.navigationController popViewControllerAnimated:YES];
    }
    UIImageWriteToSavedPhotosAlbum([self image], self, nil, nil); // TODO 异常处理
}

// 滤镜
+ (UIImage *) effectImage: (UIImage *)uIImage byFilterName:(NSString *)filterName;
{
    if ([filterName isEqualToString:@"None"]) {
        return uIImage;
    }
    
    UIImage *tempImage = [LvJjingVC scaleAndRotateImage:uIImage];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CIImage *ciImage = [[CIImage alloc] initWithImage:tempImage]; // 解决滤镜后图片方向不对的问题
    
    CIFilter *filter = [CIFilter filterWithName:filterName];
    [filter setValue:ciImage forKey:kCIInputImageKey];
    
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    
    CGRect extent = [result extent];
    
    CGImageRef cgImage = [context createCGImage:result fromRect:extent];
    UIImage *filteredImage = [[UIImage alloc] initWithCGImage:cgImage];
    CGImageRelease(cgImage);
    
    return filteredImage;
}

+ (UIImage *)scaleAndRotateImage:(UIImage *)image {
    int kMaxResolution = 640; // Or whatever
    
    CGImageRef imgRef = image.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution || height > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = roundf(bounds.size.width / ratio);
        }
        else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = roundf(bounds.size.height * ratio);
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = image.imageOrientation;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
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
