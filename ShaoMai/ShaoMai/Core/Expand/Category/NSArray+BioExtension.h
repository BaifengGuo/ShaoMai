//
//  NSArray+BioExtension.h
//  BioMineModule
//
//  Created by admin on 2018/8/31.
//  Copyright © 2018年 BioMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (BioExtension)
    /**
     将数字字符串转换成数字类型数组
     
     @param string 待转换的数字字符串
     @return 返回组
     */
+ (NSArray*)componentsSeparatedByStringNSInter:(NSString*)string;
@end
