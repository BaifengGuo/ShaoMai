//
//  BioDelPhysicalExamRecordAPI.m
//  BioMineModule
//
//  Created by admin on 2018/8/30.
//  Copyright © 2018年 BioMac. All rights reserved.
//

#import "BioDelPhysicalExamRecordAPI.h"

@implementation BioDelPhysicalExamRecordAPI
- (instancetype)initWithDelPhysicalExamRecordParams:(NSDictionary *)params{
    self = [super init];
    if (self) {
        _params = params;
        
    }
    return self;
}
    
- (NSString *)methodName{
    
    return @"ha/delPhysicalExamRecord";
    
}
    
- (NSUInteger)methodType{
    
    return BioAPIRequestMethodDelete;
    
}
    
- (NSDictionary *)parameters{
    return self.params;
}
@end
