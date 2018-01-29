//
//  AGHorizontalSelectorCell.h
//  AboveGEM
//
//  Created by traintrackcn on 21/10/14.
//
//

#import "AGCell.h"

@interface AGHorizontalUnitsCell : AGCell{

}

- (void)scrollToIndex:(NSInteger)index animated:(BOOL)animated;

- (Class)collectionViewCellCls;
- (Class)collectionViewLayoutCls;
- (UICollectionView *)collectionView;
- (UICollectionViewLayout *)collectionViewLayout;

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger selectedIndex;

@end
