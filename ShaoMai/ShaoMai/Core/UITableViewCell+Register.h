//
//  UITableViewCell+Register.h
//  BioCategory
//
//  Created by MacBook on 2018/5/29.
//  Copyright © 2018年 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (Register)

+ (void)registerWithTableView:(UITableView *)tableView;

+ (instancetype)cellWithTableView:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath;

@end
