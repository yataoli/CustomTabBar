//
//  ZAlertViewManager.h
//  顶部提示
//
//  Created by YYKit on 2017/5/27.
//  Copyright © 2017年 YZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "YTAlertView.h"

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

- (void)topAlertViewTypewWithType:(AlertViewType)type;
- (void)show;
- (void)dismiss;
@end




@interface YTAlertViewManager : NSObject
@property (nonatomic,strong)YTAlertView *alertView;
+ (YTAlertViewManager *)shareManager;
//文字
@property (nonatomic,strong) NSString * topTxt;
//图片
@property (nonatomic,strong) NSString * lefImageName;
/**显示顶部弹窗*/
- (void)showWithType:(AlertViewType)type;
/**在几秒后移除顶部弹窗*/
- (void)dismissAfterTime:(NSInteger)time;
@end





