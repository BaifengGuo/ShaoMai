//
//  BioMineReportModel.h
//  BioEhealth
//
//  Created by MacBook on 17/3/28.
//  Copyright © 2017年 LouKit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BioMineReportModel : NSObject
@property (nonatomic, strong) NSString *physicalExamReportId;//体检报告表记录ID
    @property (nonatomic, assign) long  physicalExamDate;  //体检时间
@property (nonatomic, assign) long creationDate;
@property (nonatomic, strong) NSString *createUserName;
@property (nonatomic, strong) NSString *createdUserId;
@property (nonatomic, strong) NSString *hosptializeTime;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSString *physicalExamOrgName; //体检机构
@property (nonatomic, strong) NSArray *filePath;
//@property (nonatomic, strong) NSString *hospital;

@end
