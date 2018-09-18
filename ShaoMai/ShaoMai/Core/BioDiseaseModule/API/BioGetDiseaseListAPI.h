//
//  BioGetDiseaseListAPI.h
//  BioMineModule
//
//  Created by mackBook on 2018/8/26.
//  Copyright © 2018年 BioMac. All rights reserved.
//

#import "BioBaseAPI.h"
@interface BioGetDiseaseListAPI : BioBaseAPI

@property (nonatomic, strong) NSDictionary *userInfo;

//参数params
@property (nonatomic, strong) NSDictionary *params;
/**
 疾病名称数据获取

 @param userInfo 请求参数

 @return return value description
 */
- (instancetype)initWithGetDiseaseListUserInfo:(NSDictionary *)userInfo;

@end
