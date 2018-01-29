//
//  AGQuantityPicker.h
//  AboveGEM
//
//  Created by traintrackcn on 18/3/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AGSelector.h"

@interface AGQuantitySelector : AGSelector

- (UIView *)contentViewWithValue:(NSInteger)value minValue:(NSInteger)minValue;
- (UIView *)contentViewWithValue:(NSInteger)value maxValue:(NSInteger)maxValue;

@end
