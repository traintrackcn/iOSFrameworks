//
//  LITCheckBoxHeaderView.m
//  AboveGEM
//
//  Created by Tao Yunfei on 27/08/2017.
//
//

@import LITUICommon;
@import BEMCheckBox;

#import "LITHeaderViewTitledCheckBox.h"

@interface LITHeaderViewTitledCheckBox(){
    
}

@property (nonatomic, strong) BEMCheckBox *checkBox;
@property (nonatomic, strong) UILabel *titleL;
@property (nonatomic, strong) UILabel *mainTitleL;

@end

@implementation LITHeaderViewTitledCheckBox

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self addSubview:self.checkBox];
        [self addSubview:self.titleL];
        [self addSubview:self.mainTitleL];
        [self addGestureRecognizer:self.tapGestureRecognizer];
        [self setBackgroundColor:COLOR(RGB_BACKGROUND_NORMAL)];
        [self addSubview:self.borderBottomViewStyleSolid];
    }
    return self;
}

- (void)didTapAny:(id)sender{
    [self.checkBox setOn:!self.checkBox.on animated:YES];
    [self sendActionRequestToViewController:@(self.checkBox.on)];
}

#pragma mark - setters

- (void)setValue:(id)value{
    if (!value) return;
    BOOL checked = [value boolValue];
    [self.checkBox setOn:checked];
}

- (void)setTitle:(id)title{
    if (title && ![title isKindOfClass:[NSArray class]]) return;
    NSArray *arr = title;
    [self.mainTitleL setText:arr.firstObject];
    [self.titleL setText:[NSString stringWithFormat:@"%@", arr.lastObject]];
    
}

#pragma mark - components

- (BEMCheckBox *)checkBox{
    if (!_checkBox) {
        CGFloat w = self.checkBoxW;
        CGFloat h = w;
        CGFloat x = self.paddingLR;
        CGFloat y = (self.height - self.mainTitleAreaH - h)/2.0 + self.mainTitleAreaH;
        _checkBox = [[BEMCheckBox alloc] initWithFrame:CGRectMake(x, y, w, h)];
        [_checkBox setOnAnimationType:BEMAnimationTypeBounce];
        [_checkBox setOffAnimationType:BEMAnimationTypeBounce];
        [_checkBox setTintColor:COLOR(RGB_SUBTITLE)];
        [_checkBox setOnTintColor:COLOR(RGB_CHECK_BOX_ON_TINT)];
        [_checkBox setOnFillColor:COLOR(RGB_CHECK_BOX_ON_FILL)];
        [_checkBox setOnCheckColor:COLOR(RGB_WHITE)];
        [_checkBox setBoxType:BEMBoxTypeSquare];
        [_checkBox setUserInteractionEnabled:NO];
        //        [_checkBox setOn:NO];
    }
    return _checkBox;
}

- (UILabel *)titleL{
    if (!_titleL){
        CGFloat x = self.paddingLR*2 + self.checkBoxW;
        CGFloat y = self.mainTitleAreaH;
        CGFloat w = STYLE_DEVICE_WIDTH - x - self.paddingLR;
        CGFloat h = self.height - y;
        _titleL = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
        [_titleL setFont:FONT_BOLD_WITH_SIZE(12.0)];
        [_titleL setTextColor:COLOR(RGB_TITLE_LIGHT)];
        [_titleL setAdjustsFontSizeToFitWidth:YES];
    }
    return _titleL;
}

- (UILabel *)mainTitleL{
    if (!_mainTitleL){
        CGFloat x = self.paddingLR;
        CGFloat y = 15;
        CGFloat w = STYLE_DEVICE_WIDTH - x*2;
        CGFloat h = 15;
        _mainTitleL = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
        [_mainTitleL setTextColor:COLOR(RGB_TITLE_LIGHT)];
        [_mainTitleL setFont:FONT_BOLD_WITH_SIZE(12.0)];
        [_mainTitleL setAdjustsFontSizeToFitWidth:YES];
    }
    return _mainTitleL;
}

#pragma mark - styles

+ (CGFloat)height{
    return 80.0;
}

- (CGFloat)checkBoxW{
    return 20.0;
}

- (CGFloat)mainTitleAreaH{
    return 30.0;
}

- (CGFloat)checkBoxH{
    return self.checkBoxW;
}

- (CGFloat)paddingLR{
    return STYLE_PADDING_LR_DEFAULT;
}

- (UIColor *)borderColor{
    return COLOR(RGB_BORDER);
}


@end
