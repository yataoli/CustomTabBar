//
//  LYUpdateVersion.h
//  BlockTest
//
//  Created by suge on 2017/4/3.
//  Copyright © 2017年 郑州鹿客互联网科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface LYUpdateVersion : NSObject
/**更新版本管理者*/
+ (instancetype)checkVersionManager;

/**获取Appstore和本地的版本信息进行比较判断是否在当前界面弹出升级提示框*/
- (void)checkVersionWithAPPID:(NSString *)appId;
@end