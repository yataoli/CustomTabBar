//
//  YT_Compute_Object.m
//  NSDecimalNumberDemo
//
//  Created by 付宝网络 on 2018/3/8.
//  Copyright © 2018年 liyatao. All rights reserved.
//

#import "YT_Compute_Object.h"

@implementation YT_Compute_Object
/**number1 + number2*/
+ (NSString *)jiaFaWithNumber1Str:(NSString *)number1 AndNumber2Str:(NSString *)number2{
    NSDecimalNumber*jiafa1 = [NSDecimalNumber decimalNumberWithString:number1];
    
    NSDecimalNumber*jiafa2 = [NSDecimalNumber decimalNumberWithString:number2];
    //加法运算函数
    NSDecimalNumber*jiafa
    = [jiafa1 decimalNumberByAdding:jiafa2];
    return [NSString stringWithFormat:@"%@",jiafa];
}
/**减法运算 例如：number1 - number2）*/
+ (NSString *)jianFaWithNumber1Str:(NSString *)number1 AndNumber2Str:(NSString *)number2{
    NSDecimalNumber*jiafa1 = [NSDecimalNumber decimalNumberWithString:number1];
    
    NSDecimalNumber*jiafa2 = [NSDecimalNumber decimalNumberWithString:number2];
    //减法运算函数
    NSDecimalNumber*jiafa
    = [jiafa1 decimalNumberBySubtracting:jiafa2];
    return [NSString stringWithFormat:@"%@",jiafa];
}
/**乘法运算 例如：number1 - number2）*/
+ (NSString *)chengFaWithNumber1Str:(NSString *)number1 AndNumber2Str:(NSString *)number2{
    NSDecimalNumber*jiafa1 = [NSDecimalNumber decimalNumberWithString:number1];
    
    NSDecimalNumber*jiafa2 = [NSDecimalNumber decimalNumberWithString:number2];
    //乘法运算函数
    NSDecimalNumber*jiafa
    = [jiafa1 decimalNumberByMultiplyingBy:jiafa2];
    return [NSString stringWithFormat:@"%@",jiafa];
}
/**除法运算 例如：number1 / number2）*/
+ (NSString *)chuFaWithNumber1Str:(NSString *)number1 AndNumber2Str:(NSString *)number2{
    NSDecimalNumber*jiafa1 = [NSDecimalNumber decimalNumberWithString:number1];
    
    NSDecimalNumber*jiafa2 = [NSDecimalNumber decimalNumberWithString:number2];
    //除法运算函数
    NSDecimalNumber*jiafa
    = [jiafa1 decimalNumberByDividingBy:jiafa2];
    return [NSString stringWithFormat:@"%@",jiafa];
}

@end
