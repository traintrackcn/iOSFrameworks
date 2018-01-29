//
//  UIView+Borders.h
//  AGUIKit
//
//  Created by Tao Yunfei on 24/08/2017.
//  Copyright © 2017 AboveGEM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HeaderAndCell)

- (CGFloat)paddingLR;
- (CGFloat)paddingTB;
- (CGFloat)height;
- (CGFloat)borderWidth;
- (CGFloat)borderPaddingL;
- (UIColor *)borderColor;

- (UIView *)borderViewInstance;
- (UIView *)backgroundViewStyleBlock;
- (UIView *)borderTopViewStyleBlock;
- (UIView *)borderBottomViewStyleBlock;
- (UIView *)borderLeftViewStyleBlock;
- (UIView *)borderRightViewStyleBlock;
- (UIView *)borderTopViewStyleSolid;
- (UIView *)borderTopViewStylePaddingL;
- (UIView *)borderBottomViewStyleSolid;
- (CGRect)borderBottomFrameStyleSolid;
- (UIView *)borderBottomViewStylePaddingLR;
- (UIView *)borderBottomViewStylePaddingL;
- (CGRect)borderBottomFrameStylePaddingL;

#pragma mark - interactive ops
- (UITapGestureRecognizer *)tapGestureRecognizer;
- (void)didTapAny:(id)sender;

#pragma mark - view controller actions
- (void)pushViewController:(UIViewController *)viewController fromNaviC:(UINavigationController *)naviC;
- (void)pushViewController:(UIViewController *)viewController;

#pragma mark - dispatchers
- (void)sendActionRequestToViewController:(id)action;

#pragma mark - 
- (id)associatedViewController;
- (NSIndexPath *)indexPath;

#pragma mark - 
- (UITableView *)tableView;


@end
