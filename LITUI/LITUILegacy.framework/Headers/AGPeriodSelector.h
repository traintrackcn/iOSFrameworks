//
//  AGPeriodSelector.h
//  AboveGEM
//
//  Created by traintrackcn on 12/8/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import "AGSelector.h"

@interface AGPeriodSelector : AGSelector <UIPickerViewDataSource, UIPickerViewDelegate>

- (NSString *)value;
- (UIView *)contentViewWithValue:(id)value;

@property (nonatomic, strong) NSDictionary *collection;


@end
