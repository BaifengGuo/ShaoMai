//
//  UIView+BioAddViewShadow.h
//  BioMineModule
//
//  Created by admin on 2018/9/11.
//  Copyright © 2018年 BioMac. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum :NSInteger{
    
    BIOShadowPathLeft,
    BIOShadowPathRight,
    BIOShadowPathTop,
    BIOShadowPathBottom,
    BIOShadowPathNoTop,
    BIOShadowPathAllSide
    
} BIOShadowPathSide;
@interface UIView (BioAddViewShadow)
/*
 * shadowColor 阴影颜色
 *
 * shadowOpacity 阴影透明度，默认0
 *
 * shadowRadius  阴影半径，默认3
 *
 * shadowPathSide 设置哪一侧的阴影，
 
 * shadowPathWidth 阴影的宽度，
 
 */

-(void)BIO_SetShadowPathWith:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius shadowSide:(BIOShadowPathSide)shadowPathSide shadowPathWidth:(CGFloat)shadowPathWidth;
@end
