//
//  UIView+BioAddViewShadow.m
//  BioMineModule
//
//  Created by admin on 2018/9/11.
//  Copyright © 2018年 BioMac. All rights reserved.
//

#import "UIView+BioAddViewShadow.h"
#import <AVFoundation/AVFoundation.h>
@implementation UIView (BioAddViewShadow)
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

-(void)BIO_SetShadowPathWith:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius shadowSide:(BIOShadowPathSide)shadowPathSide shadowPathWidth:(CGFloat)shadowPathWidth{
    
    
    self.layer.masksToBounds = NO;
    
    self.layer.shadowColor = shadowColor.CGColor;
    
    self.layer.shadowOpacity = shadowOpacity;
    
    self.layer.shadowRadius =  shadowRadius;
    
    self.layer.shadowOffset = CGSizeZero;
    CGRect shadowRect;
    
    CGFloat originX = 0;
    
    CGFloat originY = 0;
    
    CGFloat originW = self.bounds.size.width;
    
    CGFloat originH = self.bounds.size.height;
    
    
    switch (shadowPathSide) {
        case BIOShadowPathTop:
            shadowRect  = CGRectMake(originX, originY - shadowPathWidth/2, originW,  shadowPathWidth);
            break;
        case BIOShadowPathBottom:
            shadowRect  = CGRectMake(originX, originH -shadowPathWidth/2, originW, shadowPathWidth);
            break;
            
        case BIOShadowPathLeft:
            shadowRect  = CGRectMake(originX - shadowPathWidth/2, originY, shadowPathWidth, originH);
            break;
            
        case BIOShadowPathRight:
            shadowRect  = CGRectMake(originW - shadowPathWidth/2, originY, shadowPathWidth, originH);
            break;
        case BIOShadowPathNoTop:
            shadowRect  = CGRectMake(originX -shadowPathWidth/2, originY +1, originW +shadowPathWidth,originH + shadowPathWidth/2 );
            break;
        case BIOShadowPathAllSide:
            shadowRect  = CGRectMake(originX - shadowPathWidth/2, originY - shadowPathWidth/2, originW +  shadowPathWidth, originH + shadowPathWidth);
            break;
            
    }
    
    if (shadowPathSide==BIOShadowPathAllSide) {
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:shadowRect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(10, 10)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.bounds;
        maskLayer.path = maskPath.CGPath;
        self.layer.mask = maskLayer;
        self.layer.shadowPath = maskPath.CGPath;
    }else{
        
    UIBezierPath *path =[UIBezierPath bezierPathWithRect:shadowRect];
    self.layer.shadowPath = path.CGPath;
    }
    
   
}
@end
