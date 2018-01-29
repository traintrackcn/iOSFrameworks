//
//  LITTipCellCenterDark.m
//  AboveGEM
//
//  Created by Tao Yunfei on 21/09/2017.
//
//

@import LITUICommon;

#import "LITTipCellCenterDark.h"

@implementation LITTipCellCenterDark

- (NSTextAlignment)valueAlignment{
    return NSTextAlignmentCenter;
}

- (UIFont *)valueFont{
    return FONT_WITH_SIZE(15);
}

- (UIColor *)valueColor{
    return COLOR(RGB_TITLE);
}

- (CGFloat)paddingTB{
    return 18.0;
}


- (void)applyUnselectedStyle{
    [self setBackgroundColor:COLOR(RGB_BACKGROUND_NORMAL)];
}

@end
