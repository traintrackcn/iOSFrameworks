//
//  LITMultiLineTextCell.m
//  AboveGEM
//
//  Created by Tao Yunfei on 09/09/2017.
//
//

@import LITUICommon;

#import "LITTextCellMultiLine.h"
#import "LITCell+Borders.h"

@interface LITTextCellMultiLine(){

}

@property (nonatomic, strong) UILabel *titleL;
@property (nonatomic, strong) UILabel *valueL;

@end

@implementation LITTextCellMultiLine

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier associatedVC:(id)associatedVC indexPath:(NSIndexPath *)indexPath{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier associatedVC:associatedVC indexPath:indexPath];
    if (self){
        [self.contentView addSubview:self.titleL];
        [self.contentView addSubview:self.valueL];
//        [self.contentView addGestureRecognizer:self.tapGestureRecognizer];
//        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
//                self.titleL.layer.borderWidth = 1;
//                self.valueL.layer.borderWidth = 1;
        
        [self initializeDefaultBorders];
    }
    return self;
}

#pragma mark - 

- (void)didTapAny:(id)sender{
    [self sendActionRequestToViewController:nil];
}

#pragma mark - setters

- (void)setTitle:(NSString *)title{
    [self _setTitle:title];
    
    [self.titleL setText:[NSString stringWithFormat:@"%@",title?title:@""]];
    
    //layout
    CGFloat x = self.paddingLR;
    CGFloat y = self.paddingTB;
    CGFloat w = self.titleW;
    CGSize size = [self.titleL sizeThatFits:CGSizeMake(w, CGFLOAT_MAX)];
    CGFloat h = size.height;
    [self setHeight:h+y*2];
    [self.titleL setFrame:CGRectMake(x, y, w, h)];
//    TLOG(@"cellH by title -> %@", @(self.height));
}

- (void)setValue:(id)value{
    [self _setValue:value];
    [self.valueL setText:[NSString stringWithFormat:@"%@",value?value:@""]];
    
    //layout
    CGFloat x = self.paddingLR + self.titleW;
    CGFloat y = self.paddingTB;
    CGFloat w = self.valueW;
    CGSize size = [self.valueL sizeThatFits:CGSizeMake(w, CGFLOAT_MAX)];
    CGFloat h = size.height;
    CGFloat cellHExpect = h+y*2;
    
    if (cellHExpect > self.height) [self setHeight:cellHExpect];
    [self.valueL setFrame:CGRectMake(x, y, w, h)];
//    TLOG(@"cellH by value -> %@", @(self.height));
    [self layoutDefaultBordersByFlag];
}

#pragma mark - components

- (UILabel *)titleL{
    if (!_titleL){
        CGFloat x = self.paddingLR;
        CGFloat y = self.paddingTB;
        CGFloat w = self.titleW;
        CGFloat h = self.height;
        _titleL = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
        [_titleL setFont:FONT_WITH_SIZE(16.0)];
        [_titleL setNumberOfLines:0];
        [_titleL setTextColor:COLOR(RGB_TITLE)];
    }
    return _titleL;
}

- (UILabel *)valueL{
    if (!_valueL){
        CGFloat x = self.paddingLR + self.titleW;
        CGFloat y = self.paddingTB;
        CGFloat w = self.valueW;
        CGFloat h = self.height;
        _valueL = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
        [_valueL setFont:FONT_WITH_SIZE(14.0)];
        [_valueL setNumberOfLines:0];
        [_valueL setTextColor:COLOR(RGB_TITLE)];
        [_valueL setTextAlignment:NSTextAlignmentRight];
    }
    return _valueL;
}

#pragma mark - styles

+ (CGFloat)height{
    return 60.0;
}

- (UIColor *)borderColor{
    return COLOR(RGB_BORDER);
}

- (CGFloat)titleW{
    return STYLE_DEVICE_WIDTH/3.0 - self.paddingLR;
}

- (CGFloat)valueW{
    return (STYLE_DEVICE_WIDTH/3.0)*2.0 - self.paddingLR;
}

- (CGFloat)paddingTB{
    return 12.0;
}

- (CGFloat)paddingLR{
    return STYLE_PADDING_LR_DEFAULT;
}

- (void)applyUnselectedStyle{
    [self setBackgroundColor:COLOR(RGB_WHITE)];
}

- (void)applySelectedStyle{
    
}

@end
