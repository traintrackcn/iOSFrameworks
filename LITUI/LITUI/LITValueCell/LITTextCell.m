//
//  LITTextCell.m
//  AboveGEM
//
//  Created by Tao Yunfei on 31/08/2017.
//
//

@import LITUICommon;

#import "LITTextCell.h"
#import "LITCell+Borders.h"

@interface LITTextCell(){

}

@property (nonatomic, strong) UILabel *titleL;
@property (nonatomic, strong) UILabel *valueL;

@end

@implementation LITTextCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier associatedVC:(id)associatedVC indexPath:(NSIndexPath *)indexPath{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier associatedVC:associatedVC indexPath:indexPath];
    if (self){
        [self.contentView addSubview:self.titleL];
        [self.contentView addSubview:self.valueL];
        
//        self.titleL.layer.borderWidth = 1;
//        self.valueL.layer.borderWidth = 1;
//        self.layer.borderWidth = 1;
        [self initializeDefaultBorders];
    }
    return self;
}

#pragma mark - setters

- (void)setTitle:(NSString *)title{
    [self _setTitle:title];
    
    [self.titleL setText:[NSString stringWithFormat:@"%@",title]];
    
    //layout
    CGFloat x = self.titleL.frame.origin.x;
    CGFloat w = self.titleL.frame.size.width;
    CGSize size = [self.titleL sizeThatFits:CGSizeMake(w, CGFLOAT_MAX)];
    CGFloat h = size.height;
    CGFloat y = (self.height - h)/2.0;
    [self.titleL setFrame:CGRectMake(x, y, w, h)];
}

- (void)setValue:(id)value{
    [self _setValue:value];
    [self.valueL setText:[NSString stringWithFormat:@"%@",value]];
    
    //layout
    CGFloat x = self.valueL.frame.origin.x;
    CGFloat w = self.valueL.frame.size.width;
    CGSize size = [self.valueL sizeThatFits:CGSizeMake(w, CGFLOAT_MAX)];
    CGFloat h = size.height;
    CGFloat y = (self.height - h)/2.0;
    [self.valueL setFrame:CGRectMake(x, y, w, h)];
    
    [self layoutDefaultBordersByFlag];
}


#pragma mark - components

- (UILabel *)titleL{
    if (!_titleL){
        CGFloat x = self.paddingLR;
        CGFloat y = 0;
        CGFloat w = STYLE_DEVICE_WIDTH - x*2;
        CGFloat h = self.height;
        _titleL = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
        [_titleL setFont:FONT_WITH_SIZE(16.0)];
        [_titleL setTextColor:COLOR(RGB_TITLE)];
    }
    return _titleL;
}

- (UILabel *)valueL{
    if (!_valueL){
        CGFloat x = self.paddingLR;
        CGFloat y = 0;
        CGFloat w = STYLE_DEVICE_WIDTH - x*2;
        CGFloat h = self.height;
        _valueL = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
        [_valueL setFont:FONT_WITH_SIZE(14.0)];
        [_valueL setTextColor:COLOR(RGB_TITLE_LIGHT)];
        [_valueL setTextAlignment:NSTextAlignmentRight];
    }
    return _valueL;
}

#pragma mark - styles

+ (CGFloat)height{
    return 30.0;
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
