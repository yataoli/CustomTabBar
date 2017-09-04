//
//  MeMessageModel.h
//  CustomNavAndTabBar
//
//  Created by suge on 2017/9/4.
//  Copyright © 2017年 郑州鹿客互联网科技有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface MeMessageModel : JSONModel
@property (nonatomic) NSInteger customerId;
@property (nonatomic,copy) NSString *headImg;
@property (nonatomic,copy) NSString *sign;
@property (nonatomic,copy) NSString *nickName;//昵称
@property (nonatomic,copy) NSString *password;
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *referrer;
@property (nonatomic) double wallet;//个人钱包里的钱
@property (nonatomic,copy) NSString *gender;//性别
@property (nonatomic,copy) NSArray *shoucang;//收藏的商品号
/**默认地址字典*/
@property (nonatomic,copy) NSDictionary *customerAddress;

@end
