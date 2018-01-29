//
//  AGTextfieldCellStyleNoTitle.m
//  AboveGEM
//
//  Created by traintrackcn on 16/8/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import "AGTextfieldCellStyleNoTitle.h"
#import "AGAssembler.h"

#import "NSObject+TextInputComponents.h"

@implementation AGTextfieldCellStyleNoTitle

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

#pragma mark -

- (void)assembleInputView{
    [super assembleInputView];
    CGFloat x = self.paddingLR;
    CGFloat y = (self.class.height - AG_TEXTFIELD_HEIGHT)/2;
    CGFloat w = self.frame.size.width - self.paddingLR*2;
    [self.inputField setFrame:CGRectMake(x, y, w,AG_TEXTFIELD_HEIGHT )];
    [self.inputField setFont:[UIFont systemFontOfSize:14]];
    [self.inputField setTextAlignment:NSTextAlignmentLeft];
    [self.inputField setDelegate:self.textInputDelegate];
}

@end
