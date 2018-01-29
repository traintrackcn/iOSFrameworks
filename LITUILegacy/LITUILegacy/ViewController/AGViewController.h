//
//  AGFormBaseViewController.h
//  AboveGEM
//
//  Created by traintrackcn on 16/7/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

@import Foundation;
@import UIKit;
@import LITCommon;

enum{
    SectionDummy = NSIntegerMin
};

typedef NS_ENUM(NSInteger, SectionDummyCell){
    SectionDummyCellLoginUI = NSIntegerMin
};


#import "AGVCConfiguration.h"
//#import "AGObjectPool.h"
//#import "GlobalDefine.h"

@class UITableViewCell;
@class AGRemoterResultError;


@interface AGViewController : UITableViewController{
    
    CGFloat animationDuration;
    UITableViewCell *dummyCell; //for retaining instance
}



+ (instancetype)instance;


#pragma mark - properties

- (UINavigationBar *)navigationBar;

#pragma mark - associated cell ops
- (void)setValueForAssociatedIndexPath:(id)value;
- (void)setNeedsReloadAssociatedIndexPath;
- (void)setNeedsReloadAssociatedViewController;
//- (void)reloadAssociatedIndexPath;


#pragma mark - transfer to other views

- (UINavigationController *)defaultNavigationController;
- (void)pushViewController:(UIViewController *)viewController;
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
//- (void)presentViewController:(AGViewController *)viewController;


#pragma mark - view lifecycle
- (void)willReloadVisibleIndexPaths;
- (void)reloadVisibleIndexPaths;
- (void)reloadAndLayoutImmediately; //in order to get right content size;
- (void)reloadIndexPath:(NSIndexPath *)indexPath;
- (void)reloadIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated;
- (void)reloadWithoutHeaderForSection:(NSInteger)section fromRowCount:(NSInteger)fromRowCount toRowCount:(NSInteger)toRowCount animated:(BOOL)animated;
- (void)reloadVisibleIndexPathsInSection:(NSInteger)section animated:(BOOL)animated;
- (void)didReloadVisibleIndexPaths;
- (void)willDoReload;
- (void)didDismissLoginUI;


#pragma mark - table view stuff

- (id)valueForHeaderOfSection:(NSInteger)section;
- (void)setValue:(id)value atIndexPath:(NSIndexPath *)indexPath;
- (id)valueAtIndexPath:(NSIndexPath *)indexPath;
- (id)titleAtIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)cellAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (NSInteger)numberOfSections DEPRECATED_WITH_MSG("Use numberOfSectionsInTableView instead");

#pragma mark - component

- (void)enableOverlay:(BOOL)enabled;
- (UITableViewCell *)dummyCellInstanceAtIndex:(NSInteger)index;
- (void)addOverlay:(UIView *)view;
- (UIView *)overlayWithTag:(NSInteger)tag;
- (UIView *)overlayContainer;
- (UIView *)externalViewContainer;
- (UIView *)parentView;
- (void)addExternalView:(UIView *)view;

//- (void)addInteractiveView:(UIView *)view;

#pragma mark -

- (BOOL)cacheEveryCell;

- (void)endEditing:(BOOL)endEditing;

#pragma mark - error handlers
- (BOOL)setMessagesForError:(id)error;

#pragma mark - dummy cell stuff
- (void)pushViewController:(AGViewController *)viewController fromDummyCellAtIndex:(NSInteger)index;

#pragma mark - cell request
//- (void)cellRequestReloadIndexPath:(NSIndexPath *)indexPath DEPRECATED;
//- (void)cellRequestSetValue:(id)value atIndexPath:(NSIndexPath *)indexPath;
//- (id)cellRequestParameterAtIndexPath:(NSIndexPath *)indexPath;
//- (void)cellRequestAction:(id)action atIndexPath:(NSIndexPath *)indexPath;

- (id)parameterAtIndexPath:(NSIndexPath *)indexPath;
- (void)action:(id)action atIndexPath:(NSIndexPath *)indexPath;


- (BOOL)visible;

@property (nonatomic, weak) id ws;
@property (nonatomic, copy) NSIndexPath *associatedIndexPath;
@property (nonatomic, strong) AGVCConfiguration *config;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) id userInfo;
@property (nonatomic, assign) BOOL flagDoReload;

@property (nonatomic, weak) AGViewController *previousViewController;
@property (nonatomic, strong) AGObjectPool *objPool;
@property (nonatomic, strong) UIView *dummyHeaderView;




@end
