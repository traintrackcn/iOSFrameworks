//
//  DSDraw.m
//  og
//
//  Created by traintrackcn on 13-8-7.
//  Copyright (c) 2013 2ViVe. All rights reserved.
//

#import "DSDraw.h"

static DSDraw *____instanceDSDraw;

@implementation DSDraw

+ (DSDraw *)sharedInstance{
    if (!____instanceDSDraw) {
        ____instanceDSDraw = [[DSDraw alloc] init];
    }
    return ____instanceDSDraw;
}

- (id)init{
    self = [super init];
    if (self) {
    
    }
    return self;
}


+ (void)drawEclipse:(CGContextRef)c rect:(CGRect)rect fillColor:(UIColor *)fillColor{
    CGContextSaveGState(c);
    CGContextSetFillColorWithColor(c, [fillColor CGColor]);
    CGContextFillEllipseInRect(c, rect);
    CGContextRestoreGState(c);
}

+ (void)drawRect:(CGContextRef)c rect:(CGRect)rect fillColor:(UIColor *)fillColor{
    CGContextSaveGState(c);
    CGContextSetFillColorWithColor(c, [fillColor CGColor]);
//    CGContextAddRect(c, rect);
    CGContextFillRect(c, rect);
    CGContextRestoreGState(c);
}

+ (void)drawEclipse:(CGContextRef)c rect:(CGRect)rect strokeColor:(UIColor *)strokeColor strokeWidth:(CGFloat)strokeWidth{
    CGContextSaveGState(c);
    CGContextSetStrokeColorWithColor(c, [strokeColor CGColor]);
    CGContextSetLineWidth(c, strokeWidth);
    CGContextAddEllipseInRect(c, rect);
    CGContextStrokePath(c);
    CGContextRestoreGState(c);
}

+ (void)drawLine:(CGContextRef)c startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint strokeColor:(UIColor *)strokeColor lineWidth:(CGFloat)lineWidth{
    CGContextSaveGState(c);
    CGContextSetStrokeColorWithColor(c, [strokeColor CGColor]);
    CGContextSetLineWidth(c, lineWidth);
    CGContextMoveToPoint(c, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(c, endPoint.x, endPoint.y);
    CGContextStrokePath(c);
    CGContextRestoreGState(c);

}


+ (void)drawCorner:(CGContextRef)c type:(AGCornerPosition)type center:(CGPoint)center r:(CGFloat)r fillColor:(UIColor *)fillColor borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth{
    
    CGFloat startAngle;
    CGFloat endAngle;
    
    switch (type) {
        case AGCornerPositionBL:
            startAngle = M_PI_2;
            endAngle = M_PI_2*2;
            break;
        case AGCornerPositionBR:
            startAngle = 0;
            endAngle = M_PI_2;
            break;
            
        case AGCornerPositionTL:
            startAngle = M_PI_2*2;
            endAngle = M_PI_2*3;
            break;
        case AGCornerPositionTR:
            startAngle = M_PI_2*3;
            endAngle = M_PI_2*4;
            break;
    }
    
    //    CGMutablePathRef path = CGPathCreateMutable();
    //    CGPathAddArc(path, NULL, arcCenter.x, arcCenter.y, w/2, 0, M_PI_2, YES);
    //    CGPathCloseSubpath(path);
    
    //border
    
    CGContextSaveGState(c);
//    CGContextSetFillColorWithColor(c, [[UIColor yellowColor] CGColor]);
    CGContextSetStrokeColorWithColor(c, [borderColor CGColor]);
    CGContextSetLineWidth(c, borderWidth);
    
    CGContextAddArc(c, center.x, center.y, r, startAngle, endAngle, NO);
//    CGContextClosePath(c);
    CGContextDrawPath(c, kCGPathStroke);
    CGContextRestoreGState(c);
    
    //    CGPathRelease(path);
    
    //        3*PI/2
    //          |
    //    PI ---|--- 0
    //          |
    //        PI/2
    
    // fill
    CGContextSaveGState(c);
    CGContextSetFillColorWithColor(c, [fillColor CGColor]);
    CGContextSetLineWidth(c, borderWidth);
    CGContextAddArc(c, center.x, center.y, r, 0, M_PI*2, NO);
    CGContextDrawPath(c, kCGPathFill);
    CGContextRestoreGState(c);
    
}

@end
