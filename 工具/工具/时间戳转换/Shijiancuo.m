//
//  Shijiancuo.m
//  工具类,张中烨
//
//  Created by 张张烨 on 16/3/25.
//  Copyright © 2016年 张中烨. All rights reserved.
//

#import "Shijiancuo.h"

@implementation Shijiancuo
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周天", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

+ (NSString *)compareCurrentTime:(NSNumber *)date
{
    //  返回以1970/01/01 GMT为基准, 然后过了secs秒的时间
    NSDate *compareDate = [NSDate dateWithTimeIntervalSinceNow:[date doubleValue]];
    //  以当然时间 ( Now )为基准时间, 返回实例保存的时间与当然时间 ( Now )的时间间隔
    NSTimeInterval timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
        
    }else if ((timeInterval / 60 ) < 60){
        result = [NSString stringWithFormat:@"%ld分钟前", temp];
        
    }else if ((temp = temp / 60) < 24){
        result = [NSString stringWithFormat:@"%ld小时前", temp];
        
    }else if ((temp = temp / 24) < 30){
        result = [NSString stringWithFormat:@"%ld天前", temp];
    }else if ((temp = temp / 30) < 12){
        result = [NSString stringWithFormat:@"%ld月前", temp];
    }else {
        temp = temp / 12;
        result = [NSString stringWithFormat:@"%ld年前", temp];
    }
    return result;
}
@end
