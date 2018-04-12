//
//  AppDelegate.m
//  CustomNavAndTabBar
//
//  Created by suge on 2017/7/28.
//  Copyright © 2017年 郑州鹿客互联网科技有限公司. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTabBarController.h"
#import "PushViewController.h"
#import "YT_GuidePageViewController.h"
@interface AppDelegate ()<UITabBarControllerDelegate,YT_GuidePageViewControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    BOOL isFirstShow = [YT_GuidePageViewController isFirstShow];
    isFirstShow = YES;
    if (isFirstShow == YES) {
        //显示引导页
        //存放图片的数组
//        NSArray *imageArray = @[@"1",@"3.jpeg",@"4.jpeg",@"5.jpeg"];
//        YT_GuidePageViewController *VC = [[YT_GuidePageViewController alloc] initWithImageNameArray:imageArray];
        
        NSArray *imageArray = @[@"http://47.92.5.70/fz/img/q10.png",@"http://47.92.5.70/fz/img/q11.png",@"http://47.92.5.70/fz/img/q12.png",@"http://47.92.5.70/fz/img/q13.png"];
        YT_GuidePageViewController *VC = [[YT_GuidePageViewController alloc] initWithImageUrlArray:imageArray];

        VC.delegate = self;
        //设置pageControl的颜色 默认为浅白色和白色
        //VC.pageControlNomalAndSelecteColorArray = @[[UIColor lightGrayColor],[UIColor redColor]];
        //设置前边几页是否显示跳过按钮  默认不展示
        //VC.everyPageShowEnterBtn = NO;
        self.window.rootViewController = VC;
        NSLog(@"进入引导页");
        
    }else{
        //进入主页
        NSLog(@"直接进入主页");
        [self enterViewController];
    }
    [self.window makeKeyAndVisible];
    
    return YES;
}
- (void)enterViewController{
    BaseTabBarController *baseBar = [[BaseTabBarController alloc] init];
    baseBar.delegate = self;
    self.window.rootViewController = baseBar;
    

}
#pragma mark - 将要选中tabBar上按钮的时候会调用这个协议方法

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    if ([tabBarController.viewControllers indexOfObject:viewController] == 1) {
        PushViewController *pushVC = [[PushViewController alloc] init];
        pushVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [tabBarController presentViewController:pushVC animated:NO completion:nil];
        return NO;

    }else{
        return YES;
    }
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
