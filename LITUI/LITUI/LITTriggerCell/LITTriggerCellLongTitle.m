//
//  LITTriggerCellLongTitle.m
//  AboveGEM
//
//  Created by Tao Yunfei on 31/08/2017.
//
//

#import "LITTriggerCellLongTitle.h"
#import "LITCell+Borders.h"

@interface LITTriggerCellLongTitle(){
}

@end

@implementation LITTriggerCellLongTitle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier associatedVC:(id)associatedVC indexPath:(NSIndexPath *)indexPath{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier associatedVC:associatedVC indexPath:indexPath];
    if (self) {
        [self.contentView addGestureRecognizer:self.tapGestureRecognizer];
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    return self;
}

- (void)setTitle:(NSString *)title{
    [self _setTitle:title];
    
    [self.titleL setText:[NSString stringWithFormat:@"%@",title?title:@""]];
    
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

- (void)didTapAny:(id)sender{
    [self sendActionRequestToViewController:nil];
}


#pragma mark - styles

- (CGFloat)minHeight{
    return 60.0;
}

@end
