//
//  AGTipCell.m
//  AboveGEM
//
//  Created by traintrackcn on 13/1/15.
//
//

@import LITCommon;
@import LITUICommon;

#import "AGTipCell.h"


@interface AGTipCell(){
    
}



@end

@implementation AGTipCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBackgroundColor:RGBA(224, 123, 36, 1)];
        [self assemble];
    }
    return self;
}

- (void)applySelectedStyle{
    
}

- (void)applyUnselectedStyle{
    
}

- (CGFloat)paddingLR{
    return 16.0;
}

#pragma mark - assemblers

- (void)assemble{
    [self.contentView addSubview:self.titleLabel];
}

#pragma mark - properties

- (UILabel *)titleLabel{
    if ([DSValueUtil isNotAvailable:_titleLabel]) {
        CGFloat x = self.paddingLR;
        CGFloat y = 0;
        CGFloat w = [DSDeviceUtil bounds].size.width - x * 2;
        CGFloat h = self.height;
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
        [_titleLabel setNumberOfLines:0];
        [_titleLabel setAdjustsFontSizeToFitWidth:YES];
        [_titleLabel setTextColor:self.titleColor];
        [_titleLabel setFont:self.titleFont];
    }
    return _titleLabel;
}



#pragma mark - set 

- (void)setValue:(id)value{
    if ([DSValueUtil isNotAvailable:value]) return;
    [super setValue:value];
    [self.titleLabel setText:[DSValueUtil toString:value]];
}

#pragma mark - styles

- (UIColor *)titleColor{
    return [UIColor whiteColor];
}

- (UIFont *)titleFont{
    return FONT_WITH_SIZE(16);
}

@end
