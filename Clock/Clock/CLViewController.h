//
//  CLViewController.h
//  Clock
//
//  Created by wangtao on 13-10-21.
//  Copyright (c) 2013年 wangtao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLAddViewController.h"
#import "CLClockView.h"
#import "CLTabBarView.h"
#import "CLClockCell.h"
#import "CLAddClockCell.h"
#import "CLTimeView.h"

@interface CLViewController : UIViewController<CLTabBarDelegate,CLAddViewVControllerDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) CLClockView *clockTableView;
@property (nonatomic, strong) CLTabBarView *tabBarView;
@property (strong, nonatomic) IBOutlet UIImageView *weatherImageView;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (strong, nonatomic) CLTimeView *timeView;
@end
