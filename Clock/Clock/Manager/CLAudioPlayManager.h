//
//  CLAudioPlayManager.h
//  Clock
//
//  Created by wangtao on 14-5-7.
//  Copyright (c) 2014年 wangtao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface CLAudioPlayManager : NSObject<AVAudioPlayerDelegate>
+ (CLAudioPlayManager *)shareInstance;

- (void)playSoundOfFile:(NSURL *)url;
- (void)stop;
@end
