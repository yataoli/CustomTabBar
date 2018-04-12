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
 *当网络状态发生改变的时候触发
 */
- (void)netWorkStateChangedWithType:(NSString *)type;

@end


@interface YT_NetWorkStateMonitor : NSObject

@property (nonatomic,weak) id <YTNetWorkStateMonitorDelegate> delegate;
@property (nonatomic,strong) Reachability *conn;
/**
 * 实例化单例对象
 */
+ (YT_NetWorkStateMonitor *)shareNetWorkStateMonitor;

/**
 * 获取当前网络类型 2G 3G 4G  / wifi / NO(无网络)
 */
- (NSString *)getNetWorkType;
/**必须添加网络监听*/
- (void)addNetWorkStateMonitor;


@end
