//
//  AGDatePicker.m
//  AboveGEM
//
//  Created by traintrackcn on 9/7/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

@import LITCommon;

#import "AGDateSelector.h"
#import "AGViewController.h"
#import "AGVCConfiguration.h"
//#import "DSValueUtil.h"
//#import "DSDeviceUtil.h"

@interface AGDateSelector (){
    
}

@end

@implementation AGDateSelector


#pragma mark - init

- (id)init{
    self = [super init];
    if (self) {
        [self addButtonWithTitle:@"Cancel" target:self selector:@selector(didTapCancel:)];
        [self addButtonWithTitle:@"Confirm" target:self selector:@selector(didTapConfirm:)];
    }
    return self;
}

#pragma mark - kinds of content views

- (UIView *)contentViewOfDateAndTimeFromNow:(NSDate *)value{
    UIDatePicker *v = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 64, [DSDeviceUtil bounds].size.width, 100)];
    [v setDatePickerMode:UIDatePickerModeDateAndTime];
    NSDate *date1YearsLater  = [NSDate dateWithTimeIntervalSinceNow:self.interval1YearLater*1];
    NSDate *dateNow = [NSDate dateWithTimeIntervalSinceNow:0];
    [v setMinimumDate:dateNow];
    [v setMaximumDate:date1YearsLater];
//    [v setDate:self.config.defaultDate];
    if (value) [v setDate:value];
    return v;
}


- (UIView *)contentViewOfDateFromNow:(NSDate *)value{
    UIDatePicker *v = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 64, [DSDeviceUtil bounds].size.width, 100)];
    [v setDatePickerMode:UIDatePickerModeDate];
    NSDate *date1YearsLater  = [NSDate dateWithTimeIntervalSinceNow:self.interval1YearLater*1];
    NSDate *dateNow = [NSDate dateWithTimeIntervalSinceNow:0];
    [v setMinimumDate:dateNow];
    [v setMaximumDate:date1YearsLater];
    //    [v setDate:self.config.defaultDate];
    if (value) [v setDate:value];
    return v;
}

- (UIView *)contentViewOfBirthday:(NSDate *)value{
    UIDatePicker *v = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, [DSDeviceUtil bounds].size.width, 200)];
    [v setDatePickerMode:UIDatePickerModeDate];
    float interval18YearsAgo = self.interval1YearAgo*18;
    float interval100YearsAgo = self.interval1YearAgo*100;
    NSDate *date100YearsAgo  = [NSDate dateWithTimeIntervalSinceNow:interval100YearsAgo];
    NSDate *date18YearsAgo = [NSDate dateWithTimeIntervalSinceNow:interval18YearsAgo];
    
    [v setMinimumDate:date100YearsAgo];
    [v setMaximumDate:date18YearsAgo];
    
    if ([DSValueUtil isAvailable:value]) {
        [v setDate:value];
    }else{
        [v setDate:[self defaultDate]];
    }
    
    return v;
}

#pragma mark - properties

- (CGFloat)interval1YearAgo{
    return -31556926;
}

- (CGFloat)interval1YearLater{
    return - self.interval1YearAgo;
}

- (NSDate *)date30YearsAgo{
    //    float interval1YearAge = -31556926;
    float interval30YearsAgo = self.interval1YearAgo*30;
    NSDate *date30YearsAgo = [NSDate dateWithTimeIntervalSinceNow:interval30YearsAgo];
    return date30YearsAgo;
}

- (NSDate *)defaultDate{
    return [self date30YearsAgo];
}


#pragma mark - interactive actions

- (void)didTapCancel:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didTapConfirm:(id)sender{
    UIDatePicker *cView = (UIDatePicker *)[self.contentView.subviews objectAtIndex:0];
    NSDate *dateNew = [cView date];
    [self setValueForAssociatedIndexPath:dateNew];
    [self setNeedsReloadAssociatedIndexPath];
    [self.navigationController popViewControllerAnimated:YES];
}



@end
