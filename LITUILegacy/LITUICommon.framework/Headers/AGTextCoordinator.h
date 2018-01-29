//
//  DSText.h
//  og
//
//  Created by traintrackcn on 13-8-6.
//  Copyright (c) 2013 2ViVe. All rights reserved.
//

#import <Foundation/Foundation.h>
@import LITCommon;

#define TEXT_C [AGTextCoordinator singleton]
#define TEXT(key) [AGTextCoordinator textForKey:key roleCode:nil]
#define TEXT_WITH_STAR(key) [AGTextCoordinator textWithStarForKey:key roleCode:nil]
#define TEXT_FOR_KEY(key) [AGTextCoordinator textForKey:key roleCode:nil]

//#define TEXT_FOR_ROLE(key, roleCode) [AGTextCoordinator textForKey:key roleCode:roleCode]
//#define TEXT_FOR_KEY_AND_ROLE_CODE(key,roleCode) [AGTextCoordinator textForKey:key roleCode:roleCode]
//#define IS_AVAILABLE_TEXT_KEY(key, roleCode) [AGTextCoordinator isAvailableTextKey:key roleCode:roleCode]

@interface AGTextCoordinator : NSObject

+ (NSString *)textForKey:(NSString *)key roleCode:(NSString *)roleCode;
+ (NSString *)textWithStarForKey:(NSString *)key roleCode:(NSString *)roleCode;
+ (BOOL)isAvailableTextKey:(NSString *)key roleCode:(NSString *)roleCode;
- (void)reload;

@property (nonatomic, assign) BOOL returnFirstKeyIfNoValue;
@property (nonatomic, strong) NSDictionary *extraDic; 

@end
