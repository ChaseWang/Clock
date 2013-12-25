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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.tabBarView = [[CLTabBarView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 40, self.view.frame.size.width, 40)];
    self.tabBarView.delegate = self;
    [self.view addSubview:self.tabBarView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabbarButtonClick:(CLTabBarView *)tabbar type:(CLTabBarType)type
{

}

@end
