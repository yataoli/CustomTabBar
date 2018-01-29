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
    hud.labelText = string;
    if (isAutoHide == YES) {
        [hud hide:YES afterDelay:1.5];
    }
    return hud;
}

#pragma mark - 获取当前显示的view
+ (UIView *)getWillShowViewWithSourceView:(UIView *)sourceView{
    //如果传的有view直接返回
    if (sourceView) {
        return sourceView;
    }
    
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    id  nextResponder = nil;
    UIViewController *appRootVC=window.rootViewController;
    //    如果是present上来的appRootVC.presentedViewController 不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    }else{
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
    }
    
    if ([nextResponder isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        //        UINavigationController * nav = tabbar.selectedViewController ; 上下两种写法都行
        result=nav.childViewControllers.lastObject;
        
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else{
        result = nextResponder;
    }
    
    return result.view;
}



@end
