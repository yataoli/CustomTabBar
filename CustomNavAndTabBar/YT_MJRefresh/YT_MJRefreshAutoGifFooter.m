//
//  YT_MJRefreshAutoGifFooter.m
//  CustomNavAndTabBar
//
//  Created by 付宝网络 on 2018/2/8.
//  Copyright © 2018年 郑州鹿客互联网科技有限公司. All rights reserved.
//

#import "YT_MJRefreshAutoGifFooter.h"

@implementation YT_MJRefreshAutoGifFooter
#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];
    //根据拖拽的情况自动切换透明度
    self.automaticallyChangeAlpha = YES;
    // 设置正在刷新状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}


@end
