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
@end
