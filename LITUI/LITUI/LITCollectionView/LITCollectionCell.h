//
//  LITCollectionViewCell.h
//  AboveGEM
//
//  Created by Tao Yunfei on 17/09/2017.
//
//

#import <UIKit/UIKit.h>

@interface LITCollectionCell : UICollectionViewCell

- (void)_setTitle:(id)title;
- (void)_setValue:(id)value;

- (UITableView *)tableView;
//- (BOOL)tableViewScrolledToBottom;
- (void)sendActionRequestToViewController:(id)action;
- (void)didTapAny:(id)sender;

@property (nonatomic, assign) BOOL disabled;
@property (nonatomic, strong) id title;
@property (nonatomic, strong) id value;
@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, weak) id associatedVC;
@property (nonatomic, weak) id associatedIndexPath;
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;

@end
