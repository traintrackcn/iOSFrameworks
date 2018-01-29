//
//  AGDatePicker.h
//  AboveGEM
//
//  Created by traintrackcn on 9/7/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AGSelector.h"

@class AGVCConfiguration;

@interface AGDateSelector : AGSelector


- (UIView *)contentViewOfDateAndTimeFromNow:(NSDate *)value;
- (UIView *)contentViewOfDateFromNow:(NSDate *)value;
- (UIView *)contentViewOfBirthday:(NSDate *)value;


@end
