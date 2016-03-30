//
//  AFN.h
//  工具类,张中烨
//
//  Created by 张张烨 on 16/3/25.
//  Copyright © 2016年 张中烨. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, LHResponseStyle) {
    LHJSON,
    LHXML,
    LHData,
};

@interface AFN : NSObject

+ (void)getUrl:(NSString *)url
          body:(id)body
      response:(LHResponseStyle)style
requestHeadFile:(NSDictionary *)headFile
       success:(void (^)(NSURLSessionDataTask *task, id resposeObject))success
       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

+ (void)postUrl:(NSString *)url
           body:(id)body
       response:(LHResponseStyle)style
requestHeadFile:(NSDictionary *)headFile
        success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
        failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
