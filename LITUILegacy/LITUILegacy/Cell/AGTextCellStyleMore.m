//
//  AGCommissionRankSummaryCell.m
//  AboveGEM
//
//  Created by traintrackcn on 13/8/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

@import LITCommon;
@import LITUICommon;

#import "AGTextCellStyleMore.h"

//#import "DSValueUtil.h"

@implementation AGTextCellStyleMore

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        paddingLR = 15.0;
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        
        
        [self.contentView addSubview:self.borderBottomViewStylePaddingL];
        [self.textLabel setTextColor:COLOR(UI.RGB_CELL_TITLE_NORMAL)];
        [self.textLabel setFont:FONT_WITH_SIZE(16)];
        [self.textLabel setAdjustsFontSizeToFitWidth:YES];
    }
    return self;
}

- (CGFloat)paddingLR{
    return 15.0;
}

- (void)setValue:(id)value{
    [super setValue:value];
    [self.textLabel setText:[DSValueUtil toString:value]];
}

#pragma mark - 

- (void)applyUnselectedStyle{
    [self setBackgroundColor:COLOR(RGB_WHITE)];
}

@end
