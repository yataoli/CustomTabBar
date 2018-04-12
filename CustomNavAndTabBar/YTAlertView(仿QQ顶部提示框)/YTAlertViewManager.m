//
//  ZAlertViewManager.m
//  顶部提示
//
//  Created by YYKit on 2017/5/27.
//  Copyright © 2017年 YZ. All rights reserved.
//

#import "YTAlertViewManager.h"

@implementation YTAlertViewManager

#pragma mark 创建伪单例，确保弹窗的唯一性
+ (YTAlertViewManager *)shareManager
{
    static YTAlertViewManager *shareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[YTAlertViewManager alloc]init];
        shareManager.alertView = [[YTAlertView alloc]init];
        [[UIApplication sharedApplication].keyWindow addSubview:shareManager.alertView];

    });
    return shareManager;
}
- (void)setTopTxt:(NSString *)topTxt{
    self.alertView.tipsLabel.text = topTxt;
}
- (void)setIconImage:(UIImage *)iconImage{
    self.alertView.imageView.image = iconImage;
}
#pragma mark 显示弹窗
- (void)showWithType:(AlertViewType)type
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.alertView topAlertViewTypewWithType:type];
        [self.alertView show];
    });
}

#pragma mark - 移除弹窗
- (void)dismissAfterTime:(NSInteger)time
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.alertView dismiss];
        });
    });
}
@end
