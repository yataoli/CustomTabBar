//
//  NSString+Category.h
//  SugeiOS
//
//  Created by suge on 2016/12/5.
//  Copyright © 2016年 素格. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Category)
//计算字符串空间大小
- (CGRect)rectWithStringBoundingSize:(CGSize )stringSize withStringFont:(UIFont *)font;
//时间戳字符串转化为时间
-(NSString *)timeStampToTimeString;

//MD5加密
-(NSString *)md5;
//获取令牌
+ (NSString *)getLingPaiWithTimeInterval:(NSString *)timeInterval;
//获取时间戳
+ (NSString *)getTimeInterval;

/**把字典转换成JSON格式字符串*/
+ (NSString *)DicToJsonStringWithDic:(NSDictionary *)dic ;

/**正则匹配手机号码*/
- (BOOL)checkTelNumber;
/**
 *  检查 密码是否是 6-20 数字密码
 */
- (BOOL)checkPassWord;
/**正则匹配用户身份证号 15 或 18 位*/
- (BOOL)checkUserIdCard;

/**
 *正则匹配URL    
 */
- (BOOL)isUrlString;

// 非空判断
+(BOOL)isNULL:(id)string;


//把指定时间转化为时间戳
+ (NSString *)getTimeIntervalWithDate:(NSDate *)date;

//把指定时间戳（秒）转化为指定格式 （yyyy-MM-dd HH:mm）
+ (NSString *)getTime:(NSString *)getTimeStr withFormate:(NSString *)timeFormate;


/**获取设备型号*/
+ (NSString*)deviceVersion;

/**
 *把时间字符串转化为刚刚、3分钟前、几小时前。。（后台返回的时间格式 2017-10-07 11:30:10）
 */
- (NSString *)changeTimeToSecMinHoursDay;
@end
