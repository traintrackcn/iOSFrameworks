//
//  AGFormInput.m
//  AboveGEM
//
//  Created by traintrackcn on 11/7/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

@import LITCommon;
@import LITUICommon;

#import "AGCell.h"
#import "AGVCConfiguration.h"
#import "AGViewController.h"



@interface AGCell(){
    
}

@end

@implementation AGCell


@synthesize height = _height;
@synthesize value = _value;

- (id)init{
   @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"%@ Failed to call designated initializer. Invoke `initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifie:` instead.", NSStringFromClass([self class])] userInfo:nil];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
//        [self setBackgroundColor:[UIColor clearColor]];
        [self setWs:self];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier associatedViewController:(id)associatedViewController indexPath:(NSIndexPath *)indexPath{
    self = [self initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self setAssociatedViewController:associatedViewController];
        [self setIndexPath:indexPath];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier associatedViewController:(id)associatedViewController indexPath:(NSIndexPath *)indexPath config:(AGVCConfiguration *)config{
    self = [self initWithStyle:style reuseIdentifier:reuseIdentifier associatedViewController:associatedViewController indexPath:indexPath];
    if (self) {
        [self setConfig:config];
    }
    return self;
}

- (void)dealloc{
    [_remoter cancel];
    _remoter = nil;
    if (self.obUIKeyboardWillChangeFrameNotification) {
        [[NSNotificationCenter defaultCenter] removeObserver:self.obUIKeyboardWillChangeFrameNotification];
    }
}

#pragma mark -

- (AGObjectPool *)objPool{
    if (!_objPool) {
        _objPool = [AGObjectPool instance];
        [_objPool setParentClassName:NSStringFromClass(self.class)];
    }
    return _objPool;
}

- (AGObjectPool *)objPoolOfAssociatedVC{
    return [self.associatedViewController objPool];
}


#pragma mark - properties

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
//    TLOG(@"selected -> %@", @(selected));
    [super setSelected:selected animated:animated];
    if (selected) {
        [self applySelectedStyle];
    }else{
        [self applyUnselectedStyle];
    }
}

#pragma mark - properties

- (AGRemoter *)remoter{
    if (!_remoter) {
        _remoter = [AGRemoter instanceWithDelegate:self];
    }
    return _remoter;
}

- (UITableView *)tableView{
    if ([self.associatedViewController isKindOfClass:[AGViewController class]]) {
        return [(AGViewController *)self.associatedViewController tableView];
    }
    return nil;
}

- (void)endEditingForAssociatedView{
    [[(AGViewController *)self.associatedViewController view] endEditing:YES];
}

- (AGVCConfiguration *)config{
    if (_config) return _config;
    AGViewController *vc = (AGViewController *)self.associatedViewController;
    if (!vc) return nil;
    return vc.config;
}

- (void)_setValue:(id)value{
    _value = value;
}

- (void)_setTitle:(id)title{
    _title = title;
}

- (void)setValue:(id)value{
    if ([self isCachedValueSameAsTargetValue:value]) return;
    _value = value;
    [self didSetValue:value];
    
//    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self.ws layout];
//    }];
}

- (void)layout{
    
}

- (void)didSetValue:(id)value{
    
}

- (BOOL)isCachedValueSameAsTargetValue:(id)targetValue{
    if (_value && targetValue){
//        TLOG(@"_value -> %@ new value -> %@ same -> %d %@ %@", _value, targetValue, [targetValue isEqual:self.value], [_value class], [targetValue class]);
        if ([targetValue isEqual:_value]) return YES;
    }
    return NO;
}

- (BOOL)isContentViewLoaded{
    if (self.contentView.subviews.count == 0) {
        return NO;
    }
    return YES;
}

- (BOOL)isContentViewBlank{
    return !self.isContentViewLoaded;
}

#pragma mark -

- (void)reloadAssociatedViewController{
    [self.associatedViewController reloadVisibleIndexPaths];
}

#pragma mark - assemblers

- (void)assembleGC{
//    TLOG(@"self.tapGestureRecognizer -> %@", self.tapGestureRecognizer);
    [self addGestureRecognizer:self.tapGestureRecognizer];
}

#pragma mark - interactive actions

- (void)didTapAny:(id)sender{
    [self didTapCell];
}

- (void)didTapCell{
//    [self dispatchRequestSetCurrentIndexPath];
    [self activateSelector];
}

- (void)activateSelector{
    AGViewController *vc = self.associatedViewController;
    [vc.view endEditing:YES];
}

#pragma mark - utils

- (void)reload{
    [_associatedViewController reloadIndexPath:self.indexPath];
}

- (void)setValueForViewController:(id)value{
    [_associatedViewController setValue:value atIndexPath:self.indexPath];
}

- (NSArray *)parametersFromViewController{
    id obj = [_associatedViewController parameterAtIndexPath:self.indexPath];
    if (!obj) return @[];
    if ([obj isKindOfClass:[NSArray class]]) {
        return (NSArray *)obj;
    }
    
    return @[obj];
}

- (void)sendActionRequestToViewController:(id)action{
//    TLOG(@"_associatedViewController -> %@", _associatedViewController);
//    TLOG(@"action -> %@", action);
    [_associatedViewController action:action atIndexPath:self.indexPath];
}

#pragma mark - AGRemoterDelegate

- (void)remoterDataReceived:(id)responseData withRequestData:(DSRequestInfo *)request{
    
}

#pragma mark - styles

- (void)setHeight:(CGFloat)height{
    _height = height;
    [self.config setCellHeight:height atIndexPath:self.indexPath];
}

+ (CGFloat)height{
    return 44.0;
}

//dynamic height by value
+ (CGFloat)heightOfValue:(id)value{
    return NSNotFound;
}

- (CGFloat)height{
//    if([self.config cellHeightCalculatedAtIndexPath:self.indexPath]){
//        return [self.config cellHeightAtIndexPath:self.indexPath];
//    }
//    TLOG(@"h -> %f", h);
    if (self.indexPath && self.config) return [self.config cellHeightAtIndexPath:self.indexPath forValue:nil];
//    TLOG(@"_height -> %@ indexPath -> %@", @(_height), self.indexPath);
    if (_height) return _height;
    return [self.class height];
}








//- (CGFloat)borderWidth{
//    return .5f;
//}
//
//- (UIColor *)borderColor{
//    return COLOR(AG_UI_DEFINE.RGB_BORDER);
//}


- (void)applySelectedStyle{
    [self setBackgroundColor:COLOR(AG_UI_DEFINE.RGB_CELL_BACKGROUND_HIGHLIGHT)];
    self.textLabel.textColor = COLOR(AG_UI_DEFINE.RGB_CELL_TITLE_HIGHLIGHT);
    self.detailTextLabel.textColor = COLOR(AG_UI_DEFINE.RGB_CELL_CONTENT_HIGHLIGHT);
}

- (void)applyUnselectedStyle{
    [self setBackgroundColor:COLOR(RGB_WHITE)];
    self.textLabel.textColor = COLOR(AG_UI_DEFINE.RGB_CELL_TITLE_NORMAL);
    self.detailTextLabel.textColor = COLOR(AG_UI_DEFINE.RGB_CELL_CONTENT_NORMAL);
}


@end
