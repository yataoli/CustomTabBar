//
//  NetworkingManager.m
//  LAFNetworking
//
//  Created by suge on 2017/7/1.
//  Copyright © 2017年 郑州鹿客互联网科技有限公司. All rights reserved.
//

#import "NetworkingManager.h"

@interface NetworkingManager ()
@property (nonatomic,strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic,strong) MBProgressHUD *hud;
@end


@implementation NetworkingManager

/**创建单例类*/
+ (instancetype)shareManager{
    
    static NetworkingManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"shareManager");
        manager = [[NetworkingManager alloc] init];
    });
    return manager;
}

+ (void)initialize{
    
    NSLog(@"initialize");
    
    NetworkingManager *manager = [NetworkingManager shareManager];
    manager.sessionManager = [AFHTTPSessionManager manager];
    manager.requestSerializer = HttpRequestSerializerJSON;
    manager.responseSerializer = HttpResponseSerializerJSON;
    /*! 设置请求超时时间，默认：30秒 */
    manager.timeoutInterval = 30;
    
    manager.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/html",@"application/json", nil];

    // 配置自建证书的Https请求
    [self ba_setupSecurityPolicy];
}

/**
 配置自建证书的Https请求，只需要将CA证书文件放入根目录就行
 */
+ (void)ba_setupSecurityPolicy
{
    //    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
    NSSet <NSData *> *cerSet = [AFSecurityPolicy certificatesInBundle:[NSBundle mainBundle]];
    
    if (cerSet.count == 0)
    {
        /*!
         采用默认的defaultPolicy就可以了. AFN默认的securityPolicy就是它, 不必另写代码. AFSecurityPolicy类中会调用苹果security.framework的机制去自行验证本次请求服务端放回的证书是否是经过正规签名.
         */
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
        securityPolicy.allowInvalidCertificates = YES;
        securityPolicy.validatesDomainName = NO;
        [NetworkingManager shareManager].sessionManager.securityPolicy = securityPolicy;
    }else{
        /*! 自定义的CA证书配置如下： */
        /*! 自定义security policy, 先前确保你的自定义CA证书已放入工程Bundle */
        /*!
         https://api.github.com网址的证书实际上是正规CADigiCert签发的, 这里把Charles的CA根证书导入系统并设为信任后, 把Charles设为该网址的SSL Proxy (相当于"中间人"), 这样通过代理访问服务器返回将是由Charles伪CA签发的证书.
         */
        // 使用证书验证模式
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:cerSet];
        // 如果需要验证自建证书(无效证书)，需要设置为YES
        securityPolicy.allowInvalidCertificates = YES;
        // 是否需要验证域名，默认为YES
        //    securityPolicy.pinnedCertificates = [[NSSet alloc] initWithObjects:cerData, nil];
        
        
        [NetworkingManager shareManager].sessionManager.securityPolicy = securityPolicy;
        
        
        /*! 如果服务端使用的是正规CA签发的证书, 那么以下几行就可去掉: */
        //            NSSet <NSData *> *cerSet = [AFSecurityPolicy certificatesInBundle:[NSBundle mainBundle]];
        //            AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:cerSet];
        //            policy.allowInvalidCertificates = YES;
        //            BANetManagerShare.sessionManager.securityPolicy = policy;
    }
}

/**自定义请求头*/
- (void)setHttpHeaderFieldDictionary:(NSDictionary *)httpHeaderFieldDictionary{
    _httpHeaderFieldDictionary = httpHeaderFieldDictionary;
    if (![httpHeaderFieldDictionary isKindOfClass:[NSDictionary class]])
    {
        NSLog(@"请求头数据有误，请检查！");
        return;
    }
    NSArray *keyArray = httpHeaderFieldDictionary.allKeys;
    
    if (keyArray.count <= 0)
    {
        NSLog(@"请求头数据有误，请检查！");
        return;
    }
    
    for (NSInteger i = 0; i < keyArray.count; i ++)
    {
        NSString *keyString = keyArray[i];
        NSString *valueString = httpHeaderFieldDictionary[keyString];
        
        [NetworkingManager ba_setValue:valueString forHTTPHeaderKey:keyString];
    }

}
+ (void)ba_setValue:(NSString *)value forHTTPHeaderKey:(NSString *)HTTPHeaderKey
{
    [[NetworkingManager shareManager].sessionManager.requestSerializer setValue:value forHTTPHeaderField:HTTPHeaderKey];
}

/**
 设置请求参数的格式（默认HttpRequestSerializerJSON）
*/
- (void)setRequestSerializer:(HttpRequestSerializer)requestSerializer
{
    _requestSerializer = requestSerializer;
    switch (requestSerializer) {
        case HttpRequestSerializerJSON:
        {
            [NetworkingManager shareManager].sessionManager.requestSerializer = [AFJSONRequestSerializer serializer] ;
        }
            break;
        case HttpRequestSerializerData:
        {
            [NetworkingManager shareManager].sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer] ;
        }
            break;
            
        default:
            break;
    }
}
/**
 设置请求响应的格式（默认HttpResponseSerializerJSON）
 */
- (void)setResponseSerializer:(HttpResponseSerializer)responseSerializer
{
    _responseSerializer = responseSerializer;
    switch (responseSerializer) {
        case HttpResponseSerializerJSON:
        {
            [NetworkingManager shareManager].sessionManager.responseSerializer = [AFJSONResponseSerializer serializer] ;
        }
            break;
        case HttpResponseSerializerData:
        {
            [NetworkingManager shareManager].sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer] ;
        }
            break;
            
        default:
            break;
    }
}

/**请求超时时间（默认为30秒）*/
- (void)setTimeoutInterval:(NSTimeInterval)timeoutInterval{
    _timeoutInterval = timeoutInterval;
    [NetworkingManager shareManager].sessionManager.requestSerializer.timeoutInterval = _timeoutInterval;
}
/**统一网络请求*/
+ (void)requestType:(HttpRquestType)type urlString:(NSString *)urlStr parameters:(NSDictionary *)params successBlock:(HttpRequetSuccess)success failure:(HttpRequesError)errorBlock{
    
    /*! 检查地址中是否有中文 */
    NSString *URLString = [NSURL URLWithString:urlStr] ? urlStr : [self strUTF8Encoding:urlStr];
    
    switch (type) {
        case HTTP_REQUEST_GET:{
            [[NetworkingManager shareManager].sessionManager GET:URLString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success){
                    success(responseObject);
                }
                
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (errorBlock)
                {
                    errorBlock(error);
                }
            }];
        }
            
            break;
        case HTTP_REQUEST_POST:{
            
            [[NetworkingManager shareManager].sessionManager POST:URLString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                
            } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success){
                    success(responseObject);
                }

            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (errorBlock){
                    errorBlock(error);
                }

            }];
            
            
            
        }
            break;
    }
    
}
#pragma mark - url 中文格式化
+ (NSString *)strUTF8Encoding:(NSString *)str
{
    /*! ios9适配的话 打开第一个 */
    if ([[UIDevice currentDevice] systemVersion].floatValue >= 9.0)
    {
        return [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
    }else{
        return [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
}
@end
