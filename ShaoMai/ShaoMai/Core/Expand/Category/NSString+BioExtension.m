//
//  NSString+BioExtension.m
//  BioMineModule
//
//  Created by 郭百枫 on 2018/9/1.
//  Copyright © 2018年 BioMac. All rights reserved.
//

#import "NSString+BioExtension.h"

@implementation NSString (BioExtension)

+(NSString*)componentsArrayToString:(NSArray*)ArrayAtring dictKey:(NSString*)key format:(NSString*)format{
NSMutableArray * Arry = [NSMutableArray array];
[ArrayAtring enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    [Arry addObject:[obj objectForKey:key]];
}];
    return   [Arry componentsJoinedByString:format];
    
    
}
@end
