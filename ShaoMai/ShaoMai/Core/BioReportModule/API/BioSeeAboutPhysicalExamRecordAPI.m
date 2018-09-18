//
//  BioSeeAboutPhysicalExamRecordAPI.m
//  BioMineModule
//
//  Created by admin on 2018/8/30.
//  Copyright © 2018年 BioMac. All rights reserved.
//

#import "BioSeeAboutPhysicalExamRecordAPI.h"

@implementation BioSeeAboutPhysicalExamRecordAPI
- (instancetype)initWithSeeAboutPhysicalExamRecordParams:(NSDictionary *)params{
    self = [super init];
    if (self) {
        _params = params;
        
    }
    return self;
}
    
- (NSString *)methodName{
    
    return @"ha/getPhysicalExamRecord";
    
}
    
- (NSUInteger)methodType{
    
    return BioAPIRequestMethodGET;
    
}
    
- (NSDictionary *)parameters{
    return self.params;
}
@end
