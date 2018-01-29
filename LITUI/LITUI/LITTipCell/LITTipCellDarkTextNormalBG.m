//
//  LITTipCellDarkNormalBG.m
//  iPhone
//
//  Created by Tao Yunfei on 26/09/2017.
//

@import LITUICommon;

#import "LITTipCellDarkTextNormalBG.h"

@implementation LITTipCellDarkTextNormalBG

//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        self.layer.borderWidth = 1;
//    }
//    return self;
//}

- (UIFont *)valueFont{
    return FONT_WITH_SIZE(15);
}

- (UIColor *)valueColor{
    return COLOR(RGB_TITLE);
}

- (CGFloat)paddingTB{
    return 10;
}



- (void)applyUnselectedStyle{
    [self setBackgroundColor:COLOR(RGB_BACKGROUND_NORMAL)];
}

@end
