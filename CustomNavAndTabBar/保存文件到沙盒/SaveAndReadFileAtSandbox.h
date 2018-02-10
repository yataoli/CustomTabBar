//
//  SaveFileToSandbox.h
//  CustomNavAndTabBar
//
//  Created by 付宝网络 on 2018/2/10.
//  Copyright © 2018年 郑州鹿客互联网科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaveAndReadFileAtSandbox : NSObject
/**保存二进制数据到本地*/
+ (void)saveDataToSandbox:(NSData *)data;
/**读取二进制数据*/
+ (NSData *)readDataFromSandbox;
/**删除本地二进制数据*/
+ (BOOL)deleteDataAtSandbox;
@end

