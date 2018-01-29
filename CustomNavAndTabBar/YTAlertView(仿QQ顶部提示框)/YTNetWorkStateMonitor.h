//
//  YTNetWorkState.h
//  顶部提示
//
//  Created by suge on 2017/6/14.
//  Copyright © 2017年 kzkj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
#import "YTAlertViewManager.h"
@protocol YTNetWorkStateMonitorDelegate <NSObject>

@optional
/**
 *当网络状态发生改变的时候触发， 前提是必须是添加网络状态监听
 */
- (void)netWorkStateChanged;

@end


@interface YTNetWorkStateMonitor : NSObject

@property (nonatomic,weak) id <YTNetWorkStateMonitorDelegate> delegate;

@property (nonatomic, strong) Reachability *conn;

/**
 * 实例化单例对象
 */
+ (YTNetWorkStateMonitor *)shareNetWorkStateMonitor;

/**
 * 获取当前网络类型 GPRS / wifi / noConnect
 */
- (NSString *)getCurrentNetWorkType;

/**
 * 添加网络状态监听
 */
- (void)addNetWorkStateMonitor;

/**
 * 获取网络状态
 * YES 有网络
 * NO  无网络
 */
- (BOOL)getNetWorkState;



@end
