//
//  LoginViewModel.h
//  CustomNavAndTabBar
//
//  Created by suge on 2017/9/4.
//  Copyright © 2017年 郑州鹿客互联网科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MeMessageModel.h"
@interface LoginViewModel : NSObject
@property (nonatomic,strong) NSString *phoneString;
@property (nonatomic,strong) NSString *passwordString;
@property (nonatomic) BOOL loginClick;
@property (nonatomic,strong) NSMutableArray *dataSource;

// 用户登录 为了减少View对viewModel的状态的监听 这里采用block回调来减少状态的处理
- (void)loginSuccess:(void(^)(id json))success fail:(void(^)(NSError *error))fail;


@end
