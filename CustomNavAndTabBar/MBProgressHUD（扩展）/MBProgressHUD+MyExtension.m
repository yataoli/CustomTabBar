//
//  MBProgressHUD+MyExtension.m
//  CustomNavAndTabBar
//
//  Created by suge on 2017/9/2.
//  Copyright © 2017年 郑州鹿客互联网科技有限公司. All rights reserved.
//

#import "MBProgressHUD+MyExtension.h"
static UIView *currentView = nil;
@implementation MBProgressHUD (MyExtension)


/**在指定view上显示hud*/
+ (MBProgressHUD *)shouHUDWithStr:(NSString *)string atView:(UIView *)view{
    currentView = view;
    return [self showHUDWithTipStr:string addToView:[self getWillShowViewWithSourceView:view] isAutomaticHide:NO];
}



/**隐藏hud*/
+ (void)hiddenHUD{
    [self hideHUDOnView:currentView];
}

/**隐藏hud*/
+ (void)hideHUDOnView:(UIView *)view{
    [self hideHUDForView:view animated:YES];
}
+ (instancetype)showHUDWithTipStr:(NSString *)string addToView:(UIView *)view isAutomaticHide:(BOOL)isAutoHide{
//    view = [self getWillShowViewWithSourceView:view];
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
