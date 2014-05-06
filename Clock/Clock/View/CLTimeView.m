//
//  CLTimeView.m
//  Clock
//
//  Created by wangtao on 14-1-5.
//  Copyright (c) 2014年 wangtao. All rights reserved.
//

#import "CLTimeView.h"

@implementation CLTimeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self defaultSetup];
    }
    return self;
}

- (void)defaultSetup
{
    self.backgroundColor = [UIColor clearColor];
    timeLabel = [[UILabel alloc]init];
    [timeLabel setFont:[UIFont systemFontOfSize:50.0f]];
    [timeLabel setFrame:self.frame];
    [timeLabel setBackgroundColor:[UIColor clearColor]];
    [self addSubview:timeLabel];
    [self updateClock:nil];
    [self start];
}

- (void)start
{
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateClock:) userInfo:nil repeats:YES];
}

- (void)stop
{
	[timer invalidate];
	timer = nil;
}

//timer callback
- (void) updateClock:(NSTimer *)theTimer{

	NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:[NSDate date]];
	//NSInteger seconds = [dateComponents second];
	NSInteger minutes = [dateComponents minute];
	NSInteger hours = [dateComponents hour];
	//NSLog(@"raw: hours:%d min:%d secs:%d", hours, minutes, seconds);
	//if (hours > 12) hours -=12; //PM
    //update time
    timeLabel.text = [NSString stringWithFormat:@"%d:%d",hours,minutes];
}

- (void)removeFromSuperview
{
    [self stop];
    [super removeFromSuperview];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self defaultSetup];
}
@end
