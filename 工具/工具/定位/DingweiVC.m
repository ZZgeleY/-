//
//  DingweiVC.m
//  工具
//
//  Created by 张张烨 on 16/3/30.
//  Copyright © 2016年 张中烨. All rights reserved.
//

#import "DingweiVC.h"
#import <CoreLocation/CoreLocation.h>  // 导入需要的系统库

@interface DingweiVC () <CLLocationManagerDelegate> // 签协议
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, retain) CLLocation *location;  // 位置
@property (nonatomic, retain) NSString *city; /**< 城市属性 */
@property (nonatomic, strong) UIButton *jump;  // 小按钮
@end

@implementation DingweiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor cyanColor];
    
    self.jump = [UIButton buttonWithType:UIButtonTypeCustom];
    _jump.frame = CGRectMake(100, 100, 200, 200);
    _jump.backgroundColor = [UIColor redColor];
    [self.view addSubview:_jump];
    [_jump addTarget:self action:@selector(jumpAction) forControlEvents:UIControlEventTouchUpInside];
    
    // 定位
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"定位服务当前可能尚未打开，请设置打开！");
        return;
    }
    //请求用户授权
    [_locationManager requestWhenInUseAuthorization];
    [self dingwei];
}

#pragma mark - 定位
- (void)dingwei
{
    _locationManager = [[CLLocationManager alloc] init];
    // 设置代理
    _locationManager.delegate = self;
    // 设置定位精确度到米
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    // 设置过滤器为无
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    // 开始定位
    [_locationManager startUpdatingLocation];
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    
    
    /* 处理定位成功，manager参数表示位置管理器实例；locations为一个数组，是位置变化的集合，它按照时间变化的顺序存放。如果想获得设备的当前位置，只需要访问数组的最后一个元素即可。集合中每个对象类型是CLLocation，它包含以下属性：
     
     coordinate — 坐标。一个封装了经度和纬度的结构体。
     
     altitude — 海拔高度。正数表示在海平面之上，而负数表示在海平面之下。
     
     horizontalAccuracy — 位置的精度(半径)。位置精度通过一个圆表示，实际位置可能位于这个圆内的任何地方。这个圆是由coordinate(坐标)和horizontalAccuracy(半径)共同决定的，horizontalAccuracy的值越大，那么定义的圆就越大，因此位置精度就越低。如果horizontalAccuracy的值为负，则表明coordinate的值无效。
     
     verticalAccuracy — 海拔高度的精度。为正值表示海拔高度的误差为对应的米数；为负表示altitude(海拔高度)的值无效。*/
    
    //获取设备当前位置
    
    
    _location = [locations lastObject]; //取出最后一个位置
    
    [self getCity];
}
#pragma mark - 获取城市
- (void)getCity
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:_location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0)
            
        {
            
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            
            //将获得的所有信息显示到label上
            
            //            NSLog(@"%@",placemark.name);
            //            UILabel *label = [self.view viewWithTag:8888];
            //            label.text = placemark.name;
            //            label.numberOfLines = 0;
            //            [label sizeToFit];
            
            //获取城市
            
            NSString *city = placemark.locality;
            
            //            self.navigationItem.title = city;
            [self.jump setTitle:city forState:UIControlStateNormal];
            self.city = [city substringToIndex:[city length] - 1];
            
            //self.city = @"大连";
            
            
            
            
            // NSLog(@"%@", city);
            
            if (!city) {
                
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                
                city = placemark.administrativeArea;
                
            }
            
            //            UILabel *label = [self.view viewWithTag:8888];
            //            label.text = city;
            
        }
        
        else if (error == nil && [placemarks count] == 0)
            
        {
            
            NSLog(@"No results were returned.");
            
        }
        
        else if (error != nil)
            
        {
            
            NSLog(@"An error occurred = %@", error);
            
        }
        
    }];
    
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    
    [_locationManager stopUpdatingLocation];
}


- (void)jumpAction
{
    
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
