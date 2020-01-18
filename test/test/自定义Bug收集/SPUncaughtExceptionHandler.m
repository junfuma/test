//
//  SPUncaughtExceptionHandler.m
//  AvoidCrashDemo
//
//  Created by Simple_Code on 2018/9/4.
//  Copyright © 2018年 chenfanfang. All rights reserved.
//

#import "SPUncaughtExceptionHandler.h"
#import <UIKit/UIDevice.h>
// 沙盒的地址
NSString * applicationDocumentsDirectory() {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

// 崩溃时的回调函数
void UncaughtExceptionHandler(NSException * exception) {
    NSLog(@"%s",__func__);
    
    NSArray * arr = [exception callStackSymbols];
    NSString * reason = [exception reason]; // // 崩溃的原因  可以有崩溃的原因(数组越界,字典nil,调用未知方法...) 崩溃的控制器以及方法
    NSString * name = [exception name];
    
    NSString *phoneName = [UIDevice currentDevice].name;
    NSString *appVersion =  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *systemName = [UIDevice currentDevice].systemName;
    NSString *systemVersion = [UIDevice currentDevice].systemVersion;
    NSArray *languageArray = [NSLocale preferredLanguages];
  
    NSString *Phonelanguage =[languageArray objectAtIndex:0];
   
    NSString * url = [NSString stringWithFormat:@"========异常错误报告========\nname:%@\nreason:\n%@\ncallStackSymbols:\n%@",name,reason,[arr componentsJoinedByString:@"\n"]];
    NSString * path = [applicationDocumentsDirectory() stringByAppendingPathComponent:@"Exception.txt"];
    NSLog(@"文件地址--%@",path);
    // 将一个txt文件写入沙盒
    [url writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];

    
    
    
        NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"AlexExceptionHanderFile"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
        NSTimeInterval a = [dat timeIntervalSince1970];
        NSString *timeStr = [NSString stringWithFormat:@"%f",a];
        NSString *savePath = [filePath stringByAppendingFormat:@"/error%@.log",timeStr];
    NSString*exceptionInfo=  [NSString stringWithFormat:@"========异常错误报告========\n手机名称%@\nAPP的版本:%@\n系统版本:%@\n系统名称:%@\n手机语言:%@\nname:%@\nreason:\n%@\ncallStackSymbols:\n%@",phoneName,appVersion,systemVersion,systemName,Phonelanguage,name,reason,[arr componentsJoinedByString:@"\n"]];
     BOOL success  =  [exceptionInfo writeToFile:savePath atomically:YES encoding:NSUTF8StringEncoding error:nil];

    if (success) {
         NSLog(@"保存奔溃日志:%@",savePath);
    }
        
            [[[SPUncaughtExceptionHandler alloc]init] takeException:exception];
}

@implementation SPUncaughtExceptionHandler
+ (instancetype)shareInstance {
    static SPUncaughtExceptionHandler *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SPUncaughtExceptionHandler alloc]init];
    });
    return instance;
}
- (void)setDefaultHandler {
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
    [self collectionExceptionMessage];
}
// 获取崩溃统计的函数指针
- (NSUncaughtExceptionHandler *)getHandler {
    return NSGetUncaughtExceptionHandler();
}
- (void)takeException:(NSException *)exception {
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:[exception userInfo]];
    NSArray *arr = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    NSString *url = [NSString stringWithFormat:@"========异常错误报告========\nname:%@\nreason:\n%@\ncallStackSymbols:\n%@",name,reason,[arr componentsJoinedByString:@"\n"]];
    NSString *path = [applicationDocumentsDirectory() stringByAppendingPathComponent:@"Exception.txt"];
    [url writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    
    [[[SPUncaughtExceptionHandler alloc] init] performSelectorOnMainThread:@selector(lg_handException:) withObject:[NSException exceptionWithName:[exception name] reason:[exception reason] userInfo:userInfo] waitUntilDone:YES];
}
- (void)collectionExceptionMessage {
    // 发送崩溃日志
    NSString *dataPath = [applicationDocumentsDirectory() stringByAppendingPathComponent:@"Exception.txt"];
    NSData *data = [NSData dataWithContentsOfFile:dataPath];
    if (data != nil) {
        [self sendExceptionLogWithData:data path:dataPath];
    }
}
- (void)lg_handException:(NSException *)exception{
    
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
    CFArrayRef allModels = CFRunLoopCopyAllModes(runloop);
//    self.dismissed = YES;
    while (!self.dismissed) {
        for (NSString* model in (__bridge NSArray*)allModels) {
            CFRunLoopRunInMode((CFStringRef) model, 0.001, false);
        }
    }
    CFRelease(allModels);
}
#pragma mark -- 发送崩溃日志
- (void)sendExceptionLogWithData:(NSData *)data path:(NSString *)path {
    
    /*
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 5.0f;
    //告诉AFN，支持接受 text/xml 的数据
    [AFJSONResponseSerializer serializer].acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    NSString *urlString = @"后台地址";
    [manager POST:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:@"file" fileName:@"Exception.txt" mimeType:@"txt"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 删除文件
        NSFileManager *fileManger = [NSFileManager defaultManager];
        [fileManger removeItemAtPath:path error:nil];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 发送Bug失败
    }];
    */
}


@end
