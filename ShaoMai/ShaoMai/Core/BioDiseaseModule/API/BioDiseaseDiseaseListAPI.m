//
//  BioDiseaseDiseaseListAPI.m
//  BioMineModule
//
//  Created by MacBook on 2018/9/3.
//  Copyright © 2018年 BioMac. All rights reserved.
//

#import "BioDiseaseDiseaseListAPI.h"

@implementation BioDiseaseDiseaseListAPI

- (NSUInteger)methodType{
    return BioAPIRequestMethodGET;
}

- (NSString *)methodName{
    return @"ha/getDiseaseList";
}
@end
