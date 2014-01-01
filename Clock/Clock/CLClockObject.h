//
//  CLClockObject.h
//  Clock
//
//  Created by wangtao on 13-12-29.
//  Copyright (c) 2013年 wangtao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLClockObject : NSObject<NSCoding>
@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, strong) NSDate *clockDate;
@property (nonatomic, strong) NSDate *fireDate;
@property (nonatomic, assign) NSCalendarUnit repeatInterval;
@property (nonatomic, copy) NSString *alertBody;
@property (nonatomic, copy) NSString *soundName;
@property (nonatomic, strong) UILocalNotification *notification;

- (id)initWithLocalNotification:(UILocalNotification *)notification;
@end
