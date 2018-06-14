//
//  AGFormInput.h
//  AboveGEM
//
//  Created by traintrackcn on 11/7/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@import LITCommon;
@import LITNetwork;

#import "UIView+HeaderAndCell.h"

@class AGVCConfiguration;
@class AGObjectPool;

@interface AGCell : UITableViewCell <AGRemoterDelegate>{
//    CGFloat paddingLR;
//    CGFloat paddingTB;
//    AGRemoter *remoter;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier associatedViewController:(id)associatedViewController indexPath:(NSIndexPath *)indexPath;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier associatedViewController:(id)associatedViewController indexPath:(NSIndexPath *)indexPath config:(AGVCConfiguration *)config;

- (void)_setValue:(id)value;
- (void)_setTitle:(id)title;
- (void)_setSelected:(BOOL)selected;
//- (void)_setHeight:(CGFloat)height;

- (void)didSetValue:(id)value;
- (void)layout;

#pragma mark - dispatchers
- (void)reload;
- (void)setValueForViewController:(id)value;
- (NSArray *)parametersFromViewController;
//- (void)sendActionRequestToViewController:(id)action;


#pragma mark - interactive ops
- (void)assembleGC DEPRECATED_WITH_MSG("Use [self.contentView addGestureRecognizer:self.tapGestureRecognizer] instead");
- (void)activateSelector DEPRECATED_WITH_MSG("Use [self didTapAny:] instead");
- (void)didTapCell DEPRECATED_WITH_MSG("Use [self didTapAny:] instead");



#pragma mark - styles
- (void)applySelectedStyle;
- (void)applyUnselectedStyle;

#pragma mark - properties

- (UITableView *)tableView;
- (BOOL)isCachedValueSameAsTargetValue:(id)targetValue;
- (BOOL)isContentViewLoaded DEPRECATED;
- (BOOL)isContentViewBlank DEPRECATED;

#pragma mark - styles

+ (CGFloat)height;
+ (CGFloat)heightOfValue:(id)value;

//- (CGFloat)borderPaddingL;
//- (CGFloat)paddingTB;
//- (UIColor *)borderColor;
//- (CGFloat)borderWidth;

#pragma mark - 
- (void)endEditingForAssociatedView;
- (void)reloadAssociatedViewController;

- (AGObjectPool *)objPoolOfAssociatedVC;

@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) AGObjectPool *objPool;

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign) BOOL isOptional;
@property (nonatomic, assign) BOOL isLastRow DEPRECATED;
@property (nonatomic, assign) BOOL isFirstRow DEPRECATED;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *errorMsg DEPRECATED;
@property (nonatomic, strong) NSString *tipMsg DEPRECATED;
@property (nonatomic, strong) NSString *placeholder;

@property (nonatomic, strong) id value;
@property (nonatomic, strong) AGVCConfiguration *config;
@property (nonatomic, weak) id ws;
@property (nonatomic, weak) id associatedViewController;
@property (nonatomic, strong) AGRemoter *remoter DEPRECATED ; 
//@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;

@property (nonatomic, strong) id obUIKeyboardWillChangeFrameNotification DEPRECATED;


@end
