//
//  AGPeriodSelector.m
//  AboveGEM
//
//  Created by traintrackcn on 12/8/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

@import LITCommon;

#import "AGPeriodSelector.h"
//#import "DSValueUtil.h"

@interface AGPeriodSelector (){
    NSInteger selectedYearRow;
    NSInteger selectedDateRow;
    NSArray *years;
}

@end

@implementation AGPeriodSelector


- (id)init{
    self = [super init];
    if (self) {
        selectedYearRow = 0;
        selectedDateRow = 0;
        [self addButtonWithTitle:@"Cancel" target:self selector:@selector(didTapCancel:)];
        [self addButtonWithTitle:@"Confirm" target:self selector:@selector(didTapConfirm:)];
    }
    return self;
}

#pragma mark - properties

- (void)setCollection:(NSDictionary *)collection{
    _collection = collection;
    years = collection.allKeys;
    
    //sort year in decend
    NSSortDescriptor* sortDes = [NSSortDescriptor sortDescriptorWithKey: @"self" ascending: NO];
    years = [years sortedArrayUsingDescriptors: [NSArray arrayWithObject: sortDes]];
}

- (NSString *)selectedYear{
    return [years objectAtIndex:selectedYearRow];
}

- (NSArray *)selectedDates{
    return [self.collection objectForKey:self.selectedYear];
}

- (NSString *)selectedDate{
    return [self.selectedDates objectAtIndex:selectedDateRow];
}

- (NSString *)value{
    NSString *yearText = self.selectedYear;
    NSString *dateText = self.selectedDate;
    return [NSString stringWithFormat:@"%@%@", yearText, dateText];
}

- (NSString *)dateForRow:(NSInteger)row{
    id value = [self.selectedDates objectAtIndex:row];
    return [NSString stringWithFormat:@"%@",value];
}

#pragma mark - picker action

- (UIView *)contentViewWithValue:(id)value{
    UIPickerView* picker = [[UIPickerView alloc] initWithFrame:CGRectMake(10, 40, 264, 240)];
    picker.showsSelectionIndicator = TRUE;
    picker.dataSource = self;
    picker.delegate = self;
    
    
    NSString *selectedYear = [(NSString *)value substringToIndex:4];
    NSString *selectedDate = [(NSString *)value substringFromIndex:4];
    
//    TLOG(@"selectedYear -> %@ selectedDate -> %@", selectedYear, selectedDate);
    
    for (NSInteger i = 0; i<years.count; i++) {
        NSString *year = [years objectAtIndex:i];
//        TLOG(@"year -> %@", year);
        if ([year isEqualToString:selectedYear]){
            selectedYearRow = i;
            break;
        }
    }
    
    for (NSInteger i = 0; i<self.selectedDates.count;i++){
        NSString *date = [NSString stringWithFormat:@"%@", [self.selectedDates objectAtIndex:i]];
//        TLOG(@"date -> %@", date);
        if ([date isEqualToString:selectedDate]) {
            selectedDateRow = i;
            break;
        }
    }
    
    
    [picker selectRow:selectedYearRow inComponent:0 animated:false];
    [picker selectRow:selectedDateRow inComponent:1 animated:false];
    return picker;
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
            return [DSValueUtil isAvailable:years]?years.count: 0;
            break;
        case 1:
            return [DSValueUtil isAvailable:self.selectedDates]?self.selectedDates.count: 0 ;
            break;
        default:
            return 0;
            break;
    }
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;{
    switch (component) {
        case 0:
            return [years objectAtIndex:row];
            break;
        case 1:
            return [self dateForRow:row];
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
            selectedYearRow = row;
            [pickerView reloadAllComponents];
            selectedDateRow = 0;
            [pickerView selectRow:0 inComponent:1 animated:NO];
            break;
        case 1:
            selectedDateRow = row;
            break;
        default:
            break;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView selectedRowInComponent:(NSInteger)component;
{
    switch (component) {
        case 0:
            return selectedYearRow;
            break;
        case 1:
            return selectedDateRow;
            break;
        default:
            return -1;
            break;
    }
}


#pragma mark - interactive actions

- (void)didTapCancel:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didTapConfirm:(id)sender{
    [self setValueForAssociatedIndexPath:self.value];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
