//
//  DSDeviceUtil.h
//  og
//
//  Created by 2ViVe on 12-11-29.
//  Copyright (c) 2012 2ViVe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "NSObject+Singleton.h"

#define DEVICE [DSDeviceUtil singleton]

@interface DSDeviceUtil : NSObject

+ (void)test;

+ (NSString *)identifier;
- (NSString *)identifier;

+ (BOOL)isIPad;
+ (BOOL)isNotIPad;
+ (BOOL)isPortrait;

+ (BOOL)iPhoneIs16_9;
+ (BOOL)isRetina;
+ (BOOL)iOS7AndAbove;
+ (BOOL)iOS8AndAbove;
+ (BOOL)iOS10AndAbove;
+ (BOOL)isNotIOS8AndAbove;
+ (CGFloat)offsetOfUIViewInDifferentOS;
+ (NSString *)systemInfo;

+ (CGFloat)deviceWidth;
+ (CGFloat)deviceHeight;
+ (CGSize)deviceSize;
+ (CGRect)bounds;

@property (nonatomic, strong) NSString *deviceToken;

//+ (NSUInteger)supportedInterfaceOrientations;
//+ (BOOL)shouldAutorotate;
//+ (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation;




@end
