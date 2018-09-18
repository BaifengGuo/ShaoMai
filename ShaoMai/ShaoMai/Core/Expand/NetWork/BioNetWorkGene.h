//
//  BioNetWorkGene.h
//  BioMineModule
//
//  Created by admin on 2018/9/11.
//  Copyright © 2018年 BioMac. All rights reserved.
//

#import <Foundation/Foundation.h>
/** 请求成Block */

/**
 通用callBack
 
 @param success 接口是否请求成功
 @param responseObject 返回数据
 @param error 错误信息
 */
typedef void(^BIOHttpRequestCallBack)(BOOL success,id responseObject,NSError *error);

/** 请求成功的Block */
typedef void(^BIOHttpRequestSuccess)(id responseObject);

/** 请求失败的Block */
typedef void(^BIOHttpRequestFailed)(NSError *error);

/** 缓存的Block */
typedef void(^BIOHttpRequestCache)(id responseCache);
/** 上传或者下载的进度, Progress.completedUnitCount:当前大小 - Progress.totalUnitCount:总大小*/
typedef void (^BIOHttpProgress)(NSProgress *progress);



@interface BioNetWorkGene : NSObject
/**
 *  GET请求,无缓存
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *)GET:(NSString *)URL
                        parameters:(id)parameters
                           success:(BIOHttpRequestSuccess)success
                           failure:(BIOHttpRequestFailed)failure;



/**
 *  下载文件
 *
 *  @param URL      请求地址
 *  @param fileDir  文件存储目录(默认存储目录为Download)
 *  @param progress 文件下载的进度信息
 *  @param success  下载成功的回调(回调参数filePath:文件的路径)
 *  @param failure  下载失败的回调
 *
 *  @return 返回NSURLSessionDownloadTask实例，可用于暂停继续，暂停调用suspend方法，开始下载调用resume方法
 */

+ (__kindof NSURLSessionTask *)downloadWithURL:(NSString *)URL
                                       fileDir:(NSString *)fileDir
                                      progress:(BIOHttpProgress)progress
                                       success:(void(^)(NSString *filePath))success
                                       failure:(BIOHttpRequestFailed)failure;
#pragma mark  第二步    判断沙盒中是否存在此文件
+ (BOOL)isFileExist:(NSString *)fileName;


/**
 清除缓存
 */
+(void)cleanDocument;

@end
