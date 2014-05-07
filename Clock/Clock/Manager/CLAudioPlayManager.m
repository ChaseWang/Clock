//
//  CLAudioPlayManager.m
//  Clock
//
//  Created by wangtao on 14-5-7.
//  Copyright (c) 2014年 wangtao. All rights reserved.
//

#import "CLAudioPlayManager.h"

@interface CLAudioPlayManager()
@property (nonatomic, strong) AVAudioPlayer *player;
@end

@implementation CLAudioPlayManager

+ (CLAudioPlayManager *)shareInstance
{
    static CLAudioPlayManager *sharedAudioPlayInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAudioPlayInstance = [[CLAudioPlayManager alloc]init];
    });
    return sharedAudioPlayInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    }
    return self;
}

- (void)playSoundOfFile:(NSURL *)url
{
    [self.player stop];
    self.player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    self.player.volume = 0.8;
    self.player.numberOfLoops = 100;
    self.player.delegate = self;

    [self.player prepareToPlay];
    [self.player play];
}

- (void)stop
{
    [self.player stop];
}
@end
