//
//  DSDeviceUtil.m
//  og
//
//  Created by 2ViVe on 12-11-29.
//  Copyright (c) 2012 2ViVe. All rights reserved.
//

#import "DSDeviceUtil.h"
#import "DSValueUtil.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@implementation DSDeviceUtil




#pragma mark - properties
+ (NSString *)identifier{
    @try {
        NSString *uuid = [[NSUserDefaults standardUserDefaults] objectForKey:@"device-id"];
        if ([DSValueUtil isNotAvailable:uuid]) {
            uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
            [[NSUserDefaults standardUserDefaults] setObject:uuid forKey:@"device-id"];
        }
        return [DSValueUtil toString:uuid];
    }@catch (NSException *exception) {
        //        [[DSCrashReporterManager sharedInstance] logException:exception];
    }
    return @"no-device-id";
}


+ (void)test{
//    TLOG(@"model -> %@",[[UIDevice currentDevice] model]);
}

+ (BOOL)isIPad{
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
}

+ (BOOL)isNotIPad{
    return ![self isIPad];
}

+ (BOOL)isPortrait{
//    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
//    return UIDeviceOrientationIsPortrait(orientation);
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
//    if (orientation == 4) {
//        return NO;
//    }
    return UIInterfaceOrientationIsPortrait(orientation);
}

+ (BOOL)isRetina{
    if ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] &&
        ([UIScreen mainScreen].scale == 2.0)) {
        // Retina display
        return YES;
    }

    return NO;
}

+ (CGSize)deviceSize{
    CGRect rect = [[UIScreen mainScreen] bounds];
    return rect.size;
}

+ (CGFloat)deviceWidth{
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
//    CGFloat w = size.width;
//    CGFloat h = size.height;
//    
//    if ([self isIPad]) { //temprory solove
//        return w>h?w:h;
//    }
    
//    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    
    // on iPhone orientation won't change with same settings
//    TLOG(@"deviceWidth orientation -> %d", orientation);
    
//    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight){
//        return size.height;
//    }
    
    return size.width;
}

+ (CGFloat)deviceHeight{
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
//    CGFloat w = size.width;
//    CGFloat h = size.height;
//    
//    if ([self isIPad]) { //temprory solove
//        return h>w?w:h;
//    }
//
//    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
//    
//    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight){
//        return size.width;
//    }
    
    return size.height;
}

+ (CGRect)bounds{
    return [[UIScreen mainScreen] bounds];
}

//+ (CGFloat)landscapeW{
//    CGRect rect = [[UIScreen mainScreen] bounds];
//    CGSize size = rect.size;
//    CGFloat w = size.width;
//    CGFloat h = size.height;
//    
//    //    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
//    //
//    //    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight){
//    //        return size.height;
//    //    }
//    
//    return w>h?w:h;
//}
//
//+ (CGFloat)landscapeH{
//    CGRect rect = [[UIScreen mainScreen] bounds];
//    CGSize size = rect.size;
//    CGFloat w = size.width;
//    CGFloat h = size.height;
//    
//    return h<w?h:w;
//}


+ (BOOL)iPhoneIs16_9{
//    UIDevice *device = [UIDevice currentDevice];
//    NSString *model = [device model];
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    float w = size.width;
    float h = size.height;
    
    if (w==320.0f && h == 480.0f) {
        return NO;
    }
    
//    TLOG(@"screen rect -> w:%f h:%f", size.width,size.height);
    return YES;
}

+ (NSString *)systemInfo{
    UIDevice *device = [UIDevice currentDevice];
    NSString *str = [NSString stringWithFormat:@"%@_%@",[device systemVersion],[device model]];
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];    
    return str;
}

+ (BOOL)iOS7AndAbove{
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0) return YES;
    return NO;
}

+ (BOOL)iOS8AndAbove{
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0) return YES;
    return NO;
}

+ (BOOL)iOS10AndAbove{
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 10.0) return YES;
    return NO;
}

+ (BOOL)isNotIOS8AndAbove{
    return !self.iOS8AndAbove;
}

+ (CGFloat)offsetOfUIViewInDifferentOS{
    if([self iOS7AndAbove]) return 0;
    return 64.0;
}

+ (BOOL)isReleaseBuild{
        BOOL bRelease = YES;
#ifdef DEBUG
        bRelease = NO;
#endif
        return bRelease;
}

@end
