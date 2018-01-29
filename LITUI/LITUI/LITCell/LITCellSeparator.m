//
//  LITCellReportOrderSeparator.m
//  AboveGEM
//
//  Created by Tao Yunfei on 20/09/2017.
//
//

@import LITUICommon;

#import "LITCellSeparator.h"

@implementation LITCellSeparator

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier associatedVC:(id)associatedVC indexPath:(NSIndexPath *)indexPath{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier associatedVC:associatedVC indexPath:indexPath];
    if (self) {
        [self.contentView addSubview:self.borderTopViewStyleSolid];
    }
    return self;
}

#pragma mark - styles

+ (CGFloat)height{
    return 10;
}


- (void)applyUnselectedStyle{
    [self setBackgroundColor:COLOR(RGB_BACKGROUND_NORMAL)];
}

- (void)applySelectedStyle{

}

@end
