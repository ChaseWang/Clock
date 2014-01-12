//
//  CLNotificationManager.m
//  Clock
//
//  Created by wangtao on 14-1-1.
//  Copyright (c) 2014年 wangtao. All rights reserved.
//

#import "CLNotificationManager.h"

@interface CLNotificationManager ()
@property (nonatomic, strong) NSMutableArray *localNotifArray;
@end
@implementation CLNotificationManager

+ (CLNotificationManager *)sharedManager
{
    static CLNotificationManager *sharedNotificationManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedNotificationManagerInstance = [[CLNotificationManager alloc]init];
        [sharedNotificationManagerInstance initLocalNotification];
    });
    return sharedNotificationManagerInstance;
}

- (void)initLocalNotification
{
    self.localNotifArray = [NSMutableArray array];
    NSArray *localArray = [[UIApplication sharedApplication] scheduledLocalNotifications];
    for (int i = 0; i < localArray.count; i++) {
        UILocalNotification *notification = [localArray objectAtIndex:i];
        CLClockObject *clock = [[CLClockObject alloc]initWithLocalNotification:notification];
        [self.localNotifArray addObject:clock];
    }
}

- (NSArray *)getAllLocalNotifications
{
    return self.localNotifArray;
}

- (void)deleteLocalNotification:(CLClockObject *)obj
{
    [[UIApplication sharedApplication] cancelLocalNotification:obj.notification];
}

- (void)saveLocalNotification:(CLClockObject *)obj
{
    if (obj.notification == nil) {
        UILocalNotification *notification=[[UILocalNotification alloc] init];
        notification.fireDate = [[NSDate date] dateByAddingTimeInterval:10];
        notification.timeZone = [NSTimeZone defaultTimeZone];
        notification.repeatInterval = obj.repeatInterval;
        notification.alertBody = obj.alertBody;
        notification.soundName = obj.soundName;

        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        obj.notification = notification;
        [self.localNotifArray addObject:obj];
    }

     NSArray *localArray = [[UIApplication sharedApplication] scheduledLocalNotifications];
     NSLog(@"%@", localArray);
}
@end

