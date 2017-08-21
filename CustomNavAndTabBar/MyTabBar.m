//
//  MyTabBar.m
//  CustomNavAndTabBar
//
//  Created by suge on 2017/7/28.
//  Copyright © 2017年 郑州鹿客互联网科技有限公司. All rights reserved.
//

#import "MyTabBar.h"

@interface MyTabBar ()

@property (nonatomic,strong) UIButton *button;

@end

@implementation MyTabBar
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setBackgroundImage:[UIImage imageNamed:@"post_animate_add"] forState:UIControlStateNormal];// tabbar_compose_button
        [_button setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [_button setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [_button setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        _button.frame = CGRectMake((self.frame.size.width - 44)/2, -13, 44, 44);
        _button.userInteractionEnabled = NO;

        [self addSubview:_button];
    }
    return self;
}
#pragma mark - 重新布局子视图的时候，会调用这个方法
- (void)layoutSubviews{
    [super layoutSubviews];
    [self bringSubviewToFront:_button];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
