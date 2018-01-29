//
//  LITHeaderViewMeidumDark.m
//  AboveGEM
//
//  Created by Tao Yunfei on 18/09/2017.
//
//

@import LITUICommon;

#import "LITHeaderViewMediumDark.h"

@implementation LITHeaderViewMediumDark

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.textL setFont:FONT_BOLD_WITH_SIZE(15)];
        [self.textL setTextColor:COLOR(RGB_TITLE_DARK)];
    }
    return self;
}

@end
