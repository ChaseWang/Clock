//
//  CLPointView.h
//  Clock
//
//  Created by wangtao on 14-1-12.
//  Copyright (c) 2014年 wangtao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CLPointView;

@protocol CLPointViewDelegate <NSObject>
- (void)clockPointValueChanged:(CGFloat)angle;
@end

@interface CLPointView : UIView
@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) CGFloat deltaAngle;
@property (nonatomic, assign) CGFloat changedAngle;
@property (nonatomic, assign) id<CLPointViewDelegate> delegate;
@property (nonatomic) CGAffineTransform startTransform;
@end
