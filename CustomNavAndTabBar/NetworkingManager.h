//
//  NetworkingManager.h
//  LAFNetworking
//
//  Created by suge on 2017/7/1.
//  Copyright © 2017年 郑州鹿客互联网科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

/**请求方式枚举*/
typedef NS_ENUM(NSUInteger,HttpRquestType){
    /**GET请求*/
    HTTP_REQUEST_GET = 0,
    /**POST请求*/
    HTTP_REQUEST_POST,
};

/**请求数据格式枚举*/
typedef NS_ENUM(NSUInteger,HttpRequestSerializer) {
    /**请求数据（默认）为json格式*/
    HttpRequestSerializerJSON,
    /**请求数据为二进制数据*/
    HttpRequestSerializerData,
};



/**响应数据类型枚举*/
typedef NS_ENUM(NSUInteger,HttpResponseSerializer) {
    /**响应数据（默认）为json格式*/
    HttpResponseSerializerJSON = 0,
    /**响应数据为二进制数据*/
    HttpResponseSerializerData,
};

/**请求成功回调block*/
typedef void(^HttpRequetSuccess)(id responseObject);

/**请求失败回调block*/
typedef void(^HttpRequesError)(NSError *error);




@interface NetworkingManager : NSObject

/**创建单例类*/
+ (instancetype)shareManager;

///**是否显示hud*/
//@property (nonatomic) BOOL hasHud;

/**
 设置请求参数的格式（默认HttpRequestSerializerJSON）
 */
@property (nonatomic,assign) HttpRequestSerializer requestSerializer;

/**
 设置请求响应的格式（默认HttpResponseSerializerJSON）
 */
@property (nonatomic,assign) HttpResponseSerializer responseSerializer;

/**自定义请求头：httpHeaderField*/
@property(nonatomic, strong) NSDictionary *httpHeaderFieldDictionary;

/**请求超时时间（默认为30秒）*/
@property (nonatomic,assign) NSTimeInterval timeoutInterval;

/**
 *  统一网络请求
 *  @param type           请求类型（枚举类型）
 *  @param urlStr         请求URLString
 *  @param params         请求参数
 *  @param success        请求成功，数据回调
 *  @param errorBlock          请求失败，数据回调
 */
+ (void)requestType:(HttpRquestType)type urlString:(NSString *)urlStr parameters:(NSDictionary *)params successBlock:(HttpRequetSuccess)success failure:(HttpRequesError)errorBlock;


@end
