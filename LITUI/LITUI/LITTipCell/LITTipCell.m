//
//  LITCellTip.m
//  AboveGEM
//
//  Created by Tao Yunfei on 31/08/2017.
//
//

@import LITUICommon;

#import "LITTipCell.h"

@interface LITTipCell(){
    
}

@property (nonatomic, strong) UILabel *valueL;

@end

@implementation LITTipCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier associatedVC:(id)associatedVC indexPath:(NSIndexPath *)indexPath{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier associatedVC:associatedVC indexPath:indexPath];
    if (self) {
        [self.contentView addSubview:self.valueL];
    }
    return self;
}

#pragma mark - 

- (void)setValue:(id)value{
    [self _setValue:value];
    [self.valueL setText:[NSString stringWithFormat:@"%@" ,value]];
    CGFloat x = self.paddingLR;
    CGFloat w = STYLE_DEVICE_WIDTH - x*2;
    CGFloat y = self.paddingT;
    CGSize s = [self.valueL sizeThatFits:CGSizeMake(w, CGFLOAT_MAX)];
    CGFloat h = s.height;
    CGFloat cellH = s.height + self.paddingT + self.paddingB;
    [self setHeight:cellH];
    [self.valueL setFrame:CGRectMake(x, y, w, h)];
}

#pragma mark - 

- (UILabel *)valueL{
    if (!_valueL){
        _valueL = [[UILabel alloc] init];
        [_valueL setFont:self.valueFont];
        [_valueL setTextColor:self.valueColor];
        [_valueL setNumberOfLines:0];
        [_valueL setTextAlignment:self.valueAlignment];
    }
    return _valueL;
}

#pragma mark - styles

- (CGFloat)paddingLR{
    return STYLE_PADDING_LR_DEFAULT;
}

- (CGFloat)paddingTB{
    return 5.0;
}

- (CGFloat)paddingT{
    return self.paddingTB;
}

- (CGFloat)paddingB{
    return self.paddingTB;
}

- (UIFont *)valueFont{
    return FONT_WITH_SIZE(13.0);
}

- (UIColor *)valueColor{
    return COLOR(RGB_TITLE_LIGHT);
}

- (NSTextAlignment)valueAlignment{
    return NSTextAlignmentLeft;
}

- (void)applySelectedStyle{

}

- (void)applyUnselectedStyle{
    [self setBackgroundColor:COLOR(RGB_WHITE)];
}

@end
