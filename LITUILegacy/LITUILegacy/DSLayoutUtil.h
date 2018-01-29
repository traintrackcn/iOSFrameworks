//
//  DSLayoutUtil.h
//  og
//
//  Created by traintrackcn on 13-4-28.
//  Copyright (c) 2013 2ViVe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DSLayoutUtil : NSObject

+ (void)layoutView:(UIView *)view edgeInsets:(UIEdgeInsets)edgeInsets containerSize:(CGSize)containerSize;
+ (void)layoutView:(UIView *)view edgeInsets:(UIEdgeInsets)edgeInsets containerSize:(CGSize)containerSize offset:(CGPoint)offset;

+ (void)centerView:(UIView *)view containerSize:(CGSize)containerSize;
+ (void)centerView:(UIView *)view containerSize:(CGSize)containerSize offset:(CGPoint)offset;

+ (void)maskExceptView:(UIView *)view containerSize:(CGSize)containerSize;

+ (void)layoutView:(UIView *)view offset:(CGPoint)offset;

+ (void)layoutButtons:(NSArray *)buttons;

@end
