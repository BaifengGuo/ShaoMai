//
//  BioDiseaseSeeAbout.m
//  BioMineModule
//
//  Created by 郭百枫 on 2018/8/26.
//  Copyright © 2018年 BioMac. All rights reserved.
//

#import "BioDiseaseSeeAboutAPI.h"

@implementation BioDiseaseSeeAboutAPI
-(instancetype)initWithDiseaseParams:(NSDictionary *)params{
    
    self =  [super init];
    if (self) {
        _params = params;
        
    }
    return self;
}



- (NSString *)methodName{
    
        return @"ha/getPastMedicalRecord";
   
}

- (NSUInteger)methodType{
    
        return BioAPIRequestMethodGET;
   
}

- (NSDictionary *)parameters{
    return self.params;
}

@end
