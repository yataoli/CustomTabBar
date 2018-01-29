//
//  ZAlertView.h
//  顶部提示
//
//  Created by YYKit on 2017/5/27.
//  Copyright © 2017年 YZ. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_OPTIONS (NSInteger ,AlertViewType){
    /**顶部成功提示*/
    AlertViewTypeSuccess = 0,
    /**顶部错误提示*/
    AlertViewTypeError   = 1,
    /**顶部无网络提示*/
    AlertViewTypeNoNetwork = 2
};

@interface YTAlertView : UIView

@property (nonatomic,assign) AlertViewType alertViewType;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel     *tipsLabel;
- (instancetype)init;
- (void)topAlertViewTypewWithType:(AlertViewType)type;
- (void)show;
- (void)dismiss;
@end
