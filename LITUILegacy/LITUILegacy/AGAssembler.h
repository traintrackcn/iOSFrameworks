//
//  AGAssembler.h
//  AboveGEM
//
//  Created by traintrackcn on 11/3/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
@import LITUICommon;

static const CGFloat AG_BUTTON_HEIGHT = 44;
static const CGFloat AG_BUTTON_SPACING = 10;
static const CGFloat AG_TEXTFIELD_HEIGHT = 60;
static const CGFloat AG_CELL_SEPARATOR_HEIGHT = 10;

@class AGQuantitySelector;
@class DSContentCell;
@class AGOrder;
@interface AGAssembler : NSObject

+ (UITableView *)assembleTableViewStyleDefaultWithDelegate:(id<UITableViewDelegate, UITableViewDataSource>)delegate paddingTop:(CGFloat)paddingTop paddingBottom:(CGFloat)paddingBottom;

+ (UITableView *)assembleTableViewStyleDefaultForViewController:(UIViewController<UITableViewDelegate, UITableViewDataSource> *)vc paddingTop:(CGFloat)paddingTop paddingBottom:(CGFloat)paddingBottom;

+ (UILabel *)assembleLabelForPickerView;


#pragma mark - buttons

+ (UIButton *)assembleButtonWithTitle:(NSString *)title target:(id)target selector:(SEL)selector;


@end
