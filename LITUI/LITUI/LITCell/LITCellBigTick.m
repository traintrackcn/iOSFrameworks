//
//  LITCellBigTick.m
//  AboveGEM
//
//  Created by Tao Yunfei on 15/09/2017.
//
//

@import LITUICommon;

#import "LITCellBigTick.h"


@interface LITCellBigTick(){

}

@property (nonatomic, strong) UIImageView *iconView;

@end

@implementation LITCellBigTick

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier associatedVC:(id)associatedVC indexPath:(NSIndexPath *)indexPath{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier associatedVC:associatedVC indexPath:indexPath];
    if (self) {
        [self.contentView addSubview:self.iconView];
    }
    return self;
}

#pragma mark - components

- (UIImageView *)iconView{
    if (!_iconView){
        CGFloat w = STYLE_DEVICE_WIDTH;
        CGFloat h = self.height;
        UIImage *img = [UIImage imageNamed:@"IconTick"];
        img = [DSImage image:img withMaskColor:COLOR(RGB_THEME_FOR_CONTROL)];
        _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
        [_iconView setContentMode:UIViewContentModeScaleAspectFit];
        [_iconView setImage:img];
    }
    return _iconView;
}

#pragma mark - styles

+ (CGFloat)height{
    return 55.0;
}

- (void)applySelectedStyle{
    
}

@end
