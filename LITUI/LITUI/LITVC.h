//
//  LITViewController.h
//  iPhone
//
//  Created by Tao Yunfei on 25/09/2017.
//



@import UIKit;
@import LITCommon;

//#import "AGObjectPool.h"
//#import "GlobalDefine.h"
#import "LITVCCore.h"
#import "LITCell.h"

@interface LITVC : UITableViewController

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

#pragma mark - view lifecycle
- (void)reloadVisibleIndexPaths;
//- (void)reloadAndLayoutImmediately; //in order to get right content size;
- (void)reloadIndexPath:(NSIndexPath *)indexPath;
- (void)reloadIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated;
- (void)reloadWithoutHeaderForSection:(NSInteger)section fromRowCount:(NSInteger)fromRowCount toRowCount:(NSInteger)toRowCount animated:(BOOL)animated;
- (void)reloadVisibleIndexPathsInSection:(NSInteger)section animated:(BOOL)animated;



#pragma mark - table view stuff
- (NSInteger)numberOfSections DEPRECATED_WITH_MSG("Use numberOfSectionsInTableView: instead");
- (id)valueForHeaderOfSection:(NSInteger)section;
- (void)setValue:(id)value atIndexPath:(NSIndexPath *)indexPath;
- (id)valueAtIndexPath:(NSIndexPath *)indexPath;
- (id)titleAtIndexPath:(NSIndexPath *)indexPath;
- (LITCell *)cellAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (void)setCellHeight:(CGFloat)height atIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)cellHeightAtIndexPath:(NSIndexPath *)indexPath;

#pragma mark - component

- (void)enableOverlay:(BOOL)enabled;
- (void)addOverlay:(UIView *)view;
- (UIView *)overlayWithTag:(NSInteger)tag;
- (UIView *)overlayContainer;
- (UIView *)externalViewContainer;
- (UIView *)parentView;
- (void)addExternalView:(UIView *)view;

//- (void)addInteractiveView:(UIView *)view;

#pragma mark -

- (void)endEditing:(BOOL)endEditing;

#pragma mark - error handlers
- (BOOL)setMessagesForError:(id)error;


#pragma mark - cell request

- (id)parameterAtIndexPath:(NSIndexPath *)indexPath;
- (void)action:(id)action atIndexPath:(NSIndexPath *)indexPath;
- (BOOL)visible;

//- (LITVCCore *)core;
- (AGObjectPool *)objPool;
- (id)ws;


- (void)reloadAllAsNeeded; //for override only
- (void)reloadIndexPathAsNeeded; //for override only


- (BOOL)dismissingFromNaviC;

@property (nonatomic, copy) NSIndexPath *associatedIndexPath;

@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) id userInfo;
//@property (nonatomic, assign) BOOL flagDoReload;

@property (nonatomic, weak) id previousViewController;



@end
