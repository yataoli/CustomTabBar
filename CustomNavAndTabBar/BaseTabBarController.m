//
//  BaseTabBarController.m
//  CustomNavAndTabBar
//
//  Created by suge on 2017/7/28.
//  Copyright © 2017年 郑州鹿客互联网科技有限公司. All rights reserved.
//

#import "BaseTabBarController.h"
#import "MyNavigationViewController.h"
#import "HomeViewController.h"
#import "ShopCarViewController.h"
#import "MeViewController.h"
#import "UIColor+HexRGB.h"

#import "MyTabBar.h"
#import "SkinManager.h"

@interface BaseTabBarController (){
    NSArray* _images;
    
    NSArray* _selectedImages;
    
    NSArray *_defaultImages;
    NSArray *_defaultSelectedImages;
}

@end

@implementation BaseTabBarController
- (void)viewDidLoad{
   [self createUI]; 
}
- (void)createUI{
    
    MyTabBar *tabBar = [[MyTabBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 49)];
    tabBar.tintColor = [UIColor colorWithRed:251.0f / 255.0f green:132.0f / 255.0f blue:0.0f alpha:1.0f];
    
    
    
    
    
    //首页
    HomeViewController *homeView =[[HomeViewController alloc] init];
    MyNavigationViewController *homeNavigation = [[MyNavigationViewController alloc] initWithRootViewController:homeView];
    [homeNavigation.navigationItem setHidesBackButton:YES];
    [homeNavigation.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    
    UIImage *image1 =[[UIImage imageNamed:@"首页dpng"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *item1 =[[UITabBarItem alloc]initWithTitle:@"首页" image:[[UIImage imageNamed:@"首页png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:image1];
    homeNavigation.tabBarItem =item1;
    [item1 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorFromHexRGB:@"333333"],NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    [item1 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorFromHexRGB:@"f23030"],NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
    [self addChildViewController:homeNavigation];
    
    
    
    //购物车
    ShopCarViewController *shopView =[[ShopCarViewController alloc] init];
    MyNavigationViewController *shopNavigation = [[MyNavigationViewController alloc] initWithRootViewController:shopView];
    [shopNavigation.navigationItem setHidesBackButton:YES];
    [shopNavigation.navigationBar setBarTintColor:[UIColor whiteColor]];
    

    
    
    UIImage *image2 =[[UIImage imageNamed:@""]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *item2 =[[UITabBarItem alloc]initWithTitle:@"购物车" image:[[UIImage imageNamed:@""]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:image2];
    shopNavigation.tabBarItem =item2;
    [item2 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorFromHexRGB:@"333333"],NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    [item2 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorFromHexRGB:@"f23030"],NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
    
    [self addChildViewController:shopNavigation];
    
    
    //我的
    MeViewController *meView =[[MeViewController alloc] init];
    MyNavigationViewController *meNavigation = [[MyNavigationViewController alloc] initWithRootViewController:meView];
    [meNavigation.navigationItem setHidesBackButton:YES];
    [meNavigation.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    UIImage *image3 =[[UIImage imageNamed:@"我的dpng"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *item3 =[[UITabBarItem alloc]initWithTitle:@"我的" image:[[UIImage imageNamed:@"我的png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:image3];
    meNavigation.tabBarItem =item3;
    [item3 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorFromHexRGB:@"333333"],NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    [item3 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorFromHexRGB:@"f23030"],NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
    [self addChildViewController:meNavigation];
        
    [self setValue:tabBar forKey:@"tabBar"];
    
    _images = @[@"tab_recent_nor.png", @"tab_buddy_nor.png", @"tab_qworld_nor.png"];
    
    _selectedImages = @[@"tab_recent_press.png", @"tab_buddy_press.png", @"tab_qworld_press.png"];
    _defaultImages = @[@"tabbar_home.png",@"tabbar_home.png",@"tab_buddy_nor.png"];
    _defaultSelectedImages = @[@"tabbar_home_selected.png",@"tabbar_home.png",@"tab_buddy_press.png"];
    [[SkinManager shareSkinManager] addObserver:self forKeyPath:@"currentSkin" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial context:nil];
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSString *currentSkin = change[@"new"];
    
    if ([currentSkin isEqualToString:@"00000"] ){
        return;
    }else{
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:currentSkin ofType:@"bundle"];
        NSString *tabBarBackgroundImagePath = [bundlePath stringByAppendingPathComponent:@"tabbar_bg_ios7.png"];
        self.tabBar.backgroundImage = [[UIImage alloc] initWithContentsOfFile:tabBarBackgroundImagePath];
        if ([currentSkin isEqualToString:@"1111"]){
            [self.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if (idx != 1){
                    
                    obj.tabBarItem.image = [UIImage imageNamed:_defaultImages[idx]];
                    
                    obj.tabBarItem.selectedImage = [UIImage imageNamed:_defaultSelectedImages[idx]];
                }
                
            }];
        }else{
            [self.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if (idx != 1)
                {
                    NSString *imagePath = [bundlePath stringByAppendingPathComponent:_images[idx]];
                    obj.tabBarItem.image = [[[UIImage alloc] initWithContentsOfFile:imagePath] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                    NSString *selectedPath = [bundlePath stringByAppendingPathComponent:_selectedImages[idx]];
                    obj.tabBarItem.selectedImage = [[[UIImage alloc] initWithContentsOfFile:selectedPath] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                }
                
            }];
        }
        
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
