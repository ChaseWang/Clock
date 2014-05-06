//
//  CLViewController.m
//  Clock
//
//  Created by wangtao on 13-10-21.
//  Copyright (c) 2013年 wangtao. All rights reserved.
//

#import "CLViewController.h"
#import "CLNotificationManager.h"
#import "CLAboutViewController.h"
#import "CLSettingViewController.h"
#import "CLFeedBackViewController.h"

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

    cell.timeLable.text =  [obj.fireDate dateToString:@"HH:mm"];
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
    switch (type) {
        case CLTabBarTypeRecommend:
            [self sendTextMessageToWeixin:1];
            break;
        case CLTabBarTypeFeedBack:
            [self showFeedBackViewController];
            break;
        case CLTabBarTypeSetting:
            [self showSettingViewController];
            break;
        case CLTabBarTypeAbout:
            [self showAboutViewController];
            break;
        default:
            break;
    }
}
//微信分享代码
- (void)sendTextMessageToWeixin:(int)scene{
    NSString *url = @"http://www.baidu.com";
    if ([WXApi isWXAppSupportApi]) {
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = @"messageTitle";
        message.description = @"description";

        WXWebpageObject *ext = [WXWebpageObject object];
        ext.webpageUrl = url;
        message.mediaObject = ext;
        [message setThumbImage:[UIImage imageForKey:@"lbs_avatar_emotions"]];

        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.message = message;
        req.scene = scene;
        req.bText = NO;
        [WXApi sendReq:req];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"维信版本太低，暂不支持分享" message:nil delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alertView show];

    }
}

- (void)showFeedBackViewController
{
    CLFeedBackViewController *feedBackVC = [[CLFeedBackViewController alloc]init];
    [self.navigationController presentViewController:feedBackVC animated:YES completion:^{
    }];
}

- (void)showSettingViewController
{
    CLSettingViewController *settingVC = [[CLSettingViewController alloc]init];
    [self.navigationController presentViewController:settingVC animated:YES completion:^{
    }];
}

- (void)showAboutViewController
{
    CLAboutViewController *aboutVC = [[CLAboutViewController alloc]init];
    [self.navigationController presentViewController:aboutVC animated:YES completion:^{
    }];
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
