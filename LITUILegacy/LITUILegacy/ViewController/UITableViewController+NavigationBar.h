//
//  AGViewController+NavigationBarButtonUtils.h
//  Distributors
//
//  Created by Tao Yunfei on 12/18/15.
//  Copyright © 2015 AboveGEM. All rights reserved.
//

@import UIKit;

@interface UITableViewController (NavigationBar)

- (void)hideNextVCBackButtonTitle;
- (void)hideNavigationBarBackground;
- (void)hideNavigationBarBorder;
- (void)hideNavigationBarBackgroundAndBorder;
- (void)setNavigationBarBorderColor:(UIColor *)borderColor;
- (void)setNextVCBackButtonWithImageNamed:(NSString *)imageName maskColor:(UIColor *)maskColor;

- (UIBarButtonItem *)saveBarButtonItem;
- (UIBarButtonItem *)closeBarButtonItem;
- (UIBarButtonItem *)createBarButtonItem;
- (UIBarButtonItem *)okBarButtonItem;
- (UIBarButtonItem *)doneBarButtonItem;
- (UIBarButtonItem *)uploadBarButtonItem;
- (UIBarButtonItem *)searchBarButtonItem;
- (UIBarButtonItem *)skipBarButtonItem;
- (UIBarButtonItem *)cancelBarButtonItem;
- (UIBarButtonItem *)sendBarButtonItem;
- (UIBarButtonItem *)inviteBarButtonItem;

#pragma mark - interactive ops
- (void)didTapSave:(id)sender;
- (void)didTapCreate:(id)sender;
- (void)didTapOK:(id)sender;
- (void)didTapDone:(id)sender;
- (void)didTapUpload:(id)sender;
- (void)didTapSearch:(id)sender;
- (void)didTapSkip:(id)sender;
- (void)didTapCancel:(id)sender;
- (void)didTapSend:(id)sender;
- (void)didTapClose:(id)sender;
- (void)didTapInvite:(id)sender;

@end
