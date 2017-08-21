//
//  SkinManager.m
//  CustomNavAndTabBar
//
//  Created by suge on 2017/8/7.
//  Copyright © 2017年 郑州鹿客互联网科技有限公司. All rights reserved.
//

#import "SkinManager.h"

@implementation SkinManager
+ (instancetype)shareSkinManager{
    static SkinManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SkinManager alloc] init];
    });
    return manager;
}
- (instancetype)init{
    if (self = [super init]) {
        _currentSkin = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentSkin"];

        if (_currentSkin == nil) {
            //设置一个默认值。
            _currentSkin = @"1111";
        }
    }
    return self;
}

@end
