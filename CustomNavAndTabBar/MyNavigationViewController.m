//
//  MyNavigationViewController.m
//  CustomNavAndTabBar
//
//  Created by suge on 2017/8/7.
//  Copyright © 2017年 郑州鹿客互联网科技有限公司. All rights reserved.
//

#import "MyNavigationViewController.h"
#import "SkinManager.h"
@interface MyNavigationViewController ()

@end

@implementation MyNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[SkinManager shareSkinManager] addObserver:self forKeyPath:@"currentSkin" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial context:nil];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    NSLog(@"%@",change);
    NSString *currentSkin = change[@"new"];
    
    if ([currentSkin isEqualToString:@"1111"]){
        [SkinManager shareSkinManager].myImage = nil;
        [self.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    }else{
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:currentSkin ofType:@"bundle"];
        NSString *navigationBackgroundImagePath = [bundlePath stringByAppendingPathComponent:@"header_bg_ios7.png"];
        
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:navigationBackgroundImagePath];
        [SkinManager shareSkinManager].myImage = image;
        [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    }
    
    //        self.navigationBar.translucent = YES时（即透明）坐标是从（0，0）点开始的
    //        self.navigationBar.translucent = NO时（即不透明）坐标是从（0，64）点开始的
    self.navigationBar.translucent = YES;
    //    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
