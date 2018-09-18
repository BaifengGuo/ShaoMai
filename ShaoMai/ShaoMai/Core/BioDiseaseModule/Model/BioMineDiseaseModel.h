//
//  BioMineDiseaseModel.h
//  BioEhealth
//
//  Created by MacBook on 17/3/30.
//  Copyright © 2017年 LouKit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BioMineDiseaseModel : NSObject
@property (nonatomic, strong) NSString *pastMedicalHistoryId;//既往病记录ID
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, assign) long creationDate;
@property (nonatomic, strong) NSString *createUserName;
@property (nonatomic, strong) NSString *createdUserId;
@property (nonatomic, assign) long diagnosisTime;
@property(nonatomic,strong) NSMutableArray *disease;
@property (nonatomic, copy) NSArray *filePath;
@property (nonatomic, strong) NSString *remark;

@property (nonatomic, strong) NSString *illnessName;

@property (nonatomic, strong) NSString *hospitalName;
@property (nonatomic, strong) NSString *diseaseName;
@property (nonatomic, strong) NSString *illAge;
@property (nonatomic, strong) NSString *otherDisease;
@property (nonatomic, strong) NSString *diseaseCode;
@end
