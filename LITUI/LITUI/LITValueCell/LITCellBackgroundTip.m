//
//  LITCellBackgroundTip.m
//  AboveGEM
//
//  Created by Tao Yunfei on 11/09/2017.
//
//

@import LITUICommon;

#import "LITCellBackgroundTip.h"

@interface LITCellBackgroundTip(){

}

@property (nonatomic, strong) UILabel *valueL;

@end

@implementation LITCellBackgroundTip

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier associatedVC:(id)associatedVC indexPath:(NSIndexPath *)indexPath{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier associatedVC:associatedVC indexPath:indexPath];
    if (self) {
        [self.contentView addSubview:self.valueL];
    }
    return self;
}

#pragma mark - setters

- (void)setValue:(id)value{
    [self _setValue:value];
    [self.valueL setText:[NSString stringWithFormat:@"%@", value]];
    CGFloat x = 30;
    CGFloat w = STYLE_DEVICE_WIDTH - x*2;
    CGSize size = [self.valueL sizeThatFits:CGSizeMake(w, CGFLOAT_MAX)];
    CGFloat h = size.height;
    
    CGFloat y = (self.height - h)/2.0;
    
    [self.valueL setFrame:CGRectMake(x, y, w, h)];
     
}


#pragma mark - componets

- (UILabel *)valueL{
    if (!_valueL){
        _valueL = [[UILabel alloc] init];
        [_valueL setFont:FONT_WITH_SIZE(15.0)];
        [_valueL setTextColor:COLOR(RGB_TITLE)];
        [_valueL setNumberOfLines:0];
    }
    return _valueL;
}

#pragma mark - styles

//- (void)applyUnselectedStyle{
//    
//}

- (void)applySelectedStyle{

}

@end
