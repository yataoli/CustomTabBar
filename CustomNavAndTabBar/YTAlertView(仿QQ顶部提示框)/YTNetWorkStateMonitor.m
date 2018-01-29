//
//  YTNetWorkState.m
//  顶部提示
//
//  Created by suge on 2017/6/14.
//  Copyright © 2017年 kzkj. All rights reserved.
//

#import "YTNetWorkStateMonitor.h"

static YTNetWorkStateMonitor *netWorkState = nil;
@implementation YTNetWorkStateMonitor

+ (YTNetWorkStateMonitor *)shareNetWorkStateMonitor{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netWorkState = [[YTNetWorkStateMonitor alloc] init];
    });
    return netWorkState;
}
//获取当前网络类型
- (NSString *)getCurrentNetWorkType{
    NSString *netWorkType = @"0";
    // 1.检测wifi状态
    Reachability *wifi = [Reachability reachabilityForLocalWiFi];
    
    // 2.检测手机是否能上网络(WIFI\3G\2.5G)
    Reachability *conn = [Reachability reachabilityForInternetConnection];
    
    // 3.判断网络状态
    if ([wifi currentReachabilityStatus] != NotReachable) {
        
        // 有wifi
        netWorkType = @"wifi";
    } else if ([conn currentReachabilityStatus] != NotReachable) {
        
        // 没有使用wifi, 使用手机自带网络进行上网
        netWorkType = @"GPRS";
    } else {
        
        // 没有网络
        netWorkType = @"noConnect";
    }
    return netWorkType;
}
// 添加网络监听
- (void)addNetWorkStateMonitor{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netWorkStateChanged) name:kReachabilityChangedNotification object:nil];
    self.conn = [Reachability reachabilityForInternetConnection];
    [self.conn startNotifier];
}

// 触发时机，网络状态发生改变
- (void)netWorkStateChanged{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(netWorkStateChanged)]) {
        
        [self.delegate netWorkStateChanged];
    }
}

/**
 * 获取网络状态
 * YES 有网络
 * NO  无网络
 */
- (BOOL)getNetWorkState{
    
    Reachability *wifi = [Reachability reachabilityForLocalWiFi];
    Reachability *conn = [Reachability reachabilityForInternetConnection];
    
    if ([wifi currentReachabilityStatus] != NotReachable) {
        
        return YES;
    }else if([conn currentReachabilityStatus] != NotReachable) {
        
        return YES;
    }else{
        
        return NO;
    }
}

@end
