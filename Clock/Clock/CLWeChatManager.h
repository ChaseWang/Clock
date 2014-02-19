//
//  CLWeChatManager.h
//  Clock
//
//  Created by wangtao on 14-2-19.
//  Copyright (c) 2014年 wangtao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"

@interface CLWeChatManager : NSObject<WXApiDelegate>
{
    enum WXScene _scene;
}

- (BOOL)handleOpenURL:(NSURL *)url;

+ (CLWeChatManager *)sharedManager;
@end
