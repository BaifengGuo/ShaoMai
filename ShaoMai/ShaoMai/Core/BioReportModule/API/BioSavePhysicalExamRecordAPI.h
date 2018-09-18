//
//  BioSavePhysicalExamRecordAPI.h
//  BioMineModule
//
//  Created by admin on 2018/8/30.
//  Copyright © 2018年 BioMac. All rights reserved.
//

#import "BioBaseAPI.h"

@interface BioSavePhysicalExamRecordAPI : BioBaseAPI
@property (nonatomic, strong) NSDictionary *params;
- (instancetype)initWithSavePhysicalExamRecordParams:(NSDictionary *)params;
@end
