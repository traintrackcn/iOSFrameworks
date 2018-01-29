//
//  DSDateUtil.h
//  og
//
//  Created by traintrackcn on 13-10-16.
//  Copyright (c) 2013 2ViVe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AGDateUtil : NSObject

+ (NSString *)defaultValueOfPeriodCollection:(NSDictionary *)periodCollection;

//+ (NSTimeZone *)utcTimezone;

+ (NSString *)formatCreditCardExpirationDate:(NSString *)date;
+ (NSString *)formatToYYYYMinusMMinusDDForYYYYMMDD:(NSString *)date;

+ (id)periodCollectionStartFrom:(NSString *)date;

+ (NSDateComponents *)componetsOfDate:(NSDate *)date;
+ (NSDateComponents *)componetsOfDateStr:(NSString *)dateStr;
+ (NSDate *)dateFromString:(NSString *)dateStr;
+ (NSDate *)dateFromString:(NSString *)dateStr withTimeZone:(NSTimeZone *)timeZone;

@end
