//
//  CLNotificationManager.h
//  Clock
//
//  Created by wangtao on 14-1-1.
//  Copyright (c) 2014年 wangtao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLClockObject.h"

@interface CLNotificationManager : NSObject
- (NSArray *)getAllLocalNotifications;
- (void)deleteLocalNotification:(CLClockObject *)obj;
- (void)saveLocalNotification:(CLClockObject *)obj;
- (CLNotificationManager *)sharedManager;
@end
