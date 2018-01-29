//
//  AGCellStyleSelector.h
//  AboveGEM
//
//  Created by traintrackcn on 5/9/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import "AGCell.h"

@class AGCollectionViewLayout;

@interface AGHorizontalPagesCell : AGCell {
    NSInteger selectedIndex;
//    NSArray *items;
//    UICollectionView *collectionV;
    AGCollectionViewLayout *collectionViewLayout;
    
    
}


- (Class)collectionViewCellCls;
//- (UICollectionView *)collectionView;

- (NSInteger)selectedIndex;
- (BOOL)selectIndex:(NSInteger)index;
- (void)selectIndexAndDispatchSelectedItem:(NSInteger)index;
- (void)selectIndexAndScrollToIndex:(NSInteger)index;
- (void)scrollToIndex:(NSInteger)index animated:(BOOL)animated;

- (void)didSelectItem:(id)item;
- (void)didDisplayCell:(id)cell;
- (void)dispatchSelectedItem;


- (UICollectionViewLayout *)collectionViewLayout;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *collectionViewItems;


@end
