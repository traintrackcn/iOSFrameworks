//
//  AGExpirationDateSelector.h
//  AboveGEM
//
//  Created by traintrackcn on 15/7/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import "AGSelector.h"

@interface AGExpirationDateSelector : AGSelector <UIPickerViewDelegate, UIPickerViewDataSource>

- (UIView *)contentViewWithValue:(NSDate *)value;

@end
