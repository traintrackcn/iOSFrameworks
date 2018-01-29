//
//  LITHorizontalUnitsCell.h
//  AGUIKit
//
//  Created by Tao Yunfei on 16/10/2017.
//  Copyright © 2017 AboveGEM. All rights reserved.
//

#import "LITCell.h"

@interface LITHorizontalUnitsCell : LITCell

- (void)scrollToIndex:(NSInteger)index animated:(BOOL)animated;

- (Class)collectionViewCellCls;
- (Class)collectionViewLayoutCls;
- (UICollectionView *)collectionView;
- (UICollectionViewLayout *)collectionViewLayout;

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger selectedIndex;

@end
