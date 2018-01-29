//
//  YTHeader.h
//  本地通知
//
//  Created by 付宝网络 on 2017/12/27.
//  Copyright © 2017年 郑州鹿客互联网科技有限公司. All rights reserved.
//

#ifndef YTHeader_h
#define YTHeader_h

//控制台 debug 输出
#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(__stderrp,"%s %s:%d\t%s\t%s\n",__TIME__,[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __FUNCTION__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...)
#endif

//导航到某个控制器
#define YT_PushToVC(_ViewController_,_YesOrNo_) _ViewController_ *viewController = [[_ViewController_ alloc] init];viewController.hidesBottomBarWhenPushed = YES;[self.navigationController pushViewController:viewController animated:_YesOrNo_];

// NSUserDefaults 宏
#define UserDefaults [NSUserDefaults standardUserDefaults]

//弱引用
#define WeakSelf __weak typeof(self) weakSelf = self;

//获取一个随机整数范围在：[0,100)包括0，不包括100
#define RandomNumber arc4random() % 100


//屏幕宽
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

//屏幕高
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

//屏幕的尺寸 4.0
#define IPHONE_4_0 ([[UIScreen mainScreen] bounds].size.height == 568.0)
//屏幕的尺寸 4.7
#define IPHONE_4_7 ([[UIScreen mainScreen] bounds].size.height == 667.0)
//屏幕的尺寸 5.5
#define IPHONE_5_5  ([[UIScreen mainScreen] bounds].size.height == 736.0)
//屏幕的尺寸 (宽375和4.7一样 高812)
#define IPHONEX  ([[UIScreen mainScreen] bounds].size.height == 812.0)

//判断当前设备是否是iPad
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//设置字体大小自适应
#define YT_FONT_Auto [UIFont systemFontOfSize:(IPHONE_4_0 ? 13.f : (IPHONE_4_7 ? 15.f : (IPHONE_5_5 ? 16.f : (IPHONEX ? 15.f : 15.f))))]

//设置字体大小
#define YT_FONT(_fontSize_) [UIFont systemFontOfSize:_fontSize_]

// 适配 iPhone X

//用于判断设备是否为 iphone X
#define IS_IPHONE_X (fabs( (double)SCREEN_HEIGHT - (double )812) < DBL_EPSILON)

// 状态栏高度
#define YT_Status_Height [[UIApplication sharedApplication] statusBarFrame].size.height
//(IS_IPHONE_X ? 44.f:20.f)

//tabbar高度
#define YT_Tabbar_Height (IS_IPHONE_X ? (49.f + 34.f):49.f)

//导航栏和状态了高度
#define YT_StatusAndNavBar_Height (IS_IPHONE_X ? 88.f:64.f)

//底部约束高度
#define YT_Bottom_Margin (IS_IPHONE_X ? 34.f:0.f)

// 配置视图安全区域范围
#define YT_ViewSafeAreInsets(view) ({UIEdgeInsets insets; if(@available(iOS 11.0, *)) {insets = view.safeAreaInsets;} else {insets = UIEdgeInsetsZero;} insets;})



#endif /* YTHeader_h */
