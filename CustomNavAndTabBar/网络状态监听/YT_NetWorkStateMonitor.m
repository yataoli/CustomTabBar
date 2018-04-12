//
//  YTNetWorkState.m
//  顶部提示
//
//  Created by suge on 2017/6/14.
//  Copyright © 2017年 kzkj. All rights reserved.
//

#import "YT_NetWorkStateMonitor.h"

#import <CoreTelephony/CTTelephonyNetworkInfo.h>

static YT_NetWorkStateMonitor *netWorkState = nil;

@implementation YT_NetWorkStateMonitor

+ (YT_NetWorkStateMonitor *)shareNetWorkStateMonitor{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netWorkState = [[YT_NetWorkStateMonitor alloc] init];
        
    });
    return netWorkState;
}
#pragma mark - 获取当前网络类型
- (NSString *)getNetWorkType{
    
    NSString *netWorkType;
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
        netWorkType = [self getNetType];
        
    } else {
        
        // 没有网络
        netWorkType = @"NO";
    }
    NSLog(@"当前网络类型 == %@",netWorkType)
    
    return netWorkType;
}
// 添加网络监听
- (void)addNetWorkStateMonitor{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netWorkStateChanged) name:kReachabilityChangedNotification object:nil];
    self.conn = [Reachability reachabilityForInternetConnection];
    [self.conn startNotifier];
}

#pragma mark - 触发时机，网络状态发生改变
- (void)netWorkStateChanged{
    NSLog(@"切换后的网络类型 == %@",[self getNetWorkType]);
    if (self.delegate && [self.delegate respondsToSelector:@selector(netWorkStateChangedWithType:)]) {
        [self.delegate netWorkStateChangedWithType:[self getNetWorkType]];
        
    }
}
#pragma mark - 获取手机网络类型
- (NSString *)getNetType
{
    
    NSArray *typeStrings2G = @[CTRadioAccessTechnologyEdge,
                               CTRadioAccessTechnologyGPRS,
                               CTRadioAccessTechnologyCDMA1x];
    
    NSArray *typeStrings3G = @[CTRadioAccessTechnologyHSDPA,
                               CTRadioAccessTechnologyWCDMA,
                               CTRadioAccessTechnologyHSUPA,
                               CTRadioAccessTechnologyCDMAEVDORev0,
                               CTRadioAccessTechnologyCDMAEVDORevA,
                               CTRadioAccessTechnologyCDMAEVDORevB,
                               CTRadioAccessTechnologyeHRPD];
    
    NSArray *typeStrings4G = @[CTRadioAccessTechnologyLTE];
    NSString *netconnType;
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    NSString *currentStatus = info.currentRadioAccessTechnology;
    
    if ([typeStrings4G containsObject:currentStatus]) {
        netconnType = @"4G";
    } else if ([typeStrings3G containsObject:currentStatus]) {
        netconnType = @"3G";
    } else if ([typeStrings2G containsObject:currentStatus]) {
        netconnType = @"2G";
       
    }else {
        //未知网络
        netconnType = nil;
    }
    return netconnType;

}


@end
