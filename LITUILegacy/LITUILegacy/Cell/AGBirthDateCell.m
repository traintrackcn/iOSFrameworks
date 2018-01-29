//
//  AGFormBirthDateCell.m
//  AboveGEM
//
//  Created by traintrackcn on 14/7/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

@import LITCommon;

#import "AGBirthDateCell.h"
#import "AGDateSelector.h"
//#import "NSDate+AGUtils.h"

@implementation AGBirthDateCell

- (void)activateSelector{
    NSDate *value = [self value];
    AGDateSelector *picker = [AGDateSelector singleton];
    [picker setTitle:@"Select Date of Birth"];
    [picker setAssociatedIndexPath:self.indexPath];
    [picker setContentView:[picker contentViewOfBirthday:value]];
    [self pushViewController:picker];
}

- (void)setValue:(id)value{
    [super setValue:value];
    NSDate *d = (NSDate *)value;
    [contentLabel setText:d.textStyleDefault];
}

@end
