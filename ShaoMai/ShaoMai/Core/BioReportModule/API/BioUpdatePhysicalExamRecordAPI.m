//
//  BioUpdatePhysicalExamRecordAPI.m
//  BioMineModule
//
//  Created by admin on 2018/8/30.
//  Copyright © 2018年 BioMac. All rights reserved.
//

#import "BioUpdatePhysicalExamRecordAPI.h"

@implementation BioUpdatePhysicalExamRecordAPI
- (instancetype)initWithUpdatePhysicalExamRecordParams:(NSDictionary *)params{
    self = [super init];
    if (self) {
        _params = params;
        
    }
    return self;
}
    
- (NSString *)methodName{
    
    return @"ha/updatePhysicalExamRecord";
    
}
    
- (NSUInteger)methodType{
    
    return BioAPIRequestMethodPUT;
    
}
    
- (NSDictionary *)parameters{
    return self.params;
}
@end
