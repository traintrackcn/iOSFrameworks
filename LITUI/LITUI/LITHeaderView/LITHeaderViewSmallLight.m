//
//  LITReviewOrderHeaderView.m
//  AboveGEM
//
//  Created by Tao Yunfei on 31/08/2017.
//
//

@import LITUICommon;

#import "LITHeaderViewSmallLight.h"

@interface LITHeaderViewSmallLight(){

}

@property (nonatomic, strong) UILabel *textL;

@end

@implementation LITHeaderViewSmallLight

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self addSubview:self.textL];
        //        self.textL.layer.borderWidth = 1;
        [self setBackgroundColor:COLOR(RGB_WHITE)];
        [self addSubview:self.borderTopViewStyleSolid];
    }
    return self;
}

#pragma mark - setters

- (void)setValue:(id)value{
    [self _setValue:value];
    [self.textL setText:[NSString stringWithFormat:@"%@", value]];
}

#pragma mark - components

- (UILabel *)textL{
    if (!_textL){
        CGFloat x = self.paddingLR;
        CGFloat w = STYLE_DEVICE_WIDTH - x*2;
        CGFloat y = 13.0;
        CGFloat h = self.height - y*2;
        _textL = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
        [_textL setFont:FONT_BOLD_WITH_SIZE(12.0)];
        //        [_textL setTextAlignment:NSTextAlignmentCenter];
        [_textL setTextColor:COLOR(RGB_TITLE_LIGHT)];
    }
    return _textL;
}

#pragma mark - styles

+ (CGFloat)height{
    return 40.0;
}

- (CGFloat)paddingLR{
    return STYLE_PADDING_LR_DEFAULT;
}

- (UIColor *)borderColor{
    return COLOR(RGB_BORDER);
}

@end
