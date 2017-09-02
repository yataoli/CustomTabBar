//
//  MBProgressHUD+MyExtension.m
//  CustomNavAndTabBar
//
//  Created by suge on 2017/9/2.
//  Copyright © 2017年 郑州鹿客互联网科技有限公司. All rights reserved.
//

#import "MBProgressHUD+MyExtension.h"

@implementation MBProgressHUD (MyExtension)
/**显示提示文字（1.5秒后消失）*/
+ (MBProgressHUD *)showTipString:(NSString *)string{
    return [self showTipString:string addToView:nil];
}
/**指定view上添加提示文字（1.5秒后消失）*/
+ (MBProgressHUD *)showTipString:(NSString *)string addToView:(UIView *)view{
    return [self showHUDWithTipStr:string addToView:view isAutomaticHide:YES];
}

/**显示hud*/
+ (MBProgressHUD *)shouHUDWithString:(NSString *)string{
    return [self showHUDWithTipStr:string addToView:[self getWillShowViewWithSourceView:nil] isAutomaticHide:NO];
}

/**在指定view上显示hud*/
+ (MBProgressHUD *)shouHUDWithString:(NSString *)string addToView:(UIView *)view{
    return [self showHUDWithTipStr:string addToView:[self getWillShowViewWithSourceView:view] isAutomaticHide:NO];
}



/**隐藏hud*/
+ (void)hiddenHUD{
    [self hideHUDOnView:nil];
}

/**隐藏hud*/
+ (void)hideHUDOnView:(UIView *)view{
    [self hideHUDForView:[self getWillShowViewWithSourceView:view] animated:YES];
}
+ (instancetype)showHUDWithTipStr:(NSString *)string addToView:(UIView *)view isAutomaticHide:(BOOL)isAutoHide{
    view = [self getWillShowViewWithSourceView:view];
    //show之前先hide之前的
    [self hideHUDOnView:view];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = isAutoHide == YES ? MBProgressHUDModeText : MBProgressHUDModeIndeterminate;
    hud.label.textColor = [UIColor whiteColor];
    hud.contentColor = [UIColor whiteColor];
    //方块颜色为黑色半透明颜色
    hud.bezelView.color = [UIColor colorWithRed:(0)/255.0 green:(0)/255.0 blue:(0)/255.0 alpha:0.6f];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.label.text = string;
    if (isAutoHide == YES) {
        [hud hideAnimated:YES afterDelay:1.5f];
    }
    return hud;
}

#pragma mark - 获取将要显示的view
+ (UIView *)getWillShowViewWithSourceView:(UIView *)sourceView{
    if (sourceView) {
        return sourceView;
    }else{
        sourceView = [[UIApplication sharedApplication].delegate window];
        if (!sourceView) {
            sourceView = [[[UIApplication sharedApplication] windows] lastObject];
        }
        return sourceView;
    }
    
}



@end
