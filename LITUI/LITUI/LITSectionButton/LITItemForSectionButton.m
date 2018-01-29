//
//  LITItemForSectionButton.m
//  iPhone
//
//  Created by Tao Yunfei on 26/09/2017.
//

@import LITUICommon;

#import "LITItemForSectionButton.h"

@implementation LITItemForSectionButton

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setPaddingT:10];
        [self setPaddingB:10];
    }
    return self;
}

- (UIFont *)titleFont{
    if (!_titleFont) return FONT_WITH_SIZE(16.0);
    return _titleFont;
}

- (UIColor *)titleColor{
    if (!_titleColor) return COLOR(RGB_TITLE);
    return _titleColor;
}

- (NSString *)title{
    if (!_title) return @"";
    return _title;
}

@end
