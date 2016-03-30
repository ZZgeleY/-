//
//  AFN.m
//  工具类,张中烨
//
//  Created by 张张烨 on 16/3/25.
//  Copyright © 2016年 张中烨. All rights reserved.
//

#import "AFN.h"
#import "AFNetworking.h"

@implementation AFN

#pragma mark - GET请求
+ (void)getUrl:(NSString *)url body:(id)body response:(LHResponseStyle)style requestHeadFile:(NSDictionary *)headFile success:(void (^)(NSURLSessionDataTask *task, id resposeObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    
    // 1. 获取单例的网络管理对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 2. 根据style类型，去选择返回值的类型
    switch (style) {
        case LHJSON:
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        case LHXML:
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
        case LHData:
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        default:
            break;
    }
    
    // 3. 设置响应数据的基本了类型
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain", @"application/javascript", nil]];
    
    // 4. 给网络请求加请求头
    if (headFile) {
        for (NSString *key in headFile.allKeys) {
            [manager.requestSerializer setValue:headFile[key] forHTTPHeaderField:key];
        }
    }
    
    // 5. UTF8转码
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    
    
    // 6. 发送GET请求
    [manager GET:url parameters:body progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        /****************************************************/
        //如果请求成功 , 回调请求到的数据 , 同时 在这里 做本地缓存
        NSString *path = [NSString stringWithFormat:@"%ld.plist", [url hash]];
        // 存储的沙盒路径
        NSString *path_doc = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        // 归档
        [NSKeyedArchiver archiveRootObject:responseObject toFile:[path_doc stringByAppendingPathComponent:path]];
        
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            
            /*****************************************************/
            // 在这里读取本地缓存
            NSString *path = [NSString stringWithFormat:@"%ld.plist", [url hash]];
            NSString *path_doc = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
            
            id result = [NSKeyedUnarchiver unarchiveObjectWithFile:[path_doc stringByAppendingPathComponent:path]];
            
            if (result) {
                success(task, result);
            } else {
                failure(task,error);
            }
            
        }
    }];
}

#pragma mark - POST请求

+ (void)postUrl:(NSString *)url body:(id)body response:(LHResponseStyle)style requestHeadFile:(NSDictionary *)headFile success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    // 1. 获取单例的网络管理对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 2. 根据style类型，去选择返回值的类型
    switch (style) {
        case LHJSON:
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        case LHXML:
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
        case LHData:
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        default:
            break;
    }
    
    // 3. 设置响应数据的基本了类型
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain", @"application/javascript", nil]];
    
    // 4. 给网络请求加请求头
    if (headFile) {
        for (NSString *key in headFile.allKeys) {
            [manager.requestSerializer setValue:headFile[key] forHTTPHeaderField:key];
        }
    }
    
    // 5. UTF8转码
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    // 6. 发送POST请求
    
    [manager POST:url parameters:body progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        /* ************************************************** */
        //如果请求成功 , 回调请求到的数据 , 同时 在这里 做本地缓存
        NSString *path = [NSString stringWithFormat:@"%ld.plist", [url hash]];
        // 存储的沙盒路径
        NSString *path_doc = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        // 归档
        [NSKeyedArchiver archiveRootObject:responseObject toFile:[path_doc stringByAppendingPathComponent:path]];
        
        
        
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (error) {
            
            /* *************************************************** */
            // 在这里读取本地缓存
            NSString *path = [NSString stringWithFormat:@"%ld.plist", [url hash]];
            NSString *path_doc = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
            
            id result = [NSKeyedUnarchiver unarchiveObjectWithFile:[path_doc stringByAppendingPathComponent:path]];
            
            if (result) {
                success(task, result);
            } else {
                failure(task,error);
            }
            
        }
    }];
}


@end
