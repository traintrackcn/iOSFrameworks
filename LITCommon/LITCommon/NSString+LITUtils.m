//
//  NSString+LITUtils.m
//  LITCommon
//
//  Created by traintrackcn on 19/03/2018.
//  Copyright © 2018 abovegem. All rights reserved.
//

#import "NSString+LITUtils.h"
#import "GlobalDefine.h"

@implementation NSString (LITUtils)

- (NSDate *)date{
    return [self dateWithTimeZone:nil];
}

- (NSDate *)dateWithTimeZone:(NSTimeZone *)timeZone{
    NSString *value = [self copy];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    if (timeZone) [df setTimeZone:timeZone];
    
    
    
    
    if ([value rangeOfString:@"T"].location!=NSNotFound && [value rangeOfString:@"."].location!=NSNotFound) {
        //        if ([value rangeOfString:@"Z"].location != NSNotFound){
        [df setTimeZone:self.utcTimezone];
        NSArray *arr = [value componentsSeparatedByString:@"T"];
        NSArray *arr1 = [[arr objectAtIndex:1] componentsSeparatedByString:@"."];
        value = [NSString stringWithFormat:@"%@ %@", arr.firstObject, arr1.firstObject];
        [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
    }else if ([value rangeOfString:@"T"].location!=NSNotFound && [value rangeOfString:@"Z"].location!=NSNotFound){
        [df setTimeZone:self.utcTimezone];
        NSArray *arr = [value componentsSeparatedByString:@"T"];
        NSArray *arr1 = [arr.lastObject componentsSeparatedByString:@"Z"];
        value = [NSString stringWithFormat:@"%@ %@", arr.firstObject, arr1.firstObject];
        TLOG(@"value -> %@", value);
        [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
    }else if ([value rangeOfString:@" "].location != NSNotFound){
        NSArray *arr = [value componentsSeparatedByString:@" "];
        NSArray *arr1 = [arr.lastObject componentsSeparatedByString:@":"];
        //        TLOG(@"arr -> %@ arr1 -> %@ arr1.count -> %d", arr, arr1, arr1.count);
        if (arr1.count == 2) {
            //            TLOG(@"value -> %@", value);
            [df setDateFormat:@"yyyy-MM-dd HH:mm"];
        }else{
            value = arr.firstObject;
            [df setDateFormat:@"yyyy-MM-dd"];
        }
    }else if ([value rangeOfString:@"/"].location != NSNotFound){
        [df setDateFormat:@"yyyy-MM-dd"];
        NSArray *arr = [value componentsSeparatedByString:@"/"];
        NSString *year = arr.lastObject;
        NSString *month = arr.firstObject;
        value = [NSString stringWithFormat:@"%@-%@-01", year, month];
    }else{
        NSArray *arr = [value componentsSeparatedByString:@"-"];
        
        if (arr.count == 2) {
            [df setDateFormat:@"yyyy-MM"];
        }else{
            [df setDateFormat:@"yyyy-MM-dd"];
        }
    }
    NSDate *d = [df dateFromString:value];
    
    //    TLOG(@"value -> %@ df.tz -> %@", value, df.timeZone);
    //    [self setBirthDate:d];
    
    //    TLOG(@"value -> %@ %@", value, df.dateFormat);
    //    TLOG(@"========");
    return d;
    
}


#pragma mark -

- (id)utcTimezone{
    return [NSTimeZone timeZoneWithName:@"UTC"];
    //    [df setTimeZone:timeZone];
}

@end
