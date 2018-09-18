//
//  BioDiseaseTypeViewController.h
//  BioMineModule
//
//  Created by MacBook on 2018/9/3.
//  Copyright © 2018年 BioMac. All rights reserved.
//

#import "BioMineHealthHistoryCommonViewController.h"

typedef void(^DiseaseTypecodeBlock) (NSMutableArray* code ,NSString * remark);
@interface BioDiseaseTypeViewController : BioMineHealthHistoryCommonViewController
@property (nonatomic, strong) NSArray *selectDisease;
@property(nonatomic,copy) DiseaseTypecodeBlock backData;
@property (nonatomic, strong) NSString * remark;
@end
