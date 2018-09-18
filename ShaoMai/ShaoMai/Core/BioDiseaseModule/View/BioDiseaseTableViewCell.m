//
//  BioDiseaseTableViewCell.m
//  BioMineModule
//
//  Created by 郭百枫 on 2018/8/27.
//  Copyright © 2018年 BioMac. All rights reserved.
//

#import "BioDiseaseTableViewCell.h"

@implementation BioDiseaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.bgView.backgroundColor = [UIColor whiteColor];
        self.timeTitleLabel = [[UILabel alloc]init];
        self.timeTitleLabel.font = BioFont(14);
        [self.bgView addSubview:self.timeTitleLabel];
        
        self.timeLabel = [[UILabel alloc]init];
        self.timeLabel.font = BioFont(14);
        [self.bgView addSubview:self.timeLabel];
        
        self.nameTitleLabel = [[UILabel alloc]init];
        self.nameTitleLabel.font = BioFont(14);
        [self.bgView addSubview:self.nameTitleLabel];
        
        self.nameLabel = [[UILabel alloc]init];
        self.nameLabel.font = BioFont(14);
        [self.bgView addSubview:self.nameLabel];
        
        self.locationTitleLabel = [[UILabel alloc]init];
        self.locationTitleLabel.font = BioFont(14);
        [self.bgView addSubview:self.locationTitleLabel];
        
        self.locationLabel = [[UILabel alloc]init];
        self.locationLabel.font = BioFont(14);
        [self.bgView addSubview:self.locationLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.timeTitleLabel.frame = CGRectMake(BioW(10), BioH(10), BioW(70), BioH(30));
    self.nameTitleLabel.frame = CGRectMake(BioH(10), CGRectGetMaxY(self.timeTitleLabel.frame)+BioH(10), BioW(70), BioH(30));
    self.locationTitleLabel.frame = CGRectMake(BioH(10), CGRectGetMaxY(self.nameTitleLabel.frame)+BioH(10), BioW(70), BioH(30));
    
    self.timeLabel.frame = CGRectMake(CGRectGetMaxX(self.timeTitleLabel.frame), self.timeTitleLabel.y, self.bgView.width-BioW(30)-CGRectGetMaxX(self.timeTitleLabel.frame)-BioW(10), BioH(30));
    self.nameLabel.frame = CGRectMake(CGRectGetMaxX(self.nameTitleLabel.frame), self.nameTitleLabel.y, self.bgView.width-BioW(30)-CGRectGetMaxX(self.nameTitleLabel.frame)-BioW(10), BioH(30));
    self.locationLabel.frame = CGRectMake(CGRectGetMaxX(self.locationTitleLabel.frame), self.locationTitleLabel.y, self.bgView.width-BioW(30)-CGRectGetMaxX(self.locationTitleLabel.frame)-BioW(10), BioH(30));
}

@end
