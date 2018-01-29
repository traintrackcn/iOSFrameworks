//
//  AGFormPicker.h
//  AboveGEM
//
//  Created by traintrackcn on 10/7/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import "AGViewController.h"

@class AGVCConfiguration;
@class AGForm;


@interface AGSelector : AGViewController{
    CGFloat paddingLR;
    CGFloat paddingTB;
}


//@property (nonatomic, strong) NSString *title;

- (void)setContentView:(UIView *)v;
- (void)addButtonWithTitle:(NSString *)title target:(id)target selector:(SEL)selector;

- (UIView *)contentView;

@end
