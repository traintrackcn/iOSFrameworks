//
//  LITTextCellLongValue.m
//  AboveGEM
//
//  Created by Tao Yunfei on 09/09/2017.
//
//

@import LITUICommon;

#import "LITTextCellLongValue.h"
#import "LITCell+Borders.h"

@implementation LITTextCellLongValue

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier associatedVC:(id)associatedVC indexPath:(NSIndexPath *)indexPath{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier associatedVC:associatedVC indexPath:indexPath];
    if (self) {
        [self.valueL setTextAlignment:NSTextAlignmentRight];
        [self.valueL setNumberOfLines:1];
    }
    return self;
}

- (void)setValue:(id)value{
    [self _setValue:value];
    [self.valueL setText:[NSString stringWithFormat:@"%@",value]];
    
    CGFloat x = self.paddingLR + self.titleW;
    CGFloat y = 0;
    CGFloat w = self.valueW;
    CGFloat h = self.height;
    [self.valueL setFrame:CGRectMake(x, y, w, h)];
    
    [self layoutDefaultBordersByFlag];
}

#pragma mark - styles

- (CGFloat)valueW{
    if (self.accessoryType == UITableViewCellAccessoryNone) return (STYLE_DEVICE_WIDTH/3.0)*2.0 - self.paddingLR;
    return (STYLE_DEVICE_WIDTH/3.0)*2.0 - self.paddingLR - self.paddingLR;
}

@end
