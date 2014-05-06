//
//  CLBaseViewController.m
//  Clock
//
//  Created by wangtao on 14-1-23.
//  Copyright (c) 2014年 wangtao. All rights reserved.
//

#import "CLBaseViewController.h"

@interface CLBaseViewController ()

@end

@implementation CLBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:kGlobalBaseColor];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
