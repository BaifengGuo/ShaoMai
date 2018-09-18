//
//  BioDiseaseTableViewCell.h
//  BioMineModule
//
//  Created by 郭百枫 on 2018/8/27.
//  Copyright © 2018年 BioMac. All rights reserved.
//

#import "BioMineCommonCell.h"

@interface BioDiseaseTableViewCell : BioMineCommonCell
@property (nonatomic, strong) UILabel *timeTitleLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *nameTitleLabel;
@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *locationTitleLabel;
@property (nonatomic, strong) UILabel *locationLabel;
@end
