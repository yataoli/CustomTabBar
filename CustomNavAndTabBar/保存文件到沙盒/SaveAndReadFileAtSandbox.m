//
//  SaveFileToSandbox.m
//  CustomNavAndTabBar
//
//  Created by 付宝网络 on 2018/2/10.
//  Copyright © 2018年 郑州鹿客互联网科技有限公司. All rights reserved.
//

#import "SaveAndReadFileAtSandbox.h"

@implementation SaveAndReadFileAtSandbox
//创建文件夹
- (void)createFile{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSString *pathDocument = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [NSString stringWithFormat:@"%@/Sandbox",pathDocument];
    //判断文件夹是否存在，如果不存在就创建
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    }else{
        NSLog(@"文件夹已经存在");
    }
}
#pragma mark - 保存二进制数据到沙盒指定文件夹
+ (void)saveDataToSandbox:(NSData *)data{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSString *pathDocument = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [NSString stringWithFormat:@"%@/Sandbox",pathDocument];
    //判断文件夹是否存在，如果不存在就创建
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    }else{
        NSLog(@"文件夹已经存在");
    }
    NSString *datafilePath = [filePath stringByAppendingPathComponent:@"data.txt"];
    BOOL isWriteSuccess = [data writeToFile:datafilePath atomically:YES];
    if (isWriteSuccess) {
        NSLog(@"写入成功");
    } else {
        
        NSLog(@"写入失败");
    }
}
#pragma mark - 从沙盒指定文件夹读取二进制数据
+ (NSData *)readDataFromSandbox{
    
    NSString *pathDocument = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [NSString stringWithFormat:@"%@/Sandbox",pathDocument];
    NSError *error = nil;
    NSData * data = [NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.txt",filePath,@"data"] options:NSUTF8StringEncoding error:&error];
    if (error != nil){
        NSLog(@"读取数据错误信息%@", [error localizedDescription]);//将错误信息输出来
        return nil;
    }else{
        return data;
    }
    
}
#pragma mark - 删除沙盒指定文件加数据
+ (BOOL)deleteDataAtSandbox{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSString *pathDocument = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [NSString stringWithFormat:@"%@/Sandbox",pathDocument];
    BOOL deleteStatus = [fileManager removeItemAtPath:filePath error:nil];
    return deleteStatus;
    
    
}
@end

