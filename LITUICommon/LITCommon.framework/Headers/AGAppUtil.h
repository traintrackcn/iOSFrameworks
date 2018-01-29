//
//  AGAppUtil.h
//  AboveGEM
//
//  Created by traintrackcn on 4/5/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AGAppUtil : NSObject

+ (NSString *)identifier;
+ (NSString *)buildNumber;
+ (NSString *)textBuildNumberStyleForRemoteMonitor;
+ (NSString *)textBuildNumber;
//+ (NSString *)pushNotificationToken;
//+ (void)setPushNotificationToken:(NSString *)pushNotificationToken;

//+ (BOOL)isReleaseBuild;;

@end
