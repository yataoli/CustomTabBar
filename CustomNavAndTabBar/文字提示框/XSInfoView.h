//
//  XSInfoView.m
//  XSInfoView
//
//  Created by Liwenqiang on 16/11/16.
//  Copyright © 2016年 李文强. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XSInfoViewLayoutStyle) {
    XSInfoViewLayoutStyleVertical = 0,
    XSInfoViewLayoutStyleHorizontal
};

@interface XSInfoViewStyle : NSObject

@property (strong, nonatomic) UIColor *backgroundColor;
@property (strong, nonatomic) UIViewController * homeVC;
@property (strong, nonatomic) UIImage *image;
@property (assign, nonatomic) CGSize imageSize;

@property (strong, nonatomic) NSString *info;
@property (assign, nonatomic) CGFloat fontSize;
@property (strong, nonatomic) UIColor *textColor
;
@property (assign, nonatomic) CGFloat maxLabelWidth;

@property (assign, nonatomic) NSInteger durationSeconds;

@property (assign, nonatomic) XSInfoViewLayoutStyle layoutStyle;

@end

@interface XSInfoView : UIView

@property (strong, nonatomic) UILabel *infoLabel;
@property (strong, nonatomic) UIImageView *infoImageView;
@property (nonatomic, assign) CGFloat W;
@property (nonatomic, strong) UIViewController * myVC;

+ (void)showInfo:(NSString *)info onView:(UIViewController *)superView;
+ (void)showInfoWithStyle:(XSInfoViewStyle *)style onView:(UIView *)superView;
- (void)showView:(NSString *)info onView:(UIViewController *)superView;
- (void)showDismiss;
- (void)addCenterCons;
@end
