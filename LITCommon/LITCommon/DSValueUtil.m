//
//  DSValue.m
//  og
//
//  Created by traintrackcn on 13-10-5.
//  Copyright (c) 2013 2ViVe. All rights reserved.
//

#import "DSValueUtil.h"
#import "AGModel.h"

@implementation DSValueUtil


+ (BOOL)isNil:(id)value{
    if (value == nil) return YES;
    return NO;
}

+ (BOOL)isNotNil:(id)value{
    return ![self isNil:value];
}

+ (BOOL)isNull:(id)value{
    @try {
        if ([value isEqual:[NSNull null]]) return YES;
    }@catch (NSException *exception) {
//        TLOG(@"e -> %@", exception);
    }
    return NO;
}

+ (BOOL)isNotNull:(id)value{
    return ![self isNull:value];
}

+ (BOOL)isEmptyString:(NSString *)value{
    if ([DSValueUtil isNotAvailable:value]) return YES;
    if ([value isEqualToString:@""]) return YES;
    return NO;
}

+ (BOOL)isNotEmptyString:(NSString *)value{
    return ![self isEmptyString:value];
}

+ (BOOL)isAvailable:(id)value{
    if ([self isNil:value]) return NO;
    if ([self isNull:value]) return NO;
    return YES;
}

+ (BOOL)isNotAvailable:(id)value{
    return ![self isAvailable:value];
}

+ (NSString *)toString:(id)value{
    if ([self isAvailable:value]) return [NSString stringWithFormat:@"%@", value];
    return @"";
}

+ (double)toFloat:(id)value{
    if ([self isAvailable:value]) return [value doubleValue];
    return 0;
}

+ (NSInteger)toInteger:(id)value{
    if ([self isAvailable:value]) return [value intValue];
    return 0;
}

#pragma mark - 

+ (NSArray *)convertRawArray:(NSArray *)rawArray modelClass:(Class)modelClass{
    NSMutableArray *tmpArr = [NSMutableArray array];
    for (int i=0; i<rawArray.count; i++) {
        id raw = [rawArray objectAtIndex:i];
        if ([raw isKindOfClass:modelClass]) {
            [tmpArr addObject:raw];
            continue;
        }
        id model = [[modelClass alloc] initWithRaw:raw];
        [tmpArr addObject:model];
        
    }
    return tmpArr;
}

+ (id)itemAtIndex:(NSInteger)index inArray:(NSArray *)array{
    @try {
        if ([DSValueUtil isNotAvailable:array]) return nil;
        if (index < 0) return nil;
        if (index+1 > array.count) return nil;
        return [array objectAtIndex:index];
    }
    @catch (NSException *exception) {
//        [[DSCrashReporterManager sharedInstance] logException:exception];
    }
    return nil;
}

@end
