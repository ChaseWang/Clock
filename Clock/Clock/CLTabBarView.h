//
//  CLTabBarView.h
//  Clock
//
//  Created by wangtao on 13-12-18.
//  Copyright (c) 2013年 wangtao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    CLTabBarTypeRecommend,
    CLTabBarTypeFeedBack,
    CLTabBarTypeSetting,
    CLTabBarTypeAbout
}CLTabBarType;

@class CLTabBarView;
@protocol CLTabBarDelegate <NSObject>
- (void)tabbarButtonClick:(CLTabBarView *)tabbar type:(CLTabBarType)type;
@end

@interface CLTabBarView : UIView
@property (nonatomic, weak) id<CLTabBarDelegate> delegate;
@end
