//
//  BioDiseaseSeeAboutAPI.h
//  BioMineModule
//
//  Created by 郭百枫 on 2018/8/26.
//  Copyright © 2018年 BioMac. All rights reserved.
//

#import "BioBaseAPI.h"

@interface BioDiseaseSeeAboutAPI : BioBaseAPI

//参数params
@property (nonatomic, strong) NSDictionary *params;

/**
 既往病史查询或删除

 @param params 需要传的的参数
 @return return value description
 */
- (instancetype)initWithDiseaseParams:(NSDictionary *)params;
@end
