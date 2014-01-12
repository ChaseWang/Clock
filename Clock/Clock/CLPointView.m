//
//  CLPointView.m
//  Clock
//
//  Created by wangtao on 14-1-12.
//  Copyright (c) 2014年 wangtao. All rights reserved.
//

#import "CLPointView.h"

@implementation CLPointView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = YES;
        UIPanGestureRecognizer* panResizeGesture = [[UIPanGestureRecognizer alloc]
                                                    initWithTarget:self
                                                    action:@selector(resizeTranslate:)];
        [self addGestureRecognizer:panResizeGesture];

        self.deltaAngle = atan2(self.frame.origin.y + self.frame.size.height - self.center.y,
                           self.frame.origin.x+self.frame.size.width - self.center.x);
        self.deltaAngle = 1.5;
    }
    return self;
}

-(void)resizeTranslate:(UIPanGestureRecognizer *)recognizer
{

    if ([recognizer state] == UIGestureRecognizerStateBegan) {

    }
    else if ([recognizer state] == UIGestureRecognizerStateChanged)
    {
        /* Rotation */
        float ang = atan2([recognizer locationInView:self.superview].y - self.center.y,
                          [recognizer locationInView:self.superview].x - self.center.x);
        self.changedAngle = self.deltaAngle - ang;
        self.transform = CGAffineTransformMakeRotation(-self.changedAngle );

        [self setNeedsDisplay];
    }
    else if ([recognizer state] == UIGestureRecognizerStateEnded)
    {
        [self setNeedsDisplay];
        if ([self.delegate respondsToSelector:@selector(clockPointValueChanged:)])
        {
            [self.delegate clockPointValueChanged:self.changedAngle];
        }
    }
}
@end
