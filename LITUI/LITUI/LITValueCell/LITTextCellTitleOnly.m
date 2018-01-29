//
//  LITTextCellLongTitleOnly.m
//  AboveGEM
//
//  Created by Tao Yunfei on 18/09/2017.
//
//

@import LITUICommon;

#import "LITTextCellTitleOnly.h"

@implementation LITTextCellTitleOnly

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier associatedVC:(id)associatedVC indexPath:(NSIndexPath *)indexPath{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier associatedVC:associatedVC indexPath:indexPath];
    if (self) {
        [self setAccessoryType:UITableViewCellAccessoryNone];
        [self.contentView removeGestureRecognizer:self.tapGestureRecognizer];
        [self.titleL setFont:FONT_BOLD_WITH_SIZE(15)];
//        [self.titleL setTextColor:COLOR(RGB_IMPORTANT)];
    }
    return self;
}


- (void)setTitle:(NSString *)title{
    [self _setTitle:title];
    [self.titleL setText:[NSString stringWithFormat:@"%@",title]];
    //layout
    CGFloat x = self.paddingLR;
    CGFloat y = self.paddingTB;
    CGFloat w = self.titleW;
    CGSize size = [self.titleL sizeThatFits:CGSizeMake(w, CGFLOAT_MAX)];
    CGFloat h = size.height;
    CGFloat cellH = h+y*2;
    
    //recalculate y with new cellH
    if (cellH < self.minHeight) {
        cellH = self.minHeight;
        y = (cellH - h)/2.0;
    }
    
    [self setHeight:cellH];
    [self.titleL setFrame:CGRectMake(x, y, w, h)];
}


- (CGFloat)minHeight{
    return 60.0;
}


@end
