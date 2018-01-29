//
//  ZAlertView.m
//  顶部提示
//
//  Created by YYKit on 2017/5/27.
//  Copyright © 2017年 YZ. All rights reserved.
//

#import "YTAlertView.h"
#import "UIColor+Hexadecimal.h"

#define Start_Height -64
#define Height 64
#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Left_Offset 45
#define Font_Size 14.0f
#define Image_Center_X 25
#define Image_Center_Y 40
#define Image_Width 20
@implementation YTAlertView

#pragma mark 左侧的icon
- (UIImageView *)imageView
{
    if (_imageView == nil)
    {
        _imageView = [[UIImageView alloc]init];
        _imageView.frame = CGRectMake(0, 0, Image_Width, Image_Width);
        _imageView.center = CGPointMake(Image_Center_X, Image_Center_Y);
        [self addSubview:_imageView];
    }
    return _imageView;
}

#pragma mark 右侧的文字提示
- (UILabel *)tipsLabel
{
    if (_tipsLabel == nil)
    {
        _tipsLabel = [[UILabel alloc]init];
        _tipsLabel.numberOfLines = 0;
        _tipsLabel.frame = CGRectMake(Left_Offset, 20, Screen_Width - Left_Offset, 40);
        _tipsLabel.textAlignment = NSTextAlignmentLeft;
        _tipsLabel.font = [UIFont systemFontOfSize:Font_Size];
        [self addSubview:_tipsLabel];
    }
    return _tipsLabel;
}

#pragma mark 初始化
- (instancetype)init
{
    self = [super init];
    if (self)
    {
//        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
    return self;
}

#pragma mark 设置type
- (void)topAlertViewTypewWithType:(AlertViewType)type
{
    switch (type)
    {
        case AlertViewTypeSuccess:
        {
            self.frame = CGRectMake(0, Start_Height, Screen_Width, Height);
            self.backgroundColor = [UIColor colorWithHexString:@"#E5E5E5"];
            self.imageView.image = [UIImage imageNamed:@"success.png"];
            self.tipsLabel.text = @"Success!";
            self.tipsLabel.textColor = [UIColor darkTextColor];
        }
            break;
        case AlertViewTypeError:
        {
            self.frame = CGRectMake(0, Start_Height, Screen_Width, Height);
            self.backgroundColor = [UIColor colorWithHexString:@"#EE7942"];
            self.imageView.image = [UIImage imageNamed:@"error.png"];
            self.tipsLabel.text = @"Error!";
            self.tipsLabel.textColor = [UIColor groupTableViewBackgroundColor];
        }
            break;
        case AlertViewTypeNoNetwork:
        {
            self.frame = CGRectMake(0, Start_Height, Screen_Width, Height);
            self.backgroundColor = [UIColor colorWithHexString:@"#EE7942"];
            self.imageView.image = [UIImage imageNamed:@"nonetwork.png"];
            self.tipsLabel.text = @"当前网络不可用,请检查您的网络设置";
            self.tipsLabel.textColor = [UIColor groupTableViewBackgroundColor];
        }
            break;
        default:
            break;
    }

}

#pragma mark 显示
- (void)show
{
    [UIView animateWithDuration:1.0f
                          delay:0
         usingSpringWithDamping:0.3f
          initialSpringVelocity:6.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
                         self.center = CGPointMake(self.center.x, 32);
                     }
                     completion:^(BOOL finished) {
                     }];

}
#pragma mark 移除
- (void)dismiss
{
    [UIView animateWithDuration:1.0f
                          delay:0
         usingSpringWithDamping:0.99f
          initialSpringVelocity:6.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.center = CGPointMake(self.center.x, -32);
                     }
                     completion:^(BOOL finished) {
                     }];

}
@end
