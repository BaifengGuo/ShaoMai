//
//  BioGetDiseaseListAPI.m
//  BioMineModule
//
//  Created by mackBook on 2018/8/26.
//  Copyright © 2018年 BioMac. All rights reserved.
//

#import "BioGetDiseaseListAPI.h"

@implementation BioGetDiseaseListAPI
- (instancetype)initWithGetDiseaseListUserInfo:(NSDictionary *)userInfo{
    self = [super init];
    if (self) {
        _userInfo = userInfo;
        
    }
    return self;
    
}

- (instancetype)initWithSaveDiseasePragram:(NSDictionary *)params type:(NSString*)type{
    
    self = [super init];
    if (self) {
        _params = params;
        
    }
    return self;
}
- (NSString *)methodName{
   
       return @"ha/getDiseaseList";
  
}

- (NSUInteger)methodType{
   
       return BioAPIRequestMethodGET;
   
}

- (NSDictionary *)parameters{
   
        return self.userInfo;
   
}


@end
