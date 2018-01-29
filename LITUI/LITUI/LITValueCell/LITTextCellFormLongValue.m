//
//  LITLongTitleValueCell.m
//  AboveGEM
//
//  Created by Tao Yunfei on 09/09/2017.
//
//

@import LITUICommon;

#import "LITTextCellFormLongValue.h"

@implementation LITTextCellFormLongValue

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier associatedVC:(id)associatedVC indexPath:(NSIndexPath *)indexPath{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier associatedVC:associatedVC indexPath:indexPath];
    if (self) {
        [self setAccessoryType:UITableViewCellAccessoryNone];
        [self.titleL setFont:FONT_WITH_SIZE(15.0)];
        [self.titleL setTextColor:COLOR(RGB_TITLE_LIGHT)];
        [self.valueL setFont:FONT_WITH_SIZE(17.0)];
    }
    return self;
}

- (void)setTitle:(NSString *)title{
    [self _setTitle:title];
    
    if (!title) title = @"";
    
    id attributes = @{NSForegroundColorAttributeName: COLOR(RGB_TITLE_LIGHT)};
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:title
                                                                                      attributes:attributes];
    
    NSRange r = [title rangeOfString:@"*"];
    if (r.location != NSNotFound){
        [attributedStr addAttributes:@{
                                       NSForegroundColorAttributeName: COLOR(RGB_IMPORTANT)
                                       } range:r];
    }
    
    
//    [self.titleL setText:[NSString stringWithFormat:@"%@",title?title:@""]];
    [self.titleL setAttributedText:attributedStr];
    
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
