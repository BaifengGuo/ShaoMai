//
//  BioAddReportViewController.h
//  BioEhealth
//
//  Created by MacBook on 17/3/29.
//  Copyright © 2017年 LouKit. All rights reserved.
//

#import "BioMineHealthHistoryCommonViewController.h"
#import "BioMineReportModel.h"

@protocol BioAddReportViewControllerDelegate <NSObject>
- (void)reportInfoSaveSucceed;
@end

@interface BioAddReportViewController : BioMineHealthHistoryCommonViewController
@property (nonatomic, strong) BioMineReportModel *model;
@property (nonatomic, weak) id<BioAddReportViewControllerDelegate> delegate;
@end
