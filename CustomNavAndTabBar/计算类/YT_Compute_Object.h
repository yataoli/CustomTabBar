//
//  YT_Compute_Object.h
//  NSDecimalNumberDemo
//
//  Created by 付宝网络 on 2018/3/8.
//  Copyright © 2018年 liyatao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YT_Compute_Object : NSObject
/**加法运算 例如：number1 + number2）*/
+ (NSString *)jiaFaWithNumber1Str:(NSString *)number1 AndNumber2Str:(NSString *)number2;

/**减法运算 例如：number1 - number2）*/
+ (NSString *)jianFaWithNumber1Str:(NSString *)number1 AndNumber2Str:(NSString *)number2;

/**乘法运算 例如：number1 * number2）*/
+ (NSString *)chengFaWithNumber1Str:(NSString *)number1 AndNumber2Str:(NSString *)number2;

/**除法运算 例如：number1 / number2）*/
+ (NSString *)chuFaWithNumber1Str:(NSString *)number1 AndNumber2Str:(NSString *)number2;
@end
