//
//  AGHeaderCell.m
//  AboveGEM
//
//  Created by traintrackcn on 16/8/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

@import LITCommon;
@import LITUICommon;

#import "AGHeaderCell.h"

@interface AGHeaderCell(){
    
}

@end

@implementation AGHeaderCell

+ (CGFloat)height{
    return 60;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self assembleTitleView];
    }
    return self;
}


- (void)applySelectedStyle{
    
}

- (void)applyUnselectedStyle{
    
}

- (void)assembleTitleView{
    
    CGRect bounds = [DSDeviceUtil bounds];
//    CGFloat titleH = 40;
    CGFloat x = self.paddingLR;
    CGFloat w = bounds.size.width-x*2;
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, 0, w ,self.class.height)];
    
    [titleLabel setFont:self.titleFont];
    [titleLabel setTextColor:self.titleColor];
    [titleLabel setNumberOfLines:0];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
//    [titleLabel setBackgroundColor:[UIColor redColor]];
//    [titleLabel.layer setBorderWidth:1.0];

    [self.contentView addSubview:titleLabel];
}

- (void)setValue:(id)value{
    [titleLabel setText:[DSValueUtil toString:value]];
}

#pragma mark - styles

- (UIColor *)titleColor{
    return COLOR(RGB_THEME);
}

- (UIFont *)titleFont{
    return FONT_BOLD_WITH_SIZE(24.0);
}

@end
