//
//  AGAppUtil.m
//  AboveGEM
//
//  Created by traintrackcn on 4/5/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import "AGAppUtil.h"

@implementation AGAppUtil

+ (NSString *)identifier{
    return [[NSBundle mainBundle] bundleIdentifier];
}

+ (NSString *)buildNumber{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey: (NSString *)kCFBundleVersionKey];
}

+ (NSString *)textBuildNumberStyleForRemoteMonitor{
    return [NSString stringWithFormat:@"b.%@", self.buildNumber];
}

+ (NSString *)textBuildNumber{
    return [NSString stringWithFormat:@"Build %@", self.buildNumber];
}

//+ (void)setPushNotificationToken:(NSString *)pushNotificationToken{
//    [[NSUserDefaults standardUserDefaults] setObject:pushNotificationToken forKey:USER_DEFAULTS_KEY_PUSH_NOTIFICATION_TOKEN];
//}
//
//+ (NSString *)pushNotificationToken{
//    return [[NSUserDefaults standardUserDefaults] objectForKey:USER_DEFAULTS_KEY_PUSH_NOTIFICATION_TOKEN];
//}

//+ (BOOL)isReleaseBuild{
//    BOOL bRelease = YES;
//#ifdef DEBUG
//    bRelease = NO;
//#endif
//    return bRelease;
//}

@end
