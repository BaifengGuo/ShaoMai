//
//  BioDiseaseSaveAPI.m
//  BioMineModule
//
//  Created by admin on 2018/8/27.
//  Copyright © 2018年 BioMac. All rights reserved.
//

#import "BioDiseaseSaveAPI.h"

@implementation BioDiseaseSaveAPI
-(instancetype)initWithDiseaseParams:(NSDictionary *)params{
    
    self =  [super init];
    if (self) {
        _params = params;
        
    }
    return self;
}

- (NSString *)methodName{
   
        return @"ha/savePastMedicalRecord";
   
}

- (NSUInteger)methodType{
   
        return BioAPIRequestMethodPOST;
   
}

- (NSDictionary *)parameters{
    return self.params;
}

@end
