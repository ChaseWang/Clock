//
//  CLClockCell.h
//  Clock
//
//  Created by wangtao on 13-12-29.
//  Copyright (c) 2013年 wangtao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLClockObject.h"

@interface CLClockCell : UITableViewCell
@property (nonatomic, strong) CLClockObject *clockObject;
@property (nonatomic, strong) UILabel *timeLable;
@property (nonatomic, strong) UIImageView *statusLable;

- (void)setObject:(CLClockObject *)object;
@end
