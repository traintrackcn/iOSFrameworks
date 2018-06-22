//
//  AGFilterCollectionViewCell.m
//  AboveGEM
//
//  Created by traintrackcn on 30/10/14.
//
//

@import LITCommon;
@import LITUICommon;

#import "AGCollectionViewCellOption.h"

//#import "DSValueUtil.h"


@implementation AGCollectionViewCellOption

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self assembleTitle];
//        [self setBackgroundColor:[AGStyleCoordinator colorBackgroundNormal]];
    }
    return self;
}


#pragma mark - assemblers

- (void)assembleTitle{
    if (titleL) return;
    CGFloat spacing = 4.0;
    CGFloat x = spacing;
    CGFloat y = spacing;
    CGFloat w = self.frame.size.width - spacing*2;
    CGFloat h = self.frame.size.height - spacing *2;
    titleL = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    [titleL setNumberOfLines:0];
    [titleL setFont:[UIFont systemFontOfSize:12]];
//    [titleL setLineBreakMode:NSLineBreakByWordWrapping];
    [titleL setTextAlignment:NSTextAlignmentCenter];
    [titleL setClipsToBounds:YES];
    [titleL.layer setCornerRadius:4.0];
    [titleL setAdjustsFontSizeToFitWidth:YES];
    [titleL.layer setBorderColor:COLOR(UI.RGB_OPTION_BORDER).CGColor];
    [self.contentView addSubview:titleL];
}


- (void)setSelected:(BOOL)selected{
    if (selected) {
        [titleL.layer setBorderWidth:0];
        [titleL setBackgroundColor:COLOR(UI.RGB_OPTION_BACKGROUND_HIGHLIGHT)];
        [titleL setTextColor:COLOR(UI.RGB_OPTION_TITLE_HIGHLIGHT)];
    }else{
        [titleL.layer setBorderWidth:1];
        [titleL setBackgroundColor:COLOR(UI.RGB_OPTION_BACKGROUND_NORMAL)];
        [titleL setTextColor:COLOR(UI.RGB_OPTION_TITLE_NORMAL)];
    }
}



#pragma mark -

- (void)setValue:(id)value{
    [titleL setText:[DSValueUtil toString:value]];
}

@end
