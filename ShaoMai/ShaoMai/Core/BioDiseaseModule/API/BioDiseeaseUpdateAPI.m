//
//  BioDiseeaseUpdateAPI.m
//  BioMineModule
//
//  Created by admin on 2018/8/27.
//  Copyright © 2018年 BioMac. All rights reserved.
//

#import "BioDiseeaseUpdateAPI.h"

@implementation BioDiseeaseUpdateAPI
-(instancetype)initWithDiseaseUpdateParams:(NSDictionary *)params {
    
    self =  [super init];
    if (self) {
        _params = params;
        
    }
    return self;
}

- (NSString *)methodName{
    
    return @"ha/updatePastMedicalRecord";
}

- (NSUInteger)methodType{
    
    return BioAPIRequestMethodPUT;
}

- (NSDictionary *)parameters{
    return self.params;
}

@end
