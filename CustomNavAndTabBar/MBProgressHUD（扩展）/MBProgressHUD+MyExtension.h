//
//  MBProgressHUD+MyExtension.h
//  CustomNavAndTabBar
//
//  Created by suge on 2017/9/2.
//  Copyright © 2017年 郑州鹿客互联网科技有限公司. All rights reserved.
//
#import "MBProgressHUD.h"

@interface MBProgressHUD (MyExtension)


/**显示hud*/
+ (MBProgressHUD *)shouHUDWithStr:(NSString *)string atView:(UIView *)view;

/**隐藏hud*/
+ (void)hiddenHUD;
@end
