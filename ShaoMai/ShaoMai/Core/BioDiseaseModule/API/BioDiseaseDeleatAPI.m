//
//  BioDiseaseDeleatAPI.m
//  BioMineModule
//
//  Created by admin on 2018/8/27.
//  Copyright © 2018年 BioMac. All rights reserved.
//

#import "BioDiseaseDeleatAPI.h"

@implementation BioDiseaseDeleatAPI


-(instancetype)initWithDiseaseParams:(NSDictionary *)params{
    
    self =  [super init];
    if (self) {
        _parms = params;
        
    }
    return self;
}





- (NSString *)methodName{
    return @"ha/delPastMedicalRecord";
}

- (NSUInteger)methodType{
    return BioAPIRequestMethodDelete;
}

- (NSDictionary *)parameters{
    return _parms;
}

@end
