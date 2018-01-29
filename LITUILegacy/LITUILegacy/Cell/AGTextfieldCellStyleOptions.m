//
//  AGFormLabelUnit.m
//  AboveGEM
//
//  Created by traintrackcn on 14/7/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

@import LITCommon;
@import LITUICommon;

#import "AGTextfieldCellStyleOptions.h"

@interface AGTextfieldCellStyleOptions(){
    
}

@end

@implementation AGTextfieldCellStyleOptions


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        
        [self assembleTitleView];
        [self assembleContentLabel];
        [self.contentView addGestureRecognizer:self.tapGestureRecognizer];

        [self.contentView addSubview:self.borderBottomViewStylePaddingL];
    }
    return self;
}


#pragma mark - assemblers

- (void)assembleInputView{
    
}

- (void)assembleContentLabel{
    if ([DSValueUtil isAvailable:contentLabel]) return;
    CGFloat x = self.frame.size.width / 3.0;
    CGFloat w = self.frame.size.width - x - 24.0;
    contentLabel = [[AGLabel alloc] initWithFrame:CGRectMake(x, 0, w, [self.class height])];
    [contentLabel setTextColor:COLOR(AG_UI_DEFINE.RGB_TITLE_NORMAL)];
    [contentLabel setTextAlignment:NSTextAlignmentRight];
    [contentLabel setFont:FONT_WITH_SIZE(16)];
    [self.contentView addSubview:contentLabel];
}

#pragma mark - setters

- (void)setValue:(id)value{
    [super setValue:value];
    [contentLabel setText:[DSValueUtil toString:value]];
}

#pragma mark -
- (void)layoutSubviews{
    [super layoutSubviews];
    [self layoutContentLabel];
}

- (void)layoutContentLabel{
    [contentLabel setFrame:self.inputFieldFrame];
}

@end
