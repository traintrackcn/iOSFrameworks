//
//  NSDate+AGText.m
//  AboveGEM
//
//  Created by traintrackcn on 9/7/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import "NSDate+AGUtils.h"
#import "AGDateUtil.h"

@implementation NSDate (AGUtils)


- (NSString *)textStyleShort{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:[NSDateFormatter dateFormatFromTemplate:@"yyyyMMM" options:0 locale:[NSLocale currentLocale]]];
    
    return [dateFormatter stringFromDate:self];
}

- (NSString *)textStyleShortDetail{
    return [NSDateFormatter localizedStringFromDate:self dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
}

- (NSString *)textStyleDefault{
    return [NSDateFormatter localizedStringFromDate:self dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterNoStyle];
}

- (NSString *)textStyleDefaultWithTimeZone:(NSTimeZone *)timeZone{
//    NSDateFormatter *df = [NSDateFormatter localizedStringFromDate:self dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterNoStyle];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateStyle:NSDateFormatterMediumStyle];
    [df setTimeStyle:NSDateFormatterNoStyle];
    if (timeZone) [df setTimeZone:timeZone];
    return [df stringFromDate:self];
}

- (NSString *)textStyleDetail{
    return [NSDateFormatter localizedStringFromDate:self dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterShortStyle];
}

- (NSString *)textStyleDetailWithTimeZone:(NSTimeZone *)timeZone{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateStyle:NSDateFormatterMediumStyle];
    [df setTimeStyle:NSDateFormatterShortStyle];
    if (timeZone) [df setTimeZone:timeZone];
    return [df stringFromDate:self];
}

- (NSString *)textStyleDateAndTime{
    NSDateFormatter *dfDate = [[NSDateFormatter alloc] init];
    [dfDate setDateFormat:@"MM-dd"];
    
    NSDateFormatter *dfTime = [[NSDateFormatter alloc] init];
    [dfTime setDateFormat:@"HH:mm"];
    
    return  [NSString stringWithFormat:@"%@ %@", [dfDate stringFromDate:self], [dfTime stringFromDate:self]];
}

- (NSString *)textStyleForPost{
    NSDateFormatter *dfDate = [[NSDateFormatter alloc] init];
    [dfDate setDateFormat:@"yyyy-MM-dd"];
    
    NSDateFormatter *dfTime = [[NSDateFormatter alloc] init];
    [dfTime setDateFormat:@"HH:mm"];
    
    return  [NSString stringWithFormat:@"%@T%@", [dfDate stringFromDate:self], [dfTime stringFromDate:self]];
}


- (NSString *)valueForPost{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    return  [df stringFromDate:self];
}

- (NSString *)valueForPostStyleUTC{
    NSDateFormatter *dfDate = [[NSDateFormatter alloc] init];
    [dfDate setTimeZone:[self utcTimezone]];
    [dfDate setDateFormat:@"yyyy-MM-dd"];
    
    NSDateFormatter *dfTime = [[NSDateFormatter alloc] init];
    [dfTime setTimeZone:[self utcTimezone]];
    [dfTime setDateFormat:@"HH:mm:ss"];
    return  [NSString stringWithFormat:@"%@T%@Z", [dfDate stringFromDate:self], [dfTime stringFromDate:self]];
}

- (NSString *)textStyleForPostAutoshipDate{
    NSDateFormatter *dfDate = [[NSDateFormatter alloc] init];
    [dfDate setDateFormat:@"yyyy-MM-dd"];
    return  [NSString stringWithFormat:@"%@", [dfDate stringFromDate:self]];
}

#pragma mark - properties

- (id)utcTimezone{
    return [NSTimeZone timeZoneWithName:@"UTC"];
    //    [df setTimeZone:timeZone];
}

- (NSInteger)daysToOtherDate:(NSDate *)otherDate{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay fromDate:self toDate:otherDate options:0];
    return [components day];
}

@end
