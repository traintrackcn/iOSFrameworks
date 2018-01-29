//
//  DSDateUtil.m
//  og
//
//  Created by traintrackcn on 13-10-16.
//  Copyright (c) 2013 2ViVe. All rights reserved.
//

#import "AGDateUtil.h"
#import "DSValueUtil.h"
#import "GlobalDefine.h"

@implementation AGDateUtil


+ (NSString *)formatCreditCardExpirationDate:(NSString *)date{
    @try {
        if ([self isNotAvailableDateString:date]) return @"";
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"yyyy-mm"];
        NSDate *d = [df dateFromString: date];
        if (d == nil) return @"";
        NSString *dateNew = [df stringFromDate:d];
        return [DSValueUtil toString:dateNew];
    }@catch (NSException *exception) {
        TLOG(@"exception -> %@", exception);
//        [[DSCrashReporterManager sharedInstance] logException:exception];
    }
    
    return @"";
}

+ (NSString *)formatToYYYYMinusMMinusDDForYYYYMMDD:(NSString *)date{
    @try {
        if ([self isNotAvailableDateString:date]) return @"";

        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"yyyymmdd"];
        NSDate *d = [df dateFromString: date];
        if (d == nil) return @"";
        NSDateFormatter *dfNew = [[NSDateFormatter alloc] init];
        [dfNew setDateFormat:@"yyyy-mm-dd"];
        NSString *dateNew = [dfNew stringFromDate:d];
        return [DSValueUtil toString:dateNew];
    }@catch (NSException *exception) {
        TLOG(@"exception -> %@", exception);
//        [[DSCrashReporterManager sharedInstance] logException:exception];
    }
    
    return @"";
}


+ (BOOL)isNotAvailableDateString:(NSString *)date{
    return ![self isAvailableDateString:date];
}

+ (BOOL)isAvailableDateString:(NSString *)date{
    if ([DSValueUtil isNotAvailable:date]) return NO;
    if ([date isEqualToString:@""]) return NO;
    return YES;
}

+ (NSString *)defaultValueOfPeriodCollection:(NSDictionary *)periodCollection{
    NSArray *years = periodCollection.allKeys;
    //sort year in decend
    NSSortDescriptor* sortDes = [NSSortDescriptor sortDescriptorWithKey: @"self" ascending: NO];
    years = [years sortedArrayUsingDescriptors: [NSArray arrayWithObject: sortDes]];
    NSString *year = years.firstObject;
    NSArray *months = [periodCollection objectForKey:year];
    
    return [NSString stringWithFormat:@"%@%@",year, months.firstObject];
}

+ (id)periodCollectionStartFrom:(NSString *)dateStr{
    NSDateComponents *start = [self componetsOfDateStr:dateStr];
    NSDateComponents *now = [self componetsOfDate:[NSDate date]];
    NSInteger startYear = start.year;
    NSInteger startMonth = start.month;
    NSInteger nowYear = now.year;
    NSInteger nowMonth = now.month;
    
//    TLOG(@"startYear -> %ld startMonth -> %ld nowYear -> %ld nowMonth -> %ld", startYear, startMonth, nowYear, nowMonth);
    NSMutableDictionary *yCollection = [NSMutableDictionary dictionary];
    
    for (NSInteger y = startYear; y<= nowYear; y++) {
        NSInteger startM = 1;
        NSInteger endM = 12;
        
        if (y == startYear){
            startM = startMonth;
        }else if (y == nowYear){
            endM = nowMonth;
        }
        
        NSMutableArray *mArr = [NSMutableArray array];
        for (NSInteger m = endM; m>=startM; m--) {
            NSString *mStr;
            if (m > 9){
                mStr = [NSString stringWithFormat:@"%ld01",(long)m];
            }else{
                mStr = [NSString stringWithFormat:@"0%ld01", (long)m];
            }
            [mArr addObject:mStr];
        }
        
        [yCollection setValue:mArr forKey:[NSString stringWithFormat:@"%ld", (long)y]];
        
    }
    
    
    return yCollection;
    
    /**
    {
        2014 =     (
                    1201,
                    1101,
                    1001,
                    0901,
                    0801,
                    0701
                    );
    }
     **/
}

+ (NSDateComponents *)componetsOfDate:(NSDate *)date{
    return [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
}

+ (NSDateComponents *)componetsOfDateStr:(NSString *)dateStr{
    NSDate *date = [self dateFromString:dateStr];
    return [self componetsOfDate:date];
}

+ (id)utcTimezone{
    return [NSTimeZone timeZoneWithName:@"UTC"];
//    [df setTimeZone:timeZone];
}

+ (NSDate *)dateFromString:(NSString *)dateStr{
    return [self dateFromString:dateStr withTimeZone:nil];
}

+ (NSDate *)dateFromString:(NSString *)dateStr withTimeZone:(NSTimeZone *)timeZone{
    NSString *value = dateStr;
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

@end
