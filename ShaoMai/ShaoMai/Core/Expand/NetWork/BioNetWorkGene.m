//
//  BioNetWorkGene.m
//  BioMineModule
//
//  Created by admin on 2018/9/11.
//  Copyright © 2018年 BioMac. All rights reserved.
//

#import "BioNetWorkGene.h"
static NSMutableArray *_allSessionTask;
static AFHTTPSessionManager *_sessionManager;
@implementation BioNetWorkGene
/**
 *  json转字符串
 */
+ (NSString *)jsonToString:(id)data {
    if(data == nil) { return nil; }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

/**
 存储着所有的请求task数组
 */
+ (NSMutableArray *)allSessionTask {
    if (!_allSessionTask) {
        _allSessionTask = [[NSMutableArray alloc] init];
    }
    return _allSessionTask;
}

/**
 *  所有的HTTP请求共享一个AFHTTPSessionManager
 *  原理参考地址:http://www.jianshu.com/p/5969bbb4af9f
 */
+ (void)initialize {
    _sessionManager = [AFHTTPSessionManager manager];
    // 设置请求的超时时间
    _sessionManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    _sessionManager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    _sessionManager.requestSerializer.timeoutInterval = 30.f;
    // 设置服务器返回结果的类型:JSON (AFJSONResponseSerializer,AFHTTPResponseSerializer)
    [_sessionManager.requestSerializer setValue:@"" forHTTPHeaderField:@"If-None-Match"];
    _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*",@"text/encode", nil];
   
}


#pragma mark - GET请求无缓存
+ (NSURLSessionTask *)GET:(NSString *)URL parameters:(id)parameters success:(BIOHttpRequestSuccess)success failure:(BIOHttpRequestFailed)failure {
   
    NSURLSessionTask *sessionTask = [_sessionManager GET:URL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[self allSessionTask] removeObject:task];
        success ? success(responseObject) : nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       NSLog(@"error = %@",error);
        [[self allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
    }];
    // 添加sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    return sessionTask;
}
+ (__kindof NSURLSessionTask *)downloadWithURL:(NSString *)URL
                                       fileDir:(NSString *)fileDir
                                      progress:(BIOHttpProgress)progress
                                       success:(void(^)(NSString *filePath))success
                                       failure:(BIOHttpRequestFailed)failure{
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    __block NSURLSessionDownloadTask *downloadTask = [_sessionManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //下载进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(downloadProgress) : nil;
             NSLog(@"%f", 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        });
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //拼接缓存目录
        NSString *downloadDir = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileDir ? fileDir : @"Download"];
        //打开文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //创建Download目录
        [fileManager createDirectoryAtPath:downloadDir withIntermediateDirectories:YES attributes:nil error:nil];
        //拼接文件路径
        NSString *filePath = [downloadDir stringByAppendingPathComponent:response.suggestedFilename];
        //返回文件位置的URL路径
        return [NSURL fileURLWithPath:filePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        [[self allSessionTask] removeObject:downloadTask];
        if(failure && error) {failure(error) ; return ;};
        success ? success(filePath.absoluteString /** NSURL->NSString*/) : nil;
        
    }];
    //开始下载
    [downloadTask resume];
    // 添加sessionTask到数组
    downloadTask ? [[self allSessionTask] addObject:downloadTask] : nil ;
    return downloadTask;
    
}
+ (BOOL)isFileExist:(NSString *)fileName{
    //获取Documents 下的文件路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *filePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"/Download/%@",fileName]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:filePath];
    NSLog(@"这个文件已经：%@",result?@"存在":@"不存在");
    return result;
    
}
//清除文件里的内容
+(void)cleanDocument{

NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
NSString *cachesDir = [paths objectAtIndex:0];
//NSString *filePath = [cachesDir stringByAppendingPathComponent:[NSString stringWithFormat:@"/Download"]];
NSFileManager *fileManager=[NSFileManager defaultManager];
if ([fileManager fileExistsAtPath:cachesDir]) {
    NSArray *childerFiles=[fileManager subpathsAtPath:cachesDir];
    for (NSString *fileName in childerFiles) {
        //如有需要，加入条件，过滤掉不想删除的文件
        NSString *absolutePath=[cachesDir stringByAppendingPathComponent:fileName];
        [fileManager removeItemAtPath:absolutePath error:nil];
    }
}
}
@end
