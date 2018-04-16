//
//  YT_GuidePageViewController.h
//  YT_GuidePageVC
//
//  Created by 付宝网络 on 2018/4/11.
//  Copyright © 2018年 liyatao. All rights reserved.
//
/*   具体使用用法
 
     - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
     // Override point for customization after application launch.
     NSLog(@"%@",NSHomeDirectory());
 
     BOOL isFirstShow = [YT_GuidePageViewController isFirstShow];
     isFirstShow = YES;
     if (isFirstShow == YES) {
     //显示引导页
    //存放图片的数组
     NSArray *imageArray = @[@"1",@"3.jpeg",@"4.jpeg",@"5.jpeg"];
     YT_GuidePageViewController *VC = [[YT_GuidePageViewController alloc] initWithImageNameArray:imageArray];
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
 
     return YES;
     }
     #pragma mark - 要进入的视图控制器
     - (void)enterViewController{
     ViewController *vc = [[ViewController alloc] init];
     self.window.rootViewController = vc;
     }
 */










#import <UIKit/UIKit.h>

@protocol YT_GuidePageViewControllerDelegate <NSObject>

- (void)enterViewController;

@end

@interface YT_GuidePageViewController : UIViewController

/**初始化 图片数组（图片名字或者url 字符串）*/
- (instancetype)initWithImageArray:(NSArray *)images;
+ (BOOL)isFirstShow;
@property (nonatomic, weak) id<YT_GuidePageViewControllerDelegate> delegate;
/**pageControl的正常颜色和选中颜色数组(默认为浅白色和白色)*/ 
@property (nonatomic,strong) NSArray * pageControlNomalAndSelecteColorArray;
/**每一页都显示跳过按钮(默认前几页不显示按钮)*/
@property (nonatomic) BOOL everyPageShowEnterBtn;
@end
