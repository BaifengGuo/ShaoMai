//
//  BioAddDiseaseViewController.h
//  BioEhealth
//
//  Created by MacBook on 17/4/5.
//  Copyright © 2017年 LouKit. All rights reserved.
//

#import "BioMineHealthHistoryCommonViewController.h"
#import "BioMineDiseaseModel.h"

@protocol BioAddDiseaseViewControllerDelegate <NSObject>
- (void)diseaseInfoSaveSucceed;
@end

@interface BioAddDiseaseViewController : BioMineHealthHistoryCommonViewController
@property (nonatomic, strong) BioMineDiseaseModel *model;
@property (nonatomic, weak) id<BioAddDiseaseViewControllerDelegate> delegate;
@end
