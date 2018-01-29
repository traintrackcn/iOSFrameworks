//
//  LITCellForSectionButton.m
//  iPhone
//
//  Created by Tao Yunfei on 26/09/2017.
//

@import LITUICommon;

#import "LITCellForSectionButton.h"
#import "LITCell+Borders.h"
#import "LITItemForSectionButton.h"

@interface LITCellForSectionButton()

@property (nonatomic, strong) UILabel *titleL;

@end

@implementation LITCellForSectionButton

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier associatedVC:(id)associatedVC indexPath:(NSIndexPath *)indexPath{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier associatedVC:associatedVC indexPath:indexPath];
    if (self) {
        [self.contentView addSubview:self.borderTopViewStyleSolid];
        [self.contentView addSubview:self.borderBottomViewStyleSolid];
        [self.contentView addSubview:self.titleL];
        [self.contentView addGestureRecognizer:self.tapGestureRecognizer];
    }
    return self;
}

- (void)didTapAny:(id)sender{
    [self sendActionRequestToViewController:nil];
}

#pragma mark - setters

- (void)setValue:(id)value{
    [self _setValue:value];
    [self setTitle];
}

- (void)setTitle{
    [self.titleL setText:self.item.title];
    [self.titleL setFont:self.item.titleFont];
    [self.titleL setTextColor:self.item.titleColor];
}

#pragma mark - components

- (UILabel *)titleL{
    if (!_titleL) {
        CGFloat x = 0;
        CGFloat y = 0;
        CGFloat w = STYLE_DEVICE_WIDTH;
        CGFloat h = self.height;
        _titleL = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
        [_titleL setTextAlignment:NSTextAlignmentCenter];
    }
    return _titleL;
}

#pragma mark - properties

- (LITItemForSectionButton *)item{
    return self.value;
}

@end
