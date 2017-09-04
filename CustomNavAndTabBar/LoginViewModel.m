//
//  LoginViewModel.m
//  CustomNavAndTabBar
//
//  Created by suge on 2017/9/4.
//  Copyright © 2017年 郑州鹿客互联网科技有限公司. All rights reserved.
//

#import "LoginViewModel.h"

@implementation LoginViewModel
- (void)loginSuccess:(void (^)(id))success fail:(void (^)(NSError *))fail{
    NSDictionary *jiaMiDic = @{@"phone":_phoneString,@"password":_passwordString} ;
    
    NSString *accountJsonString = [NSString DicToJsonStringWithDic:jiaMiDic];
    
    NSString *jiaMiData = aesEncryptString(accountJsonString, passwordKey);
    
    NSDictionary *dic = @{@"account":jiaMiData } ;
    [NetworkingManager requestType:HTTP_REQUEST_POST urlString:@"http://139.129.245.200:80/bulu/customer/login" parameters:dic successBlock:^(id responseObject) {
        
        if ([responseObject[@"status"] intValue] == 0) {
            MeMessageModel *model = [[MeMessageModel alloc] initWithDictionary:responseObject[@"data"] error:nil];
            [self.dataSource addObject:model];
        }
        success(responseObject);
    } failure:^(NSError *error) {
        fail(error);
    }];
}
- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _dataSource;
}
@end
