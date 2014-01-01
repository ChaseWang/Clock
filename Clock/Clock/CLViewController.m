//
//  CLViewController.m
//  Clock
//
//  Created by wangtao on 13-10-21.
//  Copyright (c) 2013年 wangtao. All rights reserved.
//

#import "CLViewController.h"

@interface CLViewController ()

@end

@implementation CLViewController

- (void)loadView
{
    [super loadView];

    self.clockTableView = [[CLClockView alloc]initWithFrame:CGRectMake(0, 200, 200, 170)];
    [self.clockTableView setBackgroundColor:[UIColor clearColor]];
    self.clockTableView.delegate = self;
    self.clockTableView.dataSource = self;
    [self.view addSubview:self.clockTableView];

    self.view.backgroundColor = [UIColor colorWithRed:242.0f/255 green:242.0f/255 blue:242.0f/255 alpha:1];
    self.tabBarView = [[CLTabBarView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 40, self.view.frame.size.width, 40)];
    self.tabBarView.delegate = self;
    [self.view addSubview:self.tabBarView];

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
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[UITableViewCell alloc]init];
}

- (void)tabbarButtonClick:(CLTabBarView *)tabbar type:(CLTabBarType)type
{

}

@end
