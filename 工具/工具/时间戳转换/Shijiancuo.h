//
//  Shijiancuo.h
//  工具类,张中烨
//
//  Created by 张张烨 on 16/3/25.
//  Copyright © 2016年 张中烨. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Shijiancuo : NSObject
/**<  转换出来星期几 */
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate;
/**<  转换出来日期 */
+ (NSString *)compareCurrentTime: (NSNumber *)date;
@end
