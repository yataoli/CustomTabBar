//
//  YT_MJRefreshFooter.m
//  CustomNavAndTabBar
//
//  Created by 付宝网络 on 2018/2/8.
//  Copyright © 2018年 郑州鹿客互联网科技有限公司. All rights reserved.
//

#import "YT_MJRefreshFooter.h"

@implementation YT_MJRefreshFooter
#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];
    //根据拖拽的情况自动切换透明度
    self.automaticallyChangeAlpha = YES;
    //隐藏时间
    //    self.lastUpdatedTimeLabel.hidden = YES;
    
    // 隐藏状态
    //    self.stateLabel.hidden = YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
