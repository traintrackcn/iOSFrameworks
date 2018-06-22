//
//  AGLabelStyleTextCell.m
//  AboveGEM
//
//  Created by Tao Yunfei on 4/27/15.
//
//

@import LITCommon;
@import LITUICommon;

#import "AGLabelStyleTextCell.h"

@implementation AGLabelStyleTextCell

- (void)willMoveToSuperview:(UIView *)newSuperview{
    if (newSuperview) {
        [self assemble];
    }
}

- (void)assemble{
    [self addSubview:self.textLabel];
    [self addSubview:self.detailTextLabel];
    if (self.borderEnabled) {
        [self addSubview:self.borderBottomView];
    }
}

#pragma mark - setters

- (void)setValue:(id)value{
    NSString *text = [DSValueUtil toString:value];
    [self.detailTextLabel setText:text];
}

- (void)setTitle:(NSString *)title{
    if (!title) return;
    [self.textLabel setText:title];
}

#pragma mark - components

- (UILabel *)textLabel{
    if (!_textLabel) {
        CGFloat x = self.paddingLR;
        CGFloat y = 0;
        CGFloat w = (self.frame.size.width-self.paddingLR*2)*self.textLabelWidthPercentage;
        CGFloat h = self.height;
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
        [_textLabel setTextColor:self.textColor];
        [_textLabel setNumberOfLines:0];
        [_textLabel setAdjustsFontSizeToFitWidth:YES];
        [_textLabel setFont:self.textFont];
//                [AGDebugUtil makeBorderForView:_textLabel];
//        [_textLabel setText:@"Title"];
    }
    return _textLabel;
}

- (UILabel *)detailTextLabel{
    if (!_detailTextLabel) {
        CGFloat w = (self.frame.size.width-self.paddingLR*2)*self.detailTextLabelWidthPercentage;
        CGFloat x = self.textLabel.frame.origin.x + self.textLabel.frame.size.width;
        CGFloat y = 0;
        CGFloat h = self.height;
        _detailTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
        [_detailTextLabel setTextColor:self.detailTextColor];
        [_detailTextLabel setFont:self.detailTextFont];
        [_detailTextLabel setAdjustsFontSizeToFitWidth:YES];
        [_detailTextLabel setNumberOfLines:0];
        [_detailTextLabel setTextAlignment:NSTextAlignmentRight];
//                [AGDebugUtil makeBorderForView:_detailTextLabel];
    }
    return _detailTextLabel;
}

- (UIView *)borderBottomView{
    if (!_borderBottomView) {
        CGFloat x = self.paddingLR;
        CGFloat h = self.borderWidth;
        CGFloat y = self.height - h;
        CGFloat w = self.frame.size.width - x*2;
        _borderBottomView = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        [_borderBottomView setBackgroundColor:self.borderColor];
    }
    return _borderBottomView;
}

#pragma mark - styles

- (CGFloat)paddingLR{
    return 15.0;
}

- (CGFloat)height{
    return self.frame.size.height;
}

- (UIFont *)textFont{
    return FONT_WITH_SIZE(16);
}

- (UIFont *)detailTextFont{
    return FONT_WITH_SIZE(16);
}

- (UIColor *)textColor{
    return RGBA(153, 153, 153, 1);
}

- (UIColor *)detailTextColor{
    return COLOR(UI.RGB_CELL_TITLE_NORMAL);
}

- (UIColor *)borderColor{
    return COLOR(UI.RGB_CELL_BORDER);
}

- (CGFloat)borderWidth{
    return .5f;
}

- (CGFloat)textLabelWidthPercentage{
    return .7f;
}

- (CGFloat)detailTextLabelWidthPercentage{
    return 1 - self.textLabelWidthPercentage;
}

@end
