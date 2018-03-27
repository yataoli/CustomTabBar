//
//  YT_PagingView.h
//  YTPageingView
//
//  Created by 付宝网络 on 2018/3/27.
//  Copyright © 2018年 liyatao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YT_PagingViewDelegate <NSObject>

@optional
- (void)pageTitleSelecteIndex:(NSInteger)index andTitle:(NSString *)title;
@end

@interface YT_PagingView : UIView
- (instancetype)initWithFrame:(CGRect)frame titleNames:(NSArray *)titleNames;
@property (nonatomic,weak) id <YT_PagingViewDelegate> delegate;
@end


