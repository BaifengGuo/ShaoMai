//
//  UICollectionViewCell+Register.m
//  BioCategory
//
//  Created by MacBook on 2018/5/29.
//  Copyright © 2018年 MacBook. All rights reserved.
//

#import "UICollectionViewCell+Register.h"

@implementation UICollectionViewCell (Register)

+ (void)registerWithCollectionView:(UICollectionView *)collectionView
{
    NSString *reuseIdentifier = NSStringFromClass([self class]);
    if ([[NSBundle mainBundle] pathForResource:reuseIdentifier ofType:@".nib"]) {
        UINib *nib = [UINib nibWithNibName:reuseIdentifier bundle:[NSBundle mainBundle]];
        [collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
    } else {
       [collectionView registerClass:[self class] forCellWithReuseIdentifier:NSStringFromClass([self class])];
    }
}

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath
{
    
    return [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([self class]) forIndexPath:indexPath];
}


@end
