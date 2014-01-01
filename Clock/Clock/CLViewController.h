//
//  CLViewController.h
//  Clock
//
//  Created by wangtao on 13-10-21.
//  Copyright (c) 2013年 wangtao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLClockView.h"
#import "CLTabBarView.h"
#import "CLClockCell.h"

@interface CLViewController : UIViewController<CLTabBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) CLClockView *clockTableView;
@property (nonatomic, strong) CLTabBarView *tabBarView;
@end
