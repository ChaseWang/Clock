//
//  CLAddViewController.h
//  Clock
//
//  Created by wangtao on 14-1-5.
//  Copyright (c) 2014年 wangtao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLClockObject.h"
@class CLAddViewController;
@protocol CLAddViewVControllerDelegate <NSObject>
- (void)addClockCancel:(CLClockObject *)clock;
- (void)addClockConfirm:(CLClockObject *)clock;
@end

@interface CLAddViewController : UIViewController
@property (nonatomic, strong) CLClockObject *clock;
@property (nonatomic, strong) id<CLAddViewVControllerDelegate> delegate;
@end
