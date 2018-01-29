//
//  LITViewController.m
//  iPhone
//
//  Created by Tao Yunfei on 25/09/2017.
//

@import LITCommon;
@import LITNetwork;
@import LITUICommon;
@import LITUILegacy;

#import "LITVC.h"
#import "LITCell.h"
#import "LITSectionUnit.h"
#import "NSObject+SectionUtils.h"


@interface LITVC ()

@property (nonatomic, strong) UIView *overlayContainer;
@property (nonatomic, strong) NSMutableArray *externalViews;
@property (nonatomic, copy) NSIndexPath *needsReloadIndexPath;
@property (nonatomic, assign) BOOL needsReloadAll;
@property (nonatomic, assign) BOOL visible;
//@property (nonatomic, strong) UIView *interactiveContainer;
@property (nonatomic, assign) BOOL initialized;
@property (nonatomic, strong) AGObjectPool *objPool;
@property (nonatomic, weak) id ws;
@property (nonatomic, strong) LITVCCore *core;

@end

@implementation LITVC

@synthesize previousViewController = _previousViewController;

+ (instancetype)instance{
    return [[self.class alloc] init];
}

- (id)init{
    self = [super init];
    if (self) {
        [self setWs:self];
        [self setBackgroundColor:COLOR(RGB_BACKGROUND_NORMAL)];
    }
    return self;
}

#pragma mark - interactive ops

- (void)didTapView:(id)sender{
    [self.view endEditing:YES];
}

#pragma mark - life cycle

- (void)viewDidLoad{
    TLOG(@"%@", self.className);
    [super viewDidLoad];
    [self.parentView addSubview:self.overlayContainer];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    if (self.backgroundColor) {
        UIView *bgV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, STYLE_DEVICE_WIDTH, STYLE_DEVICE_HEIGHT)];
        //        bgV.layer.borderWidth = 1;
        //        bgV.layer.borderColor = [UIColor redColor].CGColor;
        [bgV setBackgroundColor:self.backgroundColor];
        [self.tableView setBackgroundView:bgV];
        //        [self.view setBackgroundColor:self.backgroundColor];
        
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [self setVisible:YES];
    
    TLOG(@"%@", self.className);
    [super viewWillAppear:animated];
    [self setNavigationController];
    [self showExternalViews];
}

- (void)viewWillLayoutSubviews{
    //    TLOG(@"%@", self.className);
    [super viewWillLayoutSubviews];
}

- (void)viewDidLayoutSubviews{
    //    TLOG(@"%@", self.className);
    [super viewDidLayoutSubviews];
    
}

- (void)viewDidAppear:(BOOL)animated{
    TLOG(@"%@", self.className);
    [super viewDidAppear:animated];
    
//    if (self.flagDoReload) {
//        [self willDoReload];
//        [self setFlagDoReload:NO];
//    }
    
    if (self.needsReloadIndexPath) {
        @try {
            [self reloadIndexPath:self.needsReloadIndexPath];
            [self setNeedsReloadIndexPath:nil];
        } @catch (NSException *exception) {
            TLOG(@"exception -> %@", exception);
        }
        
    }
    
    TLOG(@"needsReloadAll -> %@", @(self.needsReloadAll));
    if (self.needsReloadAll){
        [self reloadVisibleIndexPaths];
        [self setNeedsReloadAll:NO];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [self setVisible:NO];
    //    TLOG(@"%@", self.className);
    [super viewWillDisappear:animated];
    [self hideExternalViews];
    //    [self.interactiveContainer setHidden:YES];
}

- (void)viewDidDisappear:(BOOL)animated{
    //    TLOG(@"%@", self.className);
    [super viewDidDisappear:animated];
}

- (void)dealloc{
    TLOG(@"%@", self.className);
    [self clearFloatedMessage];
    [self.view.layer removeAllAnimations];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self resetExternalViews];
}

#pragma mark - component

- (void)hideExternalViews{
    for (NSInteger i = 0; i<self.externalViews.count; i++) {
        UIView *v = [self.externalViews objectAtIndex:i];
        [v setHidden:YES];
    }
}

- (void)showExternalViews{
    for (NSInteger i = 0; i<self.externalViews.count; i++) {
        UIView *v = [self.externalViews objectAtIndex:i];
        [v setHidden:NO];
    }
    
}

- (void)resetExternalViews{
    for (NSInteger i = 0; i<self.externalViews.count; i++) {
        UIView *v = [self.externalViews objectAtIndex:i];
        [v removeFromSuperview];
    }
    
    _externalViews = nil;
    _overlayContainer = nil;
    //    _interactiveContainer = nil;
}

- (void)setNavigationController{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController setToolbarHidden:YES];
}

- (UIView *)parentView{
    return self.navigationController.view;
}

- (void)addOverlay:(UIView *)view{
    [self.overlayContainer addSubview:view];
}

- (void)enableOverlay:(BOOL)enabled{
    [self.overlayContainer setUserInteractionEnabled:enabled];
}

- (void)addExternalView:(UIView *)view{
    if (!view) return;
    
    [self.parentView insertSubview:view belowSubview:self.overlayContainer];
    [self.externalViews addObject:view];
    
}

//- (void)addInteractiveView:(UIView *)view{
//    if (!view) return;
//    [self.interactiveContainer addSubview:view];
//}

- (UIView *)externalViewContainer{
    return self.parentView;
}

- (UIView *)overlayWithTag:(NSInteger)tag{
    return [self.overlayContainer viewWithTag:tag];
}

- (UIView *)overlayContainer{
    if (!_overlayContainer) {
        CGFloat y = self.subviewContainerY;
        CGFloat h = self.subviewContainerH;
        CGFloat w = self.tableView.frame.size.width;
        _overlayContainer =  [[UIView alloc] initWithFrame:CGRectMake(0, y, w, h)];
        //        _overlayContainer.layer.borderWidth = 3;
        //        _overlayContainer.layer.borderColor = [UIColor blueColor].CGColor;
        [_overlayContainer setUserInteractionEnabled:NO];
        
        [self.externalViews addObject:_overlayContainer];
    }
    
    return _overlayContainer;
}

//- (UIView *)interactiveContainer{
//    if (!_interactiveContainer) {
//        CGFloat x = 0;
//        CGFloat y = 0;
//        CGFloat w = STYLE_DEVICE_WIDTH;
//        CGFloat h = STYLE_DEVICE_HEIGHT;
//        _interactiveContainer = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
////        [_interactiveContainer setUserInteractionEnabled:NO];
//        [_interactiveContainer setBackgroundColor:[UIColor clearColor]];
//        [self.externalViews addObject:_interactiveContainer];
//    }
//    return _interactiveContainer;
//}


#pragma mark - view controller transitions

- (UINavigationController *)defaultNavigationController{
    UINavigationController *naviC = self.parentViewController.navigationController;
    
    if (!naviC) {
        naviC = self.navigationController;
    }
    
    return naviC;
}

- (void)pushViewController:(UIViewController *)viewController{
    [self.defaultNavigationController pushViewController:viewController animated:YES];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [self.defaultNavigationController pushViewController:viewController animated:animated];
}

//- (void)presentViewController:(AGViewController *)viewController{
//}


#pragma mark - update table view actions

- (void)reloadVisibleIndexPaths{
    TLOG(@"%@", NSStringFromClass(self.class));
    [self.tableView reloadData];
}


- (void)reloadIndexPath:(NSIndexPath *)indexPath{
    [self reloadIndexPath:indexPath animated:YES];
}

- (void)reloadIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated{
    //    TLOG(@"%@ indexPath -> %@", indexPath, self);
    
    if (animated) {
        [self.tableView beginUpdates];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
    }else{
        [self.tableView beginUpdates];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView endUpdates];
    }
    
}

- (void)reloadWithoutHeaderForSection:(NSInteger)section fromRowCount:(NSInteger)fromRowCount toRowCount:(NSInteger)toRowCount animated:(BOOL)animated{
    
    UITableViewRowAnimation animation = UITableViewRowAnimationFade;
    
    if (!animated) animation = UITableViewRowAnimationNone;
    
    NSMutableArray *deletedIndexPaths = [NSMutableArray array];
    for (NSInteger i = 0; i<fromRowCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:section];
        [deletedIndexPaths addObject:indexPath];
    }
    
    NSMutableArray *addedIndexPaths = [NSMutableArray array];
    for (NSInteger i = 0; i<toRowCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:section];
        [addedIndexPaths addObject:indexPath];
    }
    
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:deletedIndexPaths withRowAnimation:animation];
    [self.tableView insertRowsAtIndexPaths:addedIndexPaths withRowAnimation:animation];
    [self.tableView endUpdates];
}

- (void)reloadVisibleIndexPathsInSection:(NSInteger)section animated:(BOOL)animated{
    
    if (animated){
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
    }else{
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
    }
    
}



#pragma mark - properties

- (BOOL)cacheEveryCell{
    return NO;
}

- (AGViewController *)previousViewController{
    if (_previousViewController) return _previousViewController;
    //    TLOG(@"self.navigationController.viewControllers -> %@", self.navigationController.viewControllers);
    
    //    TLOG(@"self.presentingViewController -> %@ self.presentedViewController -> %@", self.presentingViewController, self.presentedViewController);
    
    NSArray *viewControllers = self.navigationController.viewControllers;
    NSInteger idx = [viewControllers indexOfObject:self];
    idx --;
    if (idx < 0) return nil;
    return [viewControllers objectAtIndex:idx];
}

+ (CGFloat)defaultContentInsetTop{
    if ([UIDevice currentDevice].systemVersion.doubleValue >= 7.0) {
        return 64.0;
    }
    return 0;
}

+ (CGFloat)defaultContentHeightWithNavigationBar{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    if ([UIDevice currentDevice].systemVersion.doubleValue >= 7.0) {
        return bounds.size.height;
    }
    return bounds.size.height - 64;
}



- (AGObjectPool *)objPool{
    if (!_objPool) {
        _objPool = [AGObjectPool instance];
        [_objPool setParentClassName:NSStringFromClass(self.class)];
    }
    return _objPool;
}

//- (id)ws{
//    _ws = self;
//    return _ws;
//}

- (NSString *)className{
    return NSStringFromClass(self.class);
}

- (NSMutableArray *)externalViews{
    if (!_externalViews) {
        _externalViews = [NSMutableArray array];
    }
    return _externalViews;
}

#pragma mark - table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self numberOfRowsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    TLOG(@"indexPath -> %@", indexPath);    
//    TLOG(@"================")
    CGFloat h = 0;
    BOOL visibility = [self visibilityAtIndexPath:indexPath];
    if(visibility) h = [self cellHeightAtIndexPath:indexPath];
//    Class cellCls = [self cellClsOfIndexPath:indexPath];
//    NSInteger section = indexPath.section;
//    NSInteger idx = indexPath.row;
//    TLOG(@"%@ %@-%@ h -> %@ ", NSStringFromClass(cellCls), @(section), @(idx), @(h));
//    TLOG(@"indexPath -> %@ h -> %@", indexPath, @(h));
    return h;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self tableView:tableView heightForRowAtIndexPath:indexPath];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    //    TLOG(@"========================");
    Class cls = [self clsForHeaderOfSection:section];
    //    NSInteger rows = [self numberOfRowsInSection:section];
    CGFloat h = 0;
    if (cls) h = [cls height];
    //    TLOG(@"cls -> %@ h -> %@", cls, @(h));
    return h;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //    TLOG(@"");
    UIView *v = [self headerViewForSection:section];
    //    TLOG(@"v -> %@", v);
    return v;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LITCell *cell = [self cellForIndexPath:indexPath];
    if (!cell) return [self cellForException];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    TLOG(@"");
    NSInteger section = indexPath.section;
    NSInteger idx = indexPath.row;
    LITSectionUnit *unit = [self sectionInSection:section];
    [unit didSelect:idx];
}



#pragma mark - table view stuff


- (NSInteger)numberOfSections{
    return 0;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    LITSectionUnit *unit = [self sectionInSection:section];
    return unit.numberOfRows;
}




//- (UIView *)headerViewOfSection:(NSInteger)section{
//    return [self.tableView headerViewForSection:section];
//}



#pragma mark - UIScrollViewDelegate
- (void)endEditing:(BOOL)endEditing{
    [self.view endEditing:endEditing];
    
    for (NSInteger i = 0; i<self.externalViews.count; i++) {
        UIView *v = [self.externalViews objectAtIndex:i];
        [v endEditing:YES];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self endEditing:YES];
    //    TLOG(@"self.parentView.subviews -> %@", self.parentView.subviews);
}

#pragma mark - error handlers



- (BOOL)setMessagesForError:(id)error{
    if (!error) return NO;
    
    
    AGRemoterError *remoterError;
    NSArray *failureMessages;
    
    if ([error isKindOfClass:[NSError class]]) {
        remoterError = [[AGRemoterError alloc] init];
        [remoterError parseError:error];
    }else if ([error isKindOfClass:[AGRemoterError class]]){
        remoterError = error;
    }else if ( [error isKindOfClass:[NSArray class]]){
        failureMessages = error;
        if (failureMessages.count == 0) return NO;
    }
    
    if (remoterError) failureMessages = [remoterError messages];
    if (failureMessages) [self setFailureMessages:failureMessages];
    
    return YES;
}



#pragma mark - associated cell ops

- (void)setPreviousViewController:(AGViewController *)previousViewController{
    _previousViewController = previousViewController;
    //    TLOG(@"_previousViewController -> %@ self -> %@", previousViewController, self);
}

- (void)setValueForAssociatedIndexPath:(id)value{
    TLOG(@"self.associatedIndexPath -> %@ self.previousViewController -> %@ _previousViewController -> %@ self -> %@", self.associatedIndexPath, self.previousViewController, _previousViewController, self);
    if (self.associatedIndexPath) {
        [self.previousViewController setValue:value atIndexPath:self.associatedIndexPath];
    }
}

- (void)setNeedsReloadAssociatedIndexPath{
    [self.previousViewController setNeedsReloadIndexPath:self.associatedIndexPath];
}

- (void)setNeedsReloadAssociatedViewController{
    TLOG(@"%@", self.className);
    [self.previousViewController setNeedsReloadAll:YES];
}

#pragma mark - external requests

- (void)setValue:(id)value atIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger idx = indexPath.row;
    LITSectionUnit *unit = [self sectionInSection:section];
    [unit setValue:value atIndex:idx];
}



- (id)parameterAtIndexPath:(NSIndexPath *)indexPath{
    //    TLOG(@"indexPath -> %@", indexPath);
    @try {
        NSInteger section = indexPath.section;
        NSInteger idx = indexPath.row;
        LITSectionUnit *unit = [self sectionInSection:section];
        return [unit parameterAtIndex:idx];
    }@catch (NSException *exception) {
        TLOG(@"exception -> %@", exception);
    }
    
    return nil;
}

- (void)action:(id)action atIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger idx = indexPath.row;
    LITSectionUnit *unit = [self sectionInSection:section];
    return [unit action:action atIndex:idx];
}


#pragma mark - header stuff

- (UIView *)headerViewForSection:(NSInteger)section{
    Class cls = [self clsForHeaderOfSection:section];
    id value = nil;
    id title = [self titleForHeaderOfSection:section];
    //    NSInteger rows = [self numberOfRowsInSection:section];
    
    @try {
        value = [self valueForHeaderOfSection:section];
    }@catch (NSException *exception) {
        TLOG(@"exception -> %@", exception);
    }
    
    
    //assemble custom header view
    if (cls){
        AGHeaderView *v = [[cls alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, [cls height])];
        [v setAssociatedViewController:self];
        [v setSection:section];
        [v setValue:value];
        [v setTitle:title];
        return v;
    }
    
    
    return [[UIView alloc] init];
}


- (id)valueForHeaderOfSection:(NSInteger)section{
    LITSectionUnit *unit = [self sectionInSection:section];
    return unit.headerValue;
}

- (id)titleForHeaderOfSection:(NSInteger)section{
    LITSectionUnit *unit = [self sectionInSection:section];
    return unit.headerTitle;
}



- (id)clsForHeaderOfSection:(NSInteger)section{
    LITSectionUnit *unit = [self sectionInSection:section];
    return unit.headerCls;
}

#pragma mark - cell stuff

- (LITCell *)cellForIndexPath:(NSIndexPath *)indexPath{
    Class cls = [self cellClsOfIndexPath:indexPath];
    NSString *cellId = NSStringFromClass(cls);
    LITCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellId];
    id value = [self valueAtIndexPath:indexPath];
    id title = [self titleAtIndexPath:indexPath];
    BOOL visibility = [self visibilityAtIndexPath:indexPath];
    @try {
        if (!cell) {
            cell = [[cls alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId associatedVC:self indexPath:indexPath];
            [cell setAssociatedVC:self]; //adapt to [initWithStyle: reuseIdentifier: ] initializer
        }
//        TLOG(@"%@ -> %@", NSStringFromClass(cls), cell.associatedVC);
        [cell setIndexPath:indexPath]; // update indexPath for reusable cells
        
        if (visibility){
            [cell setHidden:NO];
            [cell setTitle:title];
            [cell setValue:value];
        }else{
            [cell setHidden:YES];
        }
        
    }@catch (NSException *exception) {
        TLOG(@"%@ exception -> %@ %@",cell.class, exception,value);
    }
    
    return cell;
}

- (id)valueAtIndexPath:(NSIndexPath *)indexPath{
    //    TLOG(@"");
    NSInteger section = indexPath.section;
    NSInteger idx = indexPath.row;
    LITSectionUnit *unit = [self sectionInSection:section];
    return [unit valueAtIndex:idx];
}

- (id)titleAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger idx = indexPath.row;
    LITSectionUnit *unit = [self sectionInSection:section];
    return [unit titleAtIndex:idx];
}

- (BOOL)visibilityAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger idx = indexPath.row;
    LITSectionUnit *unit = [self sectionInSection:section];
    return [unit visibilityAtIndex:idx];
}

- (LITCell *)cellAtIndexPath:(NSIndexPath *)indexPath{
    LITCell *cell = (LITCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    return cell;
}

- (void)setCellHeight:(CGFloat)height atIndexPath:(NSIndexPath *)indexPath{
//    TLOG(@"self.core -> %@", self.core);
    [self.core setCellH:@(height) atIndexPath:indexPath];
}

- (CGFloat)cellHeightAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger idx = indexPath.row;
    Class cellCls = [self cellClsOfIndexPath:indexPath];
    LITSectionUnit *unit = [self sectionInSection:section];
    CGFloat hFromUnit = [unit heightAtIndex:idx];
    NSNumber *hFromCore = [self.core cellHAtIndexPath:indexPath];
    
//    TLOG(@"%@ hFromUnit -> %@ hFromCore -> %@ cellClsH -> %@ hFromUnitNotFound -> %@", NSStringFromClass(cellCls), @(hFromUnit), hFromCore, @([cellCls height]), @(hFromUnit==NSNotFound));
    
    if (hFromCore) {
//        TLOG(@"%@ will use hFromCore",NSStringFromClass(cellCls));
        return roundf([hFromCore floatValue]);
    }else if (unit &&
              hFromUnit != NSNotFound) {
//        TLOG(@"%@ will use hFromUnit", NSStringFromClass(cellCls));
        return roundf(hFromUnit);
    }
    
    return [cellCls height];
}

- (Class)cellClsOfIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger idx = indexPath.row;
    LITSectionUnit *unit = [self sectionInSection:section];
    return [unit clsAtIndex:idx];
}

- (LITCell *)cellForException{
    return [[LITCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([LITCell class])];
}


#pragma mark - properties

- (UINavigationBar *)navigationBar{
    return self.navigationController.navigationBar;
}

- (LITVCCore *)core{
    if (!_core) {
        _core = [LITVCCore instance];
    }
    return _core;
}

#pragma mark - style

- (CGFloat)subviewContainerY{
    CGFloat y = 0;
    if (!self.prefersStatusBarHidden) y += STYLE_STATUS_BAR_HEIGHT;
    if ([self.parentViewController isKindOfClass:[UINavigationController class]]) y += STYLE_NAVIGATION_BAR_HEIGHT;
    return y;
}

- (CGFloat)subviewContainerH{
    CGFloat h = STYLE_DEVICE_HEIGHT - self.subviewContainerY;
    if ([self.parentViewController.parentViewController isKindOfClass:[UITabBarController class]]) h -= STYLE_TAB_BAR_HEIGHT;
    return h;
}


@end
