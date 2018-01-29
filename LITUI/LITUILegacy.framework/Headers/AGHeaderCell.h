//
//  AGHeaderCell.h
//  AboveGEM
//
//  Created by traintrackcn on 16/8/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import "AGCell.h"

@interface AGHeaderCell : AGCell{
    UILabel *titleLabel;
}

#pragma mark - styles
- (UIColor *)titleColor;
- (UIFont *)titleFont;

@end
