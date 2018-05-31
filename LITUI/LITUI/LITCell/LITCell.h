//
//  LITCell.h
//  AboveGEM
//
//  Created by Tao Yunfei on 24/08/2017.
//
//

@import LITCommon;
@import UIKit;
@import LITUILegacy;

#import "LITCellCharacter.h"


@class AGObjectPool;
@class LITVCCore;

@interface LITCell : UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier associatedVC:(id)associatedVC indexPath:(NSIndexPath *)indexPath;

- (void)_setValue:(id)value;
- (void)_setTitle:(id)title;
- (void)setStyle;

#pragma mark - dispatchers

- (void)reload;
- (void)setValueForViewController:(id)value;
- (NSArray *)parametersFromViewController;
- (void)sendActionRequestToViewController:(id)action;


#pragma mark - styles
+ (CGFloat)height;
@property (nonatomic, assign) CGFloat height;

#pragma mark - properties

- (UITableView *)tableView;
- (LITCellCharacter *)character;
- (AGObjectPool *)objPoolOfAssociatedVC;
- (id)associatedViewController DEPRECATED_WITH_MSG("use associatedVC instead");

@property (nonatomic, strong) AGObjectPool *objPool;

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) id value;
@property (nonatomic, weak) id ws;
@property (nonatomic, weak) id associatedVC;
@property (nonatomic, weak) id associatedTV; // for LITCellTableView use

@end
