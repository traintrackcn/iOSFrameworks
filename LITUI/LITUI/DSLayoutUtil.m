//
//  DSLayoutUtil.m
//  og
//
//  Created by traintrackcn on 13-4-28.
//  Copyright (c) 2013 2ViVe. All rights reserved.
//

@import LITCommon;

#import "DSLayoutUtil.h"
//#import "DSDeviceUtil.h"
#import "AGAssembler.h"

@implementation DSLayoutUtil

+ (void)centerView:(UIView *)view containerSize:(CGSize)containerSize{
    [self centerView:view containerSize:containerSize offset:CGPointZero];
}

+ (void)centerView:(UIView *)view containerSize:(CGSize)containerSize offset:(CGPoint)offset{
//    CGSize deviceSize = [DSDeviceUtil deviceSize];
    CGRect frame = [view frame];
    CGSize size = frame.size;
    CGFloat viewW = size.width;
    CGFloat viewH = size.height;
    CGFloat containerW = containerSize.width;
    CGFloat containerH = containerSize.height;
    
    CGFloat left = (containerW - viewW)/2.0f;
    CGFloat top = (containerH - viewH)/2.0f;
    
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(top, left, 0, 0);
    
//    LOG_DEBUG(@"containerW -> %f containerH -> %f top -> %f left -> %f", containerW, containerH,top, left);
    
    [self layoutView:view edgeInsets:edgeInsets containerSize:containerSize offset:offset];
}

+ (void)layoutView:(UIView *)view edgeInsets:(UIEdgeInsets)edgeInsets containerSize:(CGSize)containerSize{
    [self layoutView:view edgeInsets:edgeInsets containerSize:containerSize offset:CGPointZero];
}

+ (void)layoutView:(UIView *)view edgeInsets:(UIEdgeInsets)edgeInsets containerSize:(CGSize)containerSize offset:(CGPoint)offset{
    CGFloat containerW = containerSize.width;
    CGFloat containerH = containerSize.height;
    CGRect frame = [view frame];
    CGSize size = frame.size;
    CGFloat viewW = size.width;
    CGFloat viewH = size.height;
    CGFloat top = edgeInsets.top;
    CGFloat left = edgeInsets.left;
    CGFloat bottom = edgeInsets.bottom;
    CGFloat right = edgeInsets.right;
    
    CGFloat targetX= 0;
    CGFloat targetY = 0;
    
    if (top!=0) {
        targetY = top;
    }
    
    if (bottom!=0) {
        targetY = containerH - viewH - bottom;
    }
    
    if (left!=0){
        targetX = left;
    }
    
    if (right!=0){
        targetX = containerW - viewW - right;
    }
    
    targetX += offset.x;
    targetY += offset.y;
    
//    LOG_DEBUG(@"targetX -> %f left->%f right->%f top->%f bottom->%f", targetX,left,right,top,bottom);
//    LOG_DEBUG(@"view -> %@", view);
    
    CGPoint origin = CGPointMake(targetX, targetY);
    frame.origin = origin;
    [view setFrame:frame];
}

+ (void)maskExceptView:(UIView *)view containerSize:(CGSize)containerSize{
    CGFloat containerW = containerSize.width;
    CGFloat containerH = containerSize.height;
    CGRect frame = [view frame];
    CGSize size = frame.size;
    CGPoint origin = frame.origin;
    CGFloat viewW = size.width;
    CGFloat viewH = size.height;
    CGFloat viewX = origin.x;
    CGFloat viewY = origin.y;
    
    
//    CGRect maskFrameT = CGRectMake(0, 0, containerW, viewY);
//    CGRect maskFrameB = CGRectMake(0, viewY+viewH, containerW, containerH - (viewY+viewH) );
    
    CGRect maskFrameT = CGRectMake(-viewX, -viewY, containerW, viewY);
    CGRect maskFrameL = CGRectMake(-viewX, 0, (containerW-viewW)/2.0f, viewH);
    CGRect maskFrameB = CGRectMake(-viewX, viewH, containerW, containerH - (viewY+viewH) );
    CGRect maskFrameR = CGRectMake(viewW, 0, (containerW-viewW)/2.0f, viewH);
    
//    UIView *containerView = [view superview];
    
    NSArray *arr = [NSArray arrayWithObjects:
        [NSValue valueWithCGRect:maskFrameT],
        [NSValue valueWithCGRect:maskFrameB],
        [NSValue valueWithCGRect:maskFrameL],
        [NSValue valueWithCGRect:maskFrameR],
        nil
    ];
    
    for (int i=0;i<[arr count];i++){
        CGRect maskFrame = [[arr objectAtIndex:i] CGRectValue];
        
        UIView *v = [[UIView alloc] initWithFrame:maskFrame];
        [v setBackgroundColor:[UIColor blackColor]];
        [v setAlpha:0.5];
        [view addSubview:v];
        
    }
    
    
}

+ (void)layoutView:(UIView *)view offset:(CGPoint)offset{
    CGRect frame = [view frame];
    CGPoint origin = frame.origin;
    
    origin = CGPointMake(origin.x+offset.x, origin.y+offset.y);
    
    frame.origin = origin;
    
    [view setFrame:frame];
    
}

+ (void)layoutButtons:(NSArray *)buttons{
    NSInteger num = buttons.count;
    CGRect bounds = [[UIScreen mainScreen] bounds];
//    CGFloat btnH = 44.0;
    CGFloat btnTotalW = 0;
    CGFloat btnW = (bounds.size.width - AG_BUTTON_SPACING*(num+1))/num;
    
    
    for (int i=0; i<num; i++) {
        UIButton *btn = [buttons objectAtIndex:i];
        btnTotalW += btn.frame.size.width;
    }
    
    
    //    CGFloat startX = (self.frame.size.width - btnTotalW - btnSpacing*(num-1))/2.0;
    CGFloat startX = AG_BUTTON_SPACING;
    
    for (int i=0; i<num; i++) {
        UIButton *btn = [buttons objectAtIndex:i];
        //        [btn setFrame:CGRectMake(startX, ([AGButtonCell height] - btn.frame.size.height)/2, btn.frame.size.width, btn.frame.size.height)];
        [btn setFrame:CGRectMake(startX, 0, btnW, AG_BUTTON_HEIGHT)];
        startX += btn.frame.size.width + AG_BUTTON_SPACING;
        
        [btn.superview setClipsToBounds:YES];
    }
}

@end
