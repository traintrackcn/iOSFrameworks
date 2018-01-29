//
//  NSDate+AGText.h
//  AboveGEM
//
//  Created by traintrackcn on 9/7/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (AGUtils)

- (NSString *)textStyleShort;
- (NSString *)textStyleDefault;
- (NSString *)textStyleDefaultWithTimeZone:(NSTimeZone *)timeZone;
- (NSString *)textStyleDetail;
- (NSString *)textStyleDetailWithTimeZone:(NSTimeZone *)timeZone;
- (NSString *)textStyleForPost;
- (NSString *)textStyleForPostAutoshipDate;
- (NSString *)textStyleShortDetail;
- (NSString *)textStyleDateAndTime;

- (NSString *)valueForPost;
- (NSString *)valueForPostStyleUTC;
//- (NSString *)valueForPostWithTimezone:(NSTimeZone *)timezone;

- (NSInteger)daysToOtherDate:(NSDate *)otherDate;

@end
