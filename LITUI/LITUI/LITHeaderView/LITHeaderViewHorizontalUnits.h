//
//  LITHorizontalUnitsHeaderView.h
//  AboveGEM
//
//  Created by Tao Yunfei on 24/08/2017.
//
//

#import "LITHeaderView.h"

@interface LITHeaderViewHorizontalUnits : LITHeaderView

- (void)scrollToIndex:(NSInteger)index animated:(BOOL)animated;

- (Class)collectionViewCellCls;
- (Class)collectionViewLayoutCls;
- (UICollectionView *)collectionView;
- (UICollectionViewLayout *)collectionViewLayout;


@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger selectedIndex;


@end
