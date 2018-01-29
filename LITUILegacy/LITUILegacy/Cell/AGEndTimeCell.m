//
//  AGFormEndTimeCell.m
//  AboveGEM
//
//  Created by traintrackcn on 14/7/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

@import LITCommon;

#import "AGEndTimeCell.h"
#import "AGDateSelector.h"
//#import "NSDate+AGUtils.h"


@implementation AGEndTimeCell

- (void)activateSelector{
    NSDate *value = [self value];
    AGDateSelector *picker = [AGDateSelector singleton];
    [picker setTitle:@"Select End Time"];
    [picker setAssociatedIndexPath:self.indexPath];
    [picker setContentView:[picker contentViewOfDateAndTimeFromNow:value]];
    [self pushViewController:picker];
}

- (void)setValue:(id)value{
    [super setValue:value];
    NSDate *d = (NSDate *)value;
    [contentLabel setText:d.textStyleDetail];
}

@end
