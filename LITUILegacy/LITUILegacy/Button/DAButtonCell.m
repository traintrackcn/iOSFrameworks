//
//  DAButtonCell.m
//  Distributors
//
//  Created by Tao Yunfei on 1/5/16.
//  Copyright © 2016 AboveGEM. All rights reserved.
//

@import LITUICommon;

#import "DAButtonCell.h"
#import "DAButtonItem.h"

#import "DAButtonFactory.h"

@interface DAButtonCell(){
    
}

@property (nonatomic, strong) UIButton *button;

@end

@implementation DAButtonCell




- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

#pragma mark - setters

- (void)setValue:(id)value{
    [super setValue:value];
    
    [self reset];
    [self.contentView addSubview:self.button];
//    TLOG(@"[self dispatchRequestParameters] -> %@", [self dispatchRequestParameters]);
    BOOL disabled = [[self parametersFromViewController].firstObject boolValue];
    [self.button setEnabled:!disabled];
}

- (void)reset{
    [_button removeFromSuperview];
    _button = nil;
}
     
#pragma mark - components
     
- (UIButton *)button{
    if (!_button) {
        CGFloat x = self.paddingLR;
        CGFloat w = STYLE_DEVICE_WIDTH - x*2;
        CGFloat y = self.paddingTB;
        CGFloat h = self.height - y*2;
        DAButtonItem *item = (DAButtonItem *)self.value;
        _button = [DAButtonFactory buttonInstanceWithItem:item];
        [_button setFrame:CGRectMake(x, y, w, h)];
    }
    return _button;
}





#pragma mark - style

- (CGFloat)paddingLR{
    return 15.0;
}

- (CGFloat)paddingTB{
    return 0;
}

- (void)applySelectedStyle{
    
}


- (void)applyUnselectedStyle{
    
}



@end
