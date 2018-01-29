//
//  LITTextFieldCellForm.m
//  AboveGEM
//
//  Created by Tao Yunfei on 22/08/2017.
//
//

@import LITUICommon;

#import "LITTextFieldCellForm.h"
#import "LITCell+Borders.h"

@implementation LITTextFieldCellForm

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier associatedVC:(id)associatedVC indexPath:(NSIndexPath *)indexPath{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier associatedVC:associatedVC indexPath:indexPath];
    if (self) {
        [self initializeDefaultBorders];
    }
    return self;
}

#pragma mark - 

- (void)setValue:(id)value{
    [self layoutDefaultBordersByFlag];
    [self _setValue:value];
    if (!value) value = @"";
    [self.textF setText:[NSString stringWithFormat:@"%@", value]];
}

- (void)setTitle:(NSString *)title{
    [self _setTitle:title];
    id attributes = @{NSForegroundColorAttributeName: COLOR(RGB_TITLE_LIGHT)};
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:title
                                                                        attributes:attributes];
    NSRange r = [title rangeOfString:@"*"];
    if (r.location != NSNotFound){
        [attributedStr addAttributes:@{
                                        NSForegroundColorAttributeName: COLOR(RGB_IMPORTANT)
                                        } range:r];
    }
    
    [self.textF setAttributedPlaceholder:attributedStr];
    
//    TLOG(@"%@ %@", self, self.indexPath);
}

#pragma mark - styles

- (UIColor *)borderColor{
    return COLOR(RGB_BORDER);
}

- (void)applySelectedStyle{

}

- (void)applyUnselectedStyle{
    [self setBackgroundColor:COLOR(RGB_WHITE)];
}




@end
