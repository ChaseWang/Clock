//
//  NSDate+CLAdditions.m
//  Clock
//
//  Created by wangtao on 14-1-12.
//  Copyright (c) 2014年 wangtao. All rights reserved.
//

#import "NSDate+CLAdditions.h"

@implementation NSDate (CLAdditions)
- (NSString *)dateToString:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSString *dateString = [formatter stringFromDate:self];

    return dateString;
}

+ (NSDate *)dateWithString:(NSString *)dateString format:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSDate *date = [formatter dateFromString:dateString];

    return date;
}

- (NSDateComponents *)dateComponents
{
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;

    NSDateComponents *dateComponent = [[NSCalendar currentCalendar] components:unitFlags fromDate:self];

    return dateComponent;
}

@end
