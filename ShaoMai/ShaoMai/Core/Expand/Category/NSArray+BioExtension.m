//
//  NSArray+BioExtension.m
//  BioMineModule
//
//  Created by admin on 2018/8/31.
//  Copyright © 2018年 BioMac. All rights reserved.
//

#import "NSArray+BioExtension.h"

@implementation NSArray (BioExtension)
+ (NSArray*)componentsSeparatedByStringNSInter:(NSString*)string{
    NSArray * CodeArry = [string componentsSeparatedByString:@","];
    NSMutableArray * codeArryInter = [NSMutableArray array];
    [CodeArry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [codeArryInter addObject:[NSNumber numberWithInteger: [obj integerValue]] ];
    }];
    return codeArryInter;
    
}
@end
