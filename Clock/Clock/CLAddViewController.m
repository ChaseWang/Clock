//
//  CLAddViewController.m
//  Clock
//
//  Created by wangtao on 14-1-5.
//  Copyright (c) 2014年 wangtao. All rights reserved.
//

#import "CLAddViewController.h"

@interface CLAddViewController ()

@end

@implementation CLAddViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = kGlobalBaseColor;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if (!self.clock) {
    }
    else
    {
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
