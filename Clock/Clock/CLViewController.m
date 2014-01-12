//
//  CLViewController.m
//  Clock
//
//  Created by wangtao on 13-10-21.
//  Copyright (c) 2013年 wangtao. All rights reserved.
//

#import "CLViewController.h"
#import "CLNotificationManager.h"

#define kLeftMargin 10
#define kTopMargin 20

@interface CLViewController ()

@end

@implementation CLViewController

- (void)loadView
{
    [super loadView];

    self.timeView = [[CLTimeView alloc]initWithFrame:CGRectMake(kLeftMargin, kTopMargin, 160, 70)];
    [self.view addSubview:self.timeView];

    self.clockTableView = [[CLClockView alloc]initWithFrame:CGRectMake(0, 200, 200, 170)];
    [self.clockTableView setBackgroundColor:[UIColor clearColor]];
    self.clockTableView.delegate = self;
    self.clockTableView.dataSource = self;
    [self.view addSubview:self.clockTableView];

    self.view.backgroundColor = kGlobalBaseColor;
    self.tabBarView = [[CLTabBarView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 40, self.view.frame.size.width, 40)];
    self.tabBarView.delegate = self;
    [self.view addSubview:self.tabBarView];

    UIButton *footerView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.clockTableView.frame.size.width, 40)];
    [footerView setBackgroundColor:[UIColor lightGrayColor]];
    [footerView setTitle:@"添加闹钟" forState:UIControlStateNormal];
    [footerView addTarget:self action:@selector(addClockButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.clockTableView.tableFooterView = footerView;

    [self.navigationController setNavigationBarHidden:YES];

}

- (void)viewWillLayoutSubviews
{
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[CLNotificationManager sharedManager] getAllLocalNotifications].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *clockArray = [[CLNotificationManager sharedManager] getAllLocalNotifications];
    CLClockObject *obj = [clockArray objectAtIndex:indexPath.row];
    static NSString *clockIdentifier = @"clockIdentifier";
    CLClockCell *cell = [tableView dequeueReusableCellWithIdentifier:clockIdentifier];
    if (!cell) {
        cell = [[CLClockCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:clockIdentifier];
    }

    cell.timeLable.text =  [self stringFromDate:obj.clockDate];
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)addClockButtonClick:(id)sender
{
    CLAddViewController *addClockVC = [[CLAddViewController alloc]init];
    addClockVC.delegate = self;
    [self.navigationController presentViewController:addClockVC animated:YES completion:^{

    }];
}

- (void)tabbarButtonClick:(CLTabBarView *)tabbar type:(CLTabBarType)type
{

}

- (NSString *)stringFromDate:(NSDate *)date{

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    NSString *destDateString = [dateFormatter stringFromDate:date];

    return destDateString;
    
}

#pragma mark-addDelegate
- (void)addClockCancel:(CLClockObject *)clock
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{

    }];
}

- (void)addClockConfirm:(CLClockObject *)clock
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        [[CLNotificationManager sharedManager]saveLocalNotification:clock];
        [self.clockTableView reloadData];
    }];
}

@end
