//
//  BioSavePhysicalExamRecordAPI.m
//  BioMineModule
//
//  Created by admin on 2018/8/30.
//  Copyright © 2018年 BioMac. All rights reserved.
//

#import "BioSavePhysicalExamRecordAPI.h"

@implementation BioSavePhysicalExamRecordAPI
- (instancetype)initWithSavePhysicalExamRecordParams:(NSDictionary *)params{
    self = [super init];
    if (self) {
        _params = params;
        
    }
    return self;
}
    
- (NSString *)methodName{
        
        return @"ha/savePhysicalExamRecord";
        
    }
    
- (NSUInteger)methodType{
    
    return BioAPIRequestMethodPOST;
    
}
    
- (NSDictionary *)parameters{
    return self.params;
}
@end
