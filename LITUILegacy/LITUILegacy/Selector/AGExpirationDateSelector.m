//
//  AGExpirationDateSelector.m
//  AboveGEM
//
//  Created by traintrackcn on 15/7/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

@import LITCommon;

#import "AGExpirationDateSelector.h"
//#import "DSValueUtil.h"
//#import "DSDeviceUtil.h"
#import "AGAssembler.h"

@interface AGExpirationDateSelector (){
    NSArray *months;
    NSMutableArray *years;
    NSInteger selectedYearIndex;
    NSInteger selectedMonthIndex;
}

@end

@implementation AGExpirationDateSelector


- (id)init{
    self = [super init];
    if (self) {
        
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *comps = [gregorian components:NSYearCalendarUnit fromDate:[NSDate date]];
        NSInteger year = [comps year];
        years = [NSMutableArray array];
        for (NSInteger y = year; y < year + 15; y++) {
            [years addObject:[NSString stringWithFormat:@"%ld", (long)y]];
        }
        
        months = [NSArray arrayWithObjects:
                       @"January",
                       @"February",
                       @"March",
                       @"April",
                       @"May",
                       @"June",
                       @"July",
                       @"August",
                       @"September",
                       @"October",
                       @"November",
                       @"December",
                       nil];
        
        [self addButtonWithTitle:@"Cancel" target:self selector:@selector(didTapCancel:)];
        [self addButtonWithTitle:@"Confirm" target:self selector:@selector(didTapConfirm:)];
    }
    return self;
}

- (UIView *)contentViewWithValue:(NSDate *)value{
    
    //convert date to selectedYearIndex selectedMonthIndex
    if ([DSValueUtil isAvailable:value]) {
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSMonthCalendarUnit|NSYearCalendarUnit fromDate:value];
        selectedYearIndex = [self indexOfYearText:[NSString stringWithFormat:@"%ld", (long)components.year]];
        selectedMonthIndex = components.month - 1;
    }
    
    if (selectedYearIndex == 0) {
        if (self.nowMonthIndex > selectedMonthIndex) selectedMonthIndex = self.nowMonthIndex;
    }
    
    UIPickerView *view = [[UIPickerView alloc] initWithFrame:CGRectMake(10, 40, [DSDeviceUtil bounds].size.width, 240)];
    view.showsSelectionIndicator = YES;
    view.dataSource = self;
    view.delegate = self;
    [view selectRow:selectedYearIndex inComponent:0 animated:false];
    [view selectRow:selectedMonthIndex inComponent:1 animated:false];
    [view setBackgroundColor:[UIColor clearColor]];
    
    
    
    
    return view;
}

- (void)makeSureSelectedTimeIsNewerThanNowTime{
    
//#ifdef DEBUG
//    return;
//#endif
    
    UIPickerView *picker = (UIPickerView *)self.contentView;
    
    
    if (selectedYearIndex == 0) {
        if (self.nowMonthIndex > selectedMonthIndex) {
            selectedMonthIndex = self.nowMonthIndex;
            [picker selectRow:selectedMonthIndex inComponent:1 animated:YES];
        }
    }
}

#pragma mark - properties

- (NSInteger)indexOfYearText:(NSString *)yearText{
    for (int i=0; i<years.count; i++) {
        if ([yearText isEqualToString:[self yearTextForIndex:i]]) {
            return i;
        }
    }
    return -1;
}

- (NSString *)yearTextForIndex:(NSInteger)index{
    return [years objectAtIndex:index];
}

- (NSString *)monthTextForIndex:(NSInteger)index{
    return [months objectAtIndex:index];
}

- (NSInteger)nowMonthIndex{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSMonthCalendarUnit fromDate:[NSDate date]];
    return  [components month] - 1;
}

#pragma mark - UIPickerViewDelegate & UIPickerViewDataSource

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return years.count;
            break;
        case 1:
            return 12;
        default:
            return 0;
            break;
    }
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;{
    switch (component) {
        case 0:
            return [self yearTextForIndex:row];
            break;
        case 1:
            return [self monthTextForIndex:row];
            break;
        default:
            return @"";
            break;
    }
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            selectedYearIndex = row;
            [pickerView reloadAllComponents];
            selectedMonthIndex = 0;
            [pickerView selectRow:0 inComponent:1 animated:YES];
            break;
        case 1:
            selectedMonthIndex = row;
            break;
        default:
            break;
    }
    
    

    [self makeSureSelectedTimeIsNewerThanNowTime];
    
}

//- (void)detectMost

- (NSInteger)pickerView:(UIPickerView *)pickerView selectedRowInComponent:(NSInteger)component;
{
    switch (component) {
        case 0:
            return selectedYearIndex;
            break;
        case 1:
            return selectedMonthIndex;
            break;
        default:
            return -1;
            break;
    }
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* tView = (UILabel*)view;
    
    NSString *title = [self pickerView:pickerView titleForRow:row forComponent:component];
    if (!tView){
        tView = [AGAssembler assembleLabelForPickerView];
    }
    
    [tView setText:title];
    
    return tView;
}

#pragma mark - interactive actions

- (void)didTapCancel:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didTapConfirm:(id)sender{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString *yearText = [years objectAtIndex:selectedYearIndex];
    NSInteger monthForRead = selectedMonthIndex+1;
    NSString *monthText = [NSString stringWithFormat:@"%ld",(long)monthForRead];
    NSDate *dateNew = [df dateFromString:[NSString stringWithFormat:@"%@-%@-01", yearText, monthText]];
    [self setValueForAssociatedIndexPath:dateNew];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
