//
//  ZAlertViewManager.h
//  顶部提示
//
//  Created by YYKit on 2017/5/27.
//  Copyright © 2017年 YZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YTAlertView.h"
@interface YTAlertViewManager : NSObject
@property (nonatomic,strong)YTAlertView *alertView;
+ (YTAlertViewManager *)shareManager;
/**显示顶部弹窗*/
- (void)showWithType:(AlertViewType)type;
/**在几秒后移除顶部弹窗*/
- (void)dismissAfterTime:(NSInteger)time;
@end
