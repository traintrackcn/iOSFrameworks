//
//  AGFormButtonCell.m
//  AboveGEM
//
//  Created by traintrackcn on 14/7/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import "AGButtonCell.h"
#import "AGButtonItem.h"
#import "AGAssembler.h"
#import "DSLayoutUtil.h"

@interface AGButtonCell(){
    UIView *buttonC;
}

@end

@implementation AGButtonCell

+ (CGFloat)height{
    return 80.0;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self assembleButtonContainer];
        
//        [self.contentView.layer setBorderWidth:1.0];
    }
    return self;
}

#pragma mark - style

- (void)applySelectedStyle{
    
}

#pragma mark - assemblers

- (void)assembleButtonContainer{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    buttonC = [[UIView alloc] initWithFrame:CGRectMake(0, ([AGButtonCell height]-AG_BUTTON_HEIGHT)/2, bounds.size.width, AG_BUTTON_HEIGHT)];
    [self.contentView addSubview:buttonC];
}

- (void)addButtonWithTitle:(NSString *)title target:(id)target selector:(SEL)selector{
    [buttonC addSubview: [AGAssembler assembleButtonWithTitle:title target:target selector:selector] ];
    [self layoutButtons];
}

- (void)layoutButtons{
    [DSLayoutUtil layoutButtons:buttonC.subviews];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self layoutButtons];
}

- (void)clear{
    while (buttonC.subviews.count > 0) {
        UIView *v = [buttonC.subviews  objectAtIndex:0];
        [v removeFromSuperview];
    }
}

- (void)setValue:(id)value{
    [self clear];
    
    NSArray *arr = (NSArray *)value;
    for (int i=0; i<arr.count; i++) {
        AGButtonItem *item = [arr objectAtIndex:i];
        [self addButtonWithTitle:item.title target:item.target selector:item.action];
    }
    
}

@end
