//
//  CLTimeView.h
//  Clock
//
//  Created by wangtao on 14-1-5.
//  Copyright (c) 2014年 wangtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLTimeView : UIView
{
    UILabel *timeLabel;
    NSTimer *timer;
}

- (void)start;
- (void)stop;
@end
