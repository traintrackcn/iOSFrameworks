//
//  LITSectionCostInfoSpaceCell.m
//  AboveGEM
//
//  Created by Tao Yunfei on 31/08/2017.
//
//

@import LITUICommon;

#import "LITCellSpace.h"
#import "LITCell+Borders.h"

@implementation LITCellSpace

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier associatedVC:(id)associatedVC indexPath:(NSIndexPath *)indexPath{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier associatedVC:associatedVC indexPath:indexPath];
    if (self) {
        [self initializeDefaultBorders];
    }
    return self;
}

- (void)setValue:(id)value{
    [self layoutDefaultBordersByFlag];
}

#pragma mark - styles

+ (CGFloat)height{
    return 10.0;
}


- (void)applySelectedStyle{

}

- (void)applyUnselectedStyle{
    [self setBackgroundColor:COLOR(RGB_WHITE)];
}

@end
