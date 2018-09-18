//
//  UITableViewCell+Register.m
//  BioCategory
//
//  Created by MacBook on 2018/5/29.
//  Copyright © 2018年 MacBook. All rights reserved.
//

#import "UITableViewCell+Register.h"

@implementation UITableViewCell (Register)

+ (void)registerWithTableView:(UITableView *)tableView
{
    NSString *reuseIdentifier = NSStringFromClass([self class]);
    if ([[NSBundle mainBundle] pathForResource:reuseIdentifier ofType:@".nib"]) {
        UINib *nib = [UINib nibWithNibName:reuseIdentifier bundle:[NSBundle mainBundle]];
        [tableView registerNib:nib forCellReuseIdentifier:reuseIdentifier];
    } else {
        [tableView registerClass:[self class] forCellReuseIdentifier:reuseIdentifier];
    }
}

+ (instancetype)cellWithTableView:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath
{
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class]) forIndexPath:indexPath];
}

@end
