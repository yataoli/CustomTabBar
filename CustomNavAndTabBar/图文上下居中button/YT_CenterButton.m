//
//  YT_CenterButton.m
//  CustomNavAndTabBar
//
//  Created by 付宝网络 on 2018/2/22.
//  Copyright © 2018年 郑州鹿客互联网科技有限公司. All rights reserved.
//

#import "YT_CenterButton.h"

@implementation YT_CenterButton
-(void)layoutSubviews {
    [super layoutSubviews];
    
    
    // 图片居中
    CGPoint center = self.imageView.center;
    center.x = self.frame.size.width/2;
    center.y = self.frame.size.height/2 - 5;
    
    self.imageView.center = center;
    
    // 文字居中
    CGRect newFrame = [self titleLabel].frame;
    newFrame.origin.x = 0;
    newFrame.origin.y = CGRectGetMaxY(self.imageView.frame) + 2;
    newFrame.size.width = self.frame.size.width;
    self.titleLabel.frame = newFrame;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
