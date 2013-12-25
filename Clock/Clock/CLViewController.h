//
//  CLViewController.h
//  Clock
//
//  Created by wangtao on 13-10-21.
//  Copyright (c) 2013年 wangtao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLTabBarView.h"

@interface CLViewController : UIViewController<CLTabBarDelegate>
@property (nonatomic, strong) CLTabBarView *tabBarView;
@end
