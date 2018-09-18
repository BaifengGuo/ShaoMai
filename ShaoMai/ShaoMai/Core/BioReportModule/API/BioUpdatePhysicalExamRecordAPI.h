//
//  BioUpdatePhysicalExamRecordAPI.h
//  BioMineModule
//
//  Created by admin on 2018/8/30.
//  Copyright © 2018年 BioMac. All rights reserved.
//

#import "BioBaseAPI.h"

@interface BioUpdatePhysicalExamRecordAPI : BioBaseAPI
    @property (nonatomic, strong) NSDictionary *params;
- (instancetype)initWithUpdatePhysicalExamRecordParams:(NSDictionary *)params;
@end
