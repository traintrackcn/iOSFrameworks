//
//  DSImageFilter.m
//  og
//
//  Created by traintrackcn on 13-8-23.
//  Copyright (c) 2013 2ViVe. All rights reserved.
//

@import LITCommon;

#import "DSImage.h"
//#import "DSDeviceUtil.h"
//#import <LITCommon/NSObject+Singleton.h>
//#import "NSObject+Singleton.h"
//#import "DSHostSettingManager.h"
//#import "AGServer.h"
#import "DSDraw.h"


@implementation DSImage

#pragma mark - side stuff


+ (CGSize)scaleSize:(CGSize)size aspectFitMaxLen:(CGFloat)maxLen{
    CGFloat ratio = 1.0f;
//    CGFloat maxSideLen = 800;
    if ( size.width > size.height ){
        ratio = maxLen / size.width;
    }else{
        ratio = maxLen / size.height;
    }
    
    //    LOG_INFO(@"ration %f",ratio);
    if (ratio > 1.0) ratio = 1.0;
    
    
    return CGSizeMake( (int)(size.width * ratio), (int)(size.height * ratio));
}


+ (CGSize)scaleSize:(CGSize)size aspectFitSize:(CGSize)fitSize{
    CGFloat scaleW = size.width/fitSize.width;
    CGFloat scaleH = size.height/fitSize.height;
    CGFloat scale;
    
    scale = scaleW>scaleH?scaleW:scaleH;
    
    return CGSizeMake (size.width/scale, size.height/scale);
//    return CGSizeMake(size.width, <#CGFloat height#>)
    
}

+ (UIImage *)resizableImageWithColor:(UIColor *)c radius:(CGFloat)r{
    CGFloat w = r*2+1;
    CGFloat h = w;
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
    [v setOpaque:NO];
    [v.layer setCornerRadius:r];
    [v setClipsToBounds:YES];
    [v setBackgroundColor:c];
    UIImage *img = [self imageWithView:v];
    return  [img resizableImageWithCapInsets:UIEdgeInsetsMake(r, r, r, r)];
}

#pragma mark - image stuff

+ (UIImage *)rectangleWithSize:(CGSize)size fillColor:(UIColor *)fillColor{
    CGFloat scale = 1.0;
    if ([DSDeviceUtil isRetina])  scale = 2.0;
    UIGraphicsBeginImageContextWithOptions(size, YES, scale);
	[fillColor setFill];
	CGRect rect = CGRectMake(0, 0,size.width *scale, size.height*scale);
    UIRectFill(rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *)circleWithSize:(CGSize)size fillColor:(UIColor *)fillColor{
    CGFloat scale = 1.0;
    if ([DSDeviceUtil isRetina])  scale = 2.0;
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
	[fillColor setFill];
    CGRect rect = CGRectMake(0, 0,size.width , size.height);
    CGContextFillEllipseInRect(ctx, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

+ (UIImage *)triangleWithSize:(CGSize)size fillColor:(UIColor *)fillColor borderColor:(UIColor *)borderColor{
    
    
    
    CGFloat scale = 1.0;
    if ([DSDeviceUtil isRetina])  scale = 2.0;
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    CGPoint ptT = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint ptBR = CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGPoint ptBL = CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [fillColor setFill];
    CGContextBeginPath(ctx);
    CGContextMoveToPoint   (ctx, ptT.x, ptT.y);  // top
    CGContextAddLineToPoint(ctx, ptBR.x, ptBR.y);  // bottom right
    CGContextAddLineToPoint(ctx, ptBL.x, ptBL.y);  // bottom left
    CGContextClosePath(ctx);
    
    CGContextFillPath(ctx);
    
    if (borderColor) {
        [DSDraw drawLine:ctx startPoint:ptT endPoint:ptBR strokeColor:borderColor lineWidth:.5f];
        [DSDraw drawLine:ctx startPoint:ptT endPoint:ptBL strokeColor:borderColor lineWidth:.5f];
    }
    
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}





+ (NSString *)largeImageUrl:(NSString *)urlStr{
    return [self imageUrl:urlStr sizePrefix:@"large"];
}

+ (NSString *)smallImageUrl:(NSString *)urlStr{
    return [self imageUrl:urlStr sizePrefix:@"small"];
}

+ (NSString *)fullImageUrl:(NSString *)urlStr{
    return [self imageUrl:urlStr sizePrefix:nil];
}

+ (BOOL)isImageUrlAvailableFromUrls:(NSArray *)urls{
    if (![urls isKindOfClass:[NSArray class]]) return NO;
    if ([urls count] ==  0) return NO;
    return YES;
}

+ (NSString *)imageUrl:(NSString *)urlStr sizePrefix:(NSString *)sizePrefix{
    //    TLOG(@"urlStr before -> %@", urlStr);
    //https://www.organogold.com/upload/image/1/large_f9efae0e-0497-4c99-ae41-51e778ced6b9.jpg
    
    //    NSString *serverUrl = [DSHostSettingManager selectedServer].httpUrlWithoutExtension;
    NSString *serverUrl = [DSImage singleton].imageHost;
    //TEMPORARY SOLUTION
    if ([urlStr rangeOfString:@"http"].location == NSNotFound) {
        urlStr = [NSString stringWithFormat:@"%@%@", serverUrl,urlStr];
    }
    
    if (!sizePrefix) return urlStr;
    
    NSMutableArray *arr = [[urlStr componentsSeparatedByString:@"/"] mutableCopy];
    NSInteger lastIndex = arr.count - 1;
    NSString *imageName = [arr objectAtIndex:lastIndex];
    NSArray *arr1 = [imageName componentsSeparatedByString:@"."];
    if (arr1.count <= 1) return urlStr;
    NSString *imageNameWithoutFormat = [arr1 objectAtIndex:0];
    NSString *imageFormat = [arr1 objectAtIndex:1];
    NSArray *arr2 = [imageNameWithoutFormat componentsSeparatedByString:@"_"];
    if (arr2.count <= 1) return urlStr;
    
    NSString *imageNameWithoutSize = [arr2 objectAtIndex:1];
    NSString *imageNameFinal = [NSString stringWithFormat:@"%@_%@.%@", sizePrefix,imageNameWithoutSize, imageFormat];
    [arr removeLastObject];
    [arr addObject:imageNameFinal];
    return [arr componentsJoinedByString:@"/"];
}

//+ (UIImage *)fillImageNamed:(NSString *)imageName withColor:(UIColor *)color{
//    UIImage *image = [UIImage imageNamed:imageName];
//
//    UIGraphicsBeginImageContext(image.size);
//
//	// draw original image into the context
//	[image drawAtPoint:CGPointZero];
//
//	// get the context for CoreGraphics
//	CGContextRef ctx = UIGraphicsGetCurrentContext();
//
//	// set stroking color and draw circle
//	[color setFill];
//
//	// make circle rect 5 px from border
//	CGRect rect = CGRectMake(0, 0,
//                             image.size.width,
//                             image.size.height);
//	CGContextFillRect(ctx, rect);
//
//	// make image out of bitmap context
//	UIImage *retImage = UIGraphicsGetImageFromCurrentImageContext();
//
//	// free the context
//	UIGraphicsEndImageContext();
//    return retImage;
//}





+ (UIImage *)imageWithWhiteBackgroundForImage:(UIImage *)image{
    CGFloat scale = image.scale;
    CGFloat w = image.size.width*scale;
    CGFloat h = image.size.height*scale;
    CGSize s = CGSizeMake(w, h);
    
    
    UIGraphicsBeginImageContext(s);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetBlendMode(ctx, kCGBlendModeCopy);
    [image drawInRect:CGRectMake(0, 0, w, h)];
    CGContextSetBlendMode(ctx, kCGBlendModeDifference);
    CGContextSetFillColorWithColor(ctx,[UIColor whiteColor].CGColor);
    CGContextFillRect(ctx, CGRectMake(0, 0, w, h));
    UIImage *negativeImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return negativeImage;
}


+ (UIImage *) image:(UIImage *)image withMaskColor:(UIColor *)color{
    
    
    
    UIImage *formattedImage = [self imageWithWhiteBackgroundForImage:image];
    //    return formattedImage;
    //    TLOG(@"size %f %f", formattedImage.size.width, formattedImage.size.height);
    
//    TLOG(@"image.scale -> %f", image.scale);
    CGFloat scale = image.scale;
    CGRect rect = {0, 0, formattedImage.size.width/scale, formattedImage.size.height/scale};
    
//    rect = {0, 0, formattedImage.size.width, formattedImage.size.height};
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, scale);
    [color setFill];
    UIRectFill(rect);
    UIImage *targetColorImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //    return  [self imageWithWhiteBackgroundForImage:image];
    //    return targetColorImage;
    //    return formattedImage;
    CGImageRef maskRef = [formattedImage CGImage];
    //    int bitsPerComponent                    = 1;
    //    int bitsPerPixel                        = bitsPerComponent * 1 ;
    //    int bytesPerRow                         = (CGImageGetWidth(maskRef) * bitsPerPixel);
    
    
    CGImageRef maskcg = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                          CGImageGetHeight(maskRef),
                                          CGImageGetBitsPerComponent(maskRef),
                                          CGImageGetBitsPerPixel(maskRef),
                                          CGImageGetBytesPerRow(maskRef),
                                          CGImageGetDataProvider(maskRef),
                                          NULL, false);
    
    CGImageRef maskedcg = CGImageCreateWithMask([targetColorImage CGImage], maskcg);
    CGImageRelease(maskcg);
    
    
    UIImage *result = [UIImage imageWithCGImage:maskedcg scale:[image scale] orientation:[image imageOrientation]];
    CGImageRelease(maskedcg);
    
    return result;
}


+ (UIImage *) imageWithView:(UIView *)view{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
//    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];

    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

+ (UIImage *)imageWithTransformedView:(UIView *)view{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *)imageWithImage:(UIImage *)image cropInRect:(CGRect)rect {
    NSParameterAssert(image != nil);
    if (CGPointEqualToPoint(CGPointZero, rect.origin) && CGSizeEqualToSize(rect.size, image.size)) {
        return image;
    }
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, image.scale);
    [image drawAtPoint:(CGPoint){-rect.origin.x, -rect.origin.y}];
    UIImage *croppedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return croppedImage;
}


#pragma mark - resize image

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, YES, image.scale);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


- (UIImage *)dummyPortraitImage{
    if (!_dummyPortraitImage) {
        _dummyPortraitImage = [UIImage imageNamed:@"nopic_mini"];
    }
    return _dummyPortraitImage;
}

- (UIImage *)dummyImage{
    if (!_dummyImage) {
        _dummyImage = [[UIImage alloc] init];
    }
    return _dummyImage;
}

#pragma mark - color utils

+ (UIColor *)navigationBarTintColorFromRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b{
//    TLOG(@"r:%f g:%f b:%f", r, g, b);
    r = [self navigationBarBackgroundTintColorValueFromDesignedColorValue:r];
    g = [self navigationBarBackgroundTintColorValueFromDesignedColorValue:g];
    b = [self navigationBarBackgroundTintColorValueFromDesignedColorValue:b];
//    TLOG(@"r:%f g:%f b:%f", r, g, b);
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
}

+ (CGFloat)navigationBarBackgroundTintColorValueFromDesignedColorValue:(CGFloat)value{
    //    return (n – 40) / (1 － 40/255);
    CGFloat a = value - 40;
    CGFloat b = 1 - (40.0/255.0);
//    TLOG(@"value:%f a:%f b:%f",value, a, b);
    return a/b;
}

@end
