//
//  DSImageFilter.h
//  og
//
//  Created by traintrackcn on 13-8-23.
//  Copyright (c) 2013 2ViVe. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreGraphics;
@import UIKit;

@interface DSImage : NSObject

+ (CGSize)scaleSize:(CGSize)size aspectFitMaxLen:(CGFloat)maxLen;
+ (CGSize)scaleSize:(CGSize)size aspectFitSize:(CGSize)fitSize;
+ (UIImage *)resizableImageWithColor:(UIColor *)c radius:(CGFloat)radius;

+ (UIImage *)imageWithView:(UIView *)view;
+ (UIImage *)imageWithTransformedView:(UIView *)view;

//+ (UIImage *)ipMaskedImageNamed:(NSString *)name color:(UIColor *)color;
+ (UIImage *)image:(UIImage *)image withMaskColor:(UIColor *)color;
//+ (UIImage *)fillImageNamed:(NSString *)imageName withColor:(UIColor *)color;
+ (UIImage *)rectangleWithSize:(CGSize)size fillColor:(UIColor *)fillColor;
+ (UIImage *)circleWithSize:(CGSize)size fillColor:(UIColor *)fillColor;
+ (UIImage *)triangleWithSize:(CGSize)size fillColor:(UIColor *)fillColor borderColor:(UIColor *)borderColor;

+ (NSString *)largeImageUrl:(NSString *)urlStr;
+ (NSString *)smallImageUrl:(NSString *)urlStr;
+ (NSString *)fullImageUrl:(NSString *)urlStr;

+ (BOOL)isImageUrlAvailableFromUrls:(NSArray *)urls;

//+ (UIImage *)imageWithLayer:(CALayer *)layer;
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
+ (UIImage *)imageWithImage:(UIImage *)image cropInRect:(CGRect)rect;


+ (UIColor *)navigationBarTintColorFromRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b;

@property (nonatomic, strong) NSString *imageHost;
@property (nonatomic, strong) UIImage *dummyImage;
@property (nonatomic, strong) UIImage *dummyPortraitImage;

@end
