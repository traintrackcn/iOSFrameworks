//
//  DSValue.h
//  og
//
//  Created by traintrackcn on 13-10-5.
//  Copyright (c) 2013 2ViVe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface DSValueUtil : NSObject


+ (BOOL)isAvailable:(id)value;
+ (BOOL)isNotAvailable:(id)value;

+ (NSString *)toString:(id)value;
+ (double)toFloat:(id)value;
+ (NSInteger)toInteger:(id)value;

+ (BOOL)isNil:(id)value;
+ (BOOL)isNotNil:(id)value;
+ (BOOL)isNull:(id)value;
+ (BOOL)isNotNull:(id)value;

+ (BOOL)isEmptyString:(NSString *)value;
+ (BOOL)isNotEmptyString:(NSString *)value;

+ (NSArray *)convertRawArray:(NSArray *)rawArray modelClass:(Class)modelClass;
+ (id)itemAtIndex:(NSInteger)index inArray:(NSArray *)array;

@end
