//
//  CLAddViewController.m
//  Clock
//
//  Created by wangtao on 14-1-5.
//  Copyright (c) 2014年 wangtao. All rights reserved.
//

#import "CLAddViewController.h"
#import "ClockView.h"

@interface CLAddViewController ()
@property (nonatomic, strong) ClockView *clockSetView;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UIButton *cancelButton;
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

- (void)loadView
{
    [super loadView];
    self.clockSetView = [[ClockView alloc]initWithFrame:CGRectMake(10, 20, 300, 300)];
    [self.clockSetView setClockBackgroundImage:[UIImage imageNamed:@"clock-background.png"].CGImage];
	[self.clockSetView setHourHandImage:[UIImage imageNamed:@"clock-hour-background.png"].CGImage];
	[self.clockSetView setMinHandImage:[UIImage imageNamed:@"clock-min-background.png"].CGImage];
	[self.clockSetView setSecHandImage:[UIImage imageNamed:@"clock-sec-background.png"].CGImage];
    [self.view addSubview:self.clockSetView];
    [self.clockSetView start];

    self.cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 400, 100, 40)];
    [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelButton setBackgroundColor:[UIColor grayColor]];
    [self.cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cancelButton];

    self.confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(200, 400, 100, 40)];
    [self.confirmButton setTitle:@"确认" forState:UIControlStateNormal];
    [self.confirmButton setBackgroundColor:[UIColor grayColor]];
    [self.confirmButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.confirmButton];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if (!self.clock) {
        self.clock = [[CLClockObject alloc]init];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cancelButtonClick:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(addClockCancel:)]) {
        [self.delegate addClockCancel:self.clock];
    }
}

- (void)confirmButtonClick:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(addClockConfirm:)]) {
        [self setAddedClock];
        [self.delegate addClockConfirm:self.clock];
    }
}

- (void)setAddedClock
{
    NSString *date = [[NSDate date]dateToString:@"yyyy-MM-dd"];
    NSString *h = [[NSDate date]dateToString:@"HH"];
    NSString *m = [[NSDate date]dateToString:@"mm"];
    NSString *clock = [NSString stringWithFormat:@"%@ %d%@",date,[h integerValue] + 1,m];
    self.clock.clockDate = [NSDate dateWithString:clock format:@"yyyy-MM-dd HH:mm:ss"];
}

@end
