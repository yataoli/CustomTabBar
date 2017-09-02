//
//  MBProgressHUD+MyExtension.h
//  CustomNavAndTabBar
//
//  Created by suge on 2017/9/2.
//  Copyright © 2017年 郑州鹿客互联网科技有限公司. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (MyExtension)
/**显示提示文字（1.5秒后消失）*/
+ (MBProgressHUD *)showTipString:(NSString *)string;

/**指定view上添加提示文字（1.5秒后消失）*/
+ (MBProgressHUD *)showTipString:(NSString *)string addToView:(UIView *)view;

/**显示hud*/
+ (MBProgressHUD *)shouHUDWithString:(NSString *)string;

/**在指定view上显示hud*/
+ (MBProgressHUD *)shouHUDWithString:(NSString *)string addToView:(UIView *)view;

/**隐藏hud*/
+ (void)hiddenHUD;
@end
