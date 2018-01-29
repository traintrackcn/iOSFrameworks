//
//  DSDraw.h
//  og
//
//  Created by traintrackcn on 13-8-7.
//  Copyright (c) 2013 2ViVe. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <CoreGraphics/CoreGraphics.h>
@import CoreGraphics;
@import UIKit;

typedef NS_ENUM(NSInteger, AGCornerPosition) {
    AGCornerPositionBL,
    AGCornerPositionBR,
    AGCornerPositionTL,
    AGCornerPositionTR
};

@interface DSDraw : NSObject

+ (void)drawEclipse:(CGContextRef)c rect:(CGRect)rect fillColor:(UIColor *)fillColor;
+ (void)drawRect:(CGContextRef)c rect:(CGRect)rect fillColor:(UIColor *)fillColor;
+ (void)drawLine:(CGContextRef)c startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint strokeColor:(UIColor *)strokeColor  lineWidth:(CGFloat)lineWidth;

+ (void)drawCorner:(CGContextRef)c type:(AGCornerPosition)type center:(CGPoint)center r:(CGFloat)r fillColor:(UIColor *)fillColor borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

@end
