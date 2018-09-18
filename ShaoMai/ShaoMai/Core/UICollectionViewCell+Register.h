//
//  UICollectionViewCell+Register.h
//  BioCategory
//
//  Created by MacBook on 2018/5/29.
//  Copyright © 2018年 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionViewCell (Register)

+ (void)registerWithCollectionView:(UICollectionView *)collectionView;

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath;

@end
