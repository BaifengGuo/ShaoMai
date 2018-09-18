//
//  BioDiseeaseUpdateAPI.h
//  BioMineModule
//
//  Created by admin on 2018/8/27.
//  Copyright © 2018年 BioMac. All rights reserved.
//

#import "BioBaseAPI.h"

@interface BioDiseeaseUpdateAPI : BioBaseAPI

@property (nonatomic, strong) NSDictionary *params;

/**
 请求保存记录还是更新数据
 
 @param params 传递的参数
 @return return value description
 */
- (instancetype)initWithDiseaseUpdateParams:(NSDictionary *)params;
@end
