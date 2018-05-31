//
//  LITCell.m
//  AboveGEM
//
//  Created by Tao Yunfei on 24/08/2017.
//
//

@import LITCommon;
@import LITUILegacy;

#import "LITCell.h"
#import "LITVC.h"

@interface LITCell ()

@end

@implementation LITCell


- (id)init{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"%@Invoke `[initWithStyle: reuseIdentifier: associatedVC:]` instead.", NSStringFromClass([self class])] userInfo:nil];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"%@Invoke `[initWithStyle: reuseIdentifier: associatedVC:]` instead.", NSStringFromClass([self class])] userInfo:nil];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier associatedVC:(id)associatedVC indexPath:(NSIndexPath *)indexPath{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setWs:self];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self setAssociatedVC:associatedVC];
        [self setIndexPath:indexPath]; //make sure right indexPath when initializing cell
        
        [self setStyle];
    }
    return self;
}

#pragma mark - interactive ops

- (void)didTapAny:(id)sender{
    
}

#pragma mark - setters

- (void)_setValue:(id)value{
    _value = value;
}

- (void)_setTitle:(id)title{
    _title = title;
}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
//    //    TLOG(@"selected -> %@", @(selected));
//    [super setSelected:selected animated:animated];
//    if (selected) {
//        [self applySelectedStyle];
//    }else{
//        [self applyUnselectedStyle];
//    }
//}

- (void)setStyle{
    [self setBackgroundColor:COLOR(RGB_WHITE)];
    self.textLabel.textColor = COLOR(AG_UI_DEFINE.RGB_CELL_TITLE_NORMAL);
    self.detailTextLabel.textColor = COLOR(AG_UI_DEFINE.RGB_CELL_CONTENT_NORMAL);
}

#pragma mark - utils

- (void)reload{
    [self.associatedVC reloadIndexPath:self.indexPath];
}

- (void)setValueForViewController:(id)value{
    [self.associatedVC setValue:value atIndexPath:self.indexPath];
}

- (NSArray *)parametersFromViewController{
    id obj = [self.associatedVC parameterAtIndexPath:self.indexPath];
    if (!obj) return @[];
    if ([obj isKindOfClass:[NSArray class]]) {
        return (NSArray *)obj;
    }
    
    return @[obj];
}

- (void)sendActionRequestToViewController:(id)action{
    [self.associatedVC action:action atIndexPath:self.indexPath];
}

#pragma mark - properties

- (AGObjectPool *)objPool{
    if (!_objPool) {
        _objPool = [AGObjectPool instance];
        [_objPool setParentClassName:NSStringFromClass(self.class)];
    }
    return _objPool;
}

- (AGObjectPool *)objPoolOfAssociatedVC{
    return [self.associatedVC objPool];
}

- (id)associatedViewController{
    return self.associatedVC;
}

- (LITCellCharacter *)character{
    return self.parametersFromViewController.firstObject;
}

- (UITableView *)tableView{
    return [self.associatedVC tableView];
}

#pragma mark - styles

+ (CGFloat)height{
    return 44.0;
}

- (void)setHeight:(CGFloat)height{
//    TLOG(@"self.associatedVC -> %@", self.associatedVC);
    if (self.associatedTV){
        [self.associatedTV setCellHeight:height atIndexPath:self.indexPath];
    }else{
        [self.associatedVC setCellHeight:height atIndexPath:self.indexPath];
    }
}

- (CGFloat)height{
    if (self.associatedTV) {
        CGFloat h = [self.associatedTV cellHeightAtIndexPath:self.indexPath];
        if (h != NSNotFound) return h;
    }
    return [self.associatedVC cellHeightAtIndexPath:self.indexPath];
        
}

- (UIColor *)borderColor{
    return COLOR(RGB_BORDER);
}

- (CGFloat)paddingLR{
    return STYLE_PADDING_LR_DEFAULT;
}



//- (void)applySelectedStyle{
//    [self setBackgroundColor:COLOR(AG_UI_DEFINE.RGB_CELL_BACKGROUND_HIGHLIGHT)];
//    self.textLabel.textColor = COLOR(AG_UI_DEFINE.RGB_CELL_TITLE_HIGHLIGHT);
//    self.detailTextLabel.textColor = COLOR(AG_UI_DEFINE.RGB_CELL_CONTENT_HIGHLIGHT);
//}
//
//- (void)applyUnselectedStyle{
//    [self setBackgroundColor:COLOR(RGB_WHITE)];
//    self.textLabel.textColor = COLOR(AG_UI_DEFINE.RGB_CELL_TITLE_NORMAL);
//    self.detailTextLabel.textColor = COLOR(AG_UI_DEFINE.RGB_CELL_CONTENT_NORMAL);
//}



@end
