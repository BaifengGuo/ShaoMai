//
//  NSString+BioExtension.h
//  BioMineModule
//
//  Created by 郭百枫 on 2018/9/1.
//  Copyright © 2018年 BioMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (BioExtension)

/**
 将数组转换成需要的字符串

 @param ArrayAtring 待转换的数组
 @param key 字典转模型的key值
 @param format 转换成什么根式@“”or@“，”
 @return 返回字符串
 */
+(NSString*)componentsArrayToString:(NSArray*)ArrayAtring dictKey:(NSString*)key format:(NSString*)format;
@end
