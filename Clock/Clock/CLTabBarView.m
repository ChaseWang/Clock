//
//  CLTabBarView.m
//  Clock
//
//  Created by wangtao on 13-12-18.
//  Copyright (c) 2013年 wangtao. All rights reserved.
//

#import "CLTabBarView.h"

#define CLTABBARVIEW_BUTTON_TAG 1000

@interface CLTabBarView ()
@property (nonatomic,strong) UIButton *recommendButton;
@property (nonatomic,strong) UIButton *feedBackButton;
@property (nonatomic,strong) UIButton *settingButton;
@property (nonatomic,strong) UIButton *aboutButton;
@end

@implementation CLTabBarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGFloat btnWidth = rect.size.width / 4;
    CGFloat btnHeight = rect.size.height;
    [self.recommendButton setFrame:CGRectMake(0, 0, btnWidth, btnHeight)];
    [self.feedBackButton setFrame:CGRectMake(rect.size.width/4, 0, btnWidth, btnHeight)];
    [self.settingButton setFrame:CGRectMake(2*rect.size.width/4, 0, btnWidth, btnHeight)];
    [self.aboutButton setFrame:CGRectMake(3*rect.size.width/4, 0, btnWidth, btnHeight)];

    [self addSubview:self.recommendButton];
    [self addSubview:self.feedBackButton];
    [self addSubview:self.settingButton];
    [self addSubview:self.aboutButton];
}

- (UIButton *)recommendButton
{
    if (!_recommendButton) {
        _recommendButton = [[UIButton alloc]init];
        _recommendButton.tag = CLTabBarTypeRecommend + CLTABBARVIEW_BUTTON_TAG;
        [_recommendButton setTitle:@"推荐" forState:UIControlStateNormal];
        [_recommendButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _recommendButton;
}

- (UIButton *)feedBackButton
{
    if (!_feedBackButton) {
        _feedBackButton = [[UIButton alloc]init];
        _feedBackButton.tag = CLTabBarTypeFeedBack + CLTABBARVIEW_BUTTON_TAG;
        [_feedBackButton setTitle:@"反馈" forState:UIControlStateNormal];
        [_feedBackButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _feedBackButton;
}

-(UIButton *)settingButton
{
    if (!_settingButton) {
        _settingButton = [[UIButton alloc]init];
        _settingButton.tag = CLTabBarTypeSetting + CLTABBARVIEW_BUTTON_TAG;
        [_settingButton setTitle:@"设置" forState:UIControlStateNormal];
        [_settingButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _settingButton;
}

-(UIButton *)aboutButton
{
    if (!_aboutButton) {
        _aboutButton = [[UIButton alloc]init];
        _aboutButton.tag = CLTabBarTypeAbout + CLTABBARVIEW_BUTTON_TAG;
        [_aboutButton setTitle:@"关于" forState:UIControlStateNormal];
        [_aboutButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _aboutButton;
}

- (void)buttonClick:(id)sender
{
    UIButton *btn = sender;
    if ([self.delegate respondsToSelector:@selector(tabbarButtonClick:type:)]) {
        [self.delegate tabbarButtonClick:self type:btn.tag - CLTABBARVIEW_BUTTON_TAG];
    }
}
@end
