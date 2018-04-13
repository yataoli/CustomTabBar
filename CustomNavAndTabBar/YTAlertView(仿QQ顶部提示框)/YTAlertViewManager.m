//
//  ZAlertViewManager.m
//  顶部提示
//
//  Created by YYKit on 2017/5/27.
//  Copyright © 2017年 YZ. All rights reserved.
//

#define Start_Height -64
#define Height 64
#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Left_Offset 45
#define Font_Size 14.0f
#define Image_Center_X 25
#define Image_Center_Y 40
#define Image_Width 20

#import "YTAlertViewManager.h"

@interface YTAlertView ()
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *tipsLabel;

@property (nonatomic,strong) NSString * textString;
@property (nonatomic,strong) NSString * imageName;
@end

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

#pragma mark 设置type
- (void)topAlertViewTypewWithType:(AlertViewType)type
{
    switch (type)
    {
        case AlertViewTypeSuccess:
        {
            self.frame = CGRectMake(0, Start_Height, Screen_Width, Height);
            self.backgroundColor = [UIColor colorWithRed:229/250.0 green:229/250.0 blue:229/250.0 alpha:1.0];
            self.imageView.image = [UIImage imageNamed:@"success.png"];
            self.tipsLabel.text = @"Success!";
            self.tipsLabel.textColor = [UIColor darkTextColor];
        }
            break;
        case AlertViewTypeError:
        {
            self.frame = CGRectMake(0, Start_Height, Screen_Width, Height);
            self.backgroundColor = [UIColor colorWithRed:238/250.0 green:121/250.0 blue:66/250.0 alpha:1.0];
            self.imageView.image = [UIImage imageNamed:@"error.png"];
            self.tipsLabel.text = @"Error!";
            self.tipsLabel.textColor = [UIColor groupTableViewBackgroundColor];
        }
            break;
        case AlertViewTypeNoNetwork:
        {
            self.frame = CGRectMake(0, Start_Height, Screen_Width, Height);
            self.backgroundColor = [UIColor colorWithRed:238/250.0 green:121/250.0 blue:66/250.0 alpha:1.0];
            self.imageView.image = [UIImage imageNamed:@"nonetwork.png"];
            self.tipsLabel.text = @"当前网络不可用,请检查您的网络设置";
            self.tipsLabel.textColor = [UIColor groupTableViewBackgroundColor];
        }
            break;
        default:
            break;
    }
    
}
#pragma mark - 重新设置提示文字
- (void)setTextString:(NSString *)textString{
    self.tipsLabel.text = textString;
}
#pragma mark - 重新设置图标
- (void)setImageName:(NSString *)imageName{
    self.imageView.image = [UIImage imageNamed:imageName];
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

@implementation YTAlertViewManager

#pragma mark 创建伪单例，确保弹窗的唯一性
+ (YTAlertViewManager *)shareManager
{
    static YTAlertViewManager *shareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[YTAlertViewManager alloc]init];
        shareManager.alertView = [[YTAlertView alloc]init];
        [[UIApplication sharedApplication].keyWindow addSubview:shareManager.alertView];

    });
    return shareManager;
}

#pragma mark 显示弹窗
- (void)showWithType:(AlertViewType)type
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.alertView topAlertViewTypewWithType:type];
        if (self.topTxt) {
            self.alertView.textString = self.topTxt;
        }
        if (self.lefImageName){
            self.alertView.imageName = self.lefImageName;
        }
        [self.alertView show];
    });
}

#pragma mark - 移除弹窗
- (void)dismissAfterTime:(NSInteger)time
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.topTxt) {
                self.topTxt = nil;
            }
            if (self.lefImageName){
                self.lefImageName = nil;
            }
            
            [self.alertView dismiss];
        });
    });
}
@end
