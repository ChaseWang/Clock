//
//  CLClockObject.m
//  Clock
//
//  Created by wangtao on 13-12-29.
//  Copyright (c) 2013年 wangtao. All rights reserved.
//

#import "CLClockObject.h"

@implementation CLClockObject

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
