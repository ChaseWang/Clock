//
//  NSDate+CLAdditions.h
//  Clock
//
//  Created by wangtao on 14-1-12.
//  Copyright (c) 2014年 wangtao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (CLAdditions)
- (NSString *)dateToString:(NSString *)format;

+ (NSDate *)dateWithString:(NSString *)dateString format:(NSString *)format;

- (NSDateComponents *)dateComponents;
@end
