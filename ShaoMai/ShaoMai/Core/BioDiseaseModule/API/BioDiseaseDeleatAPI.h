//
//  BioDiseaseDeleatAPI.h
//  BioMineModule
//
//  Created by admin on 2018/8/27.
//  Copyright © 2018年 BioMac. All rights reserved.
//

#import "BioBaseAPI.h"

@interface BioDiseaseDeleatAPI : BioBaseAPI
@property (nonatomic, strong) NSDictionary *parms;
-(instancetype)initWithDiseaseParams:(NSDictionary *)params;
@end
