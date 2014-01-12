//
//  CLClockObject.m
//  Clock
//
//  Created by wangtao on 13-12-29.
//  Copyright (c) 2013年 wangtao. All rights reserved.
//

#import "CLClockObject.h"

@implementation CLClockObject

- (id)initWithLocalNotification:(UILocalNotification *)notification
{
    if (self = [super init]) {
        self.notification = notification;
        self.fireDate = notification.fireDate;
        self.soundName = notification.soundName;
        self.repeatInterval = notification.repeatInterval;
        self.alertBody = notification.alertBody;
        self.isOpen = [self.fireDate isEqualToDate:[NSDate distantPast]];
    }
    return self;
}

- (id)init
{
    if (self = [super init]) {
        self.soundName = UILocalNotificationDefaultSoundName;
        self.alertBody = @"闹钟时间";
        self.repeatInterval = NSWeekCalendarUnit;
        self.isOpen = YES;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.isOpen = [[aDecoder decodeObjectForKey:@"isOpen"] boolValue];
        self.clockDate = [[aDecoder decodeObjectForKey:@"clockDate"] date];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:[NSNumber numberWithBool:self.isOpen] forKey:@"isOpen"];
    [aCoder encodeObject:self.clockDate forKey:@"clockDate"];
}
@end
