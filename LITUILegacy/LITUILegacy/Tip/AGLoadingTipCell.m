//
//  AGLoadingTipCell.m
//  AboveGEM
//
//  Created by traintrackcn on 5/2/15.
//
//

@import LITCommon;

#import "AGLoadingTipCell.h"
//#import "GlobalDefine.h"

@implementation AGLoadingTipCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        
        [self.titleLabel setTextAlignment:NSTextAlignmentRight];
        [self.titleLabel setTextColor:RGBA(85, 85, 85, 1)];
    }
    return self;
}

@end
