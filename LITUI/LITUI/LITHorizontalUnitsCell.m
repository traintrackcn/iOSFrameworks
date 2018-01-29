//
//  LITHorizontalUnitsCell.m
//  AGUIKit
//
//  Created by Tao Yunfei on 16/10/2017.
//  Copyright © 2017 AboveGEM. All rights reserved.
//

@import LITCommon;
@import LITUILegacy;

#import "LITHorizontalUnitsCell.h"

typedef NS_ENUM(NSInteger, Section) {
    SectionDefault,
    SectionCount
};

@interface LITHorizontalUnitsCell () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionViewLayout *collectionViewLayout;

@end

@implementation LITHorizontalUnitsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier associatedVC:(id)associatedVC indexPath:(NSIndexPath *)indexPath{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier associatedVC:associatedVC indexPath:indexPath];
    if (self) {
        //        [self assembleCollectionView];
        [self.contentView addSubview:self.collectionView];
        [self _setSelectedIndex:NSNotFound];
    }
    return self;
}

#pragma mark - setters

- (void)setItems:(NSArray *)items{
    if (![items isKindOfClass:[NSArray class]]) return;
    _items = items;
    [self.collectionView reloadData];
}

- (void)_setSelectedIndex:(NSInteger)selectedIndex{
    _selectedIndex = selectedIndex;
}

- (void)setSelectedIndex:(NSInteger)targetIndex{
    if (self.selectedIndex == targetIndex) return;
    
    UICollectionViewCell *selectedCell = [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:self.selectedIndex inSection:SectionDefault]];
    UICollectionViewCell *targetCell = [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:targetIndex inSection:SectionDefault]];
    [selectedCell setSelected:NO];
    [targetCell setSelected:YES];
    
    [self _setSelectedIndex:targetIndex];
    
    [self scrollToIndex:targetIndex animated:YES];
}

#pragma mark - common ops

- (void)scrollToIndex:(NSInteger)index animated:(BOOL)animated{
    @try {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }@catch (NSException *exception) {
        //        TLOG(@"exception -> %@", exception);
    }
}

#pragma mark - events


- (void)didSelectItem:(id)item{
    
}


#pragma mark - components

- (Class)collectionViewCellCls{
    return nil;
}

- (Class)collectionViewLayoutCls{
    return [AGCollectionViewLayoutHorizontalUnits class];
}

- (UICollectionViewLayout *)collectionViewLayout{
    if (!_collectionViewLayout ) {
        CGFloat w = [DSDeviceUtil bounds].size.width / 3;
        CGFloat h = self.height;
        CGSize size = CGSizeMake(w, h);
        Class cls = [self collectionViewLayoutCls];
        _collectionViewLayout = [[cls alloc] initWithCellSize:size];
    }
    return _collectionViewLayout;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        Class cls = self.collectionViewCellCls;
        UICollectionViewLayout *layout = self.collectionViewLayout;
        CGFloat w = [DSDeviceUtil bounds].size.width;
        CGFloat h = self.height;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, w, h) collectionViewLayout:layout];
        [_collectionView setDelegate:self];
        [_collectionView setDataSource:self];
        [_collectionView registerClass:cls forCellWithReuseIdentifier:NSStringFromClass(cls)];
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        
        
        
        [_collectionView setPagingEnabled:YES];
        [_collectionView setShowsHorizontalScrollIndicator:NO];
        [_collectionView setDelegate:self];
        [_collectionView setAllowsSelection:YES];
        [_collectionView setAllowsMultipleSelection:NO];
    }
    return _collectionView;
}

#pragma mark - properties

- (id)selectedItem{
    if (!self.items) return nil;
    return [self.items objectAtIndex:self.selectedIndex];
}


#pragma mark - styles

- (void)applySelectedStyle{
    
}

- (void)applyUnselectedStyle{
    
}

#pragma mark - UICollectionViewDelegate & DataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = indexPath.row;
    Class cls = self.collectionViewCellCls;
    NSString *cellId = NSStringFromClass(cls);
    AGCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    [cell setValue:[self.items objectAtIndex:index]];
    
    //    TLOG(@"index -> %d selectedIndex -> %d", index, selectedIndex);
    if (index == self.selectedIndex ) {
        [cell setSelected:YES];
    }else{
        [cell setSelected:NO];
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return SectionCount;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.numberOfItems;
}

- (NSInteger)numberOfItems{
    return self.items?self.items.count:0;
}

#pragma mark - UICollectionViewDelegate

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger targetIdx = indexPath.row;
    
    if ( targetIdx != self.selectedIndex) {
        
        //unhighlight selected cell
        @try {
            UICollectionViewCell *selectedCell = [collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:self.selectedIndex inSection:SectionDefault]];
            [selectedCell setSelected:NO];
        }@catch (NSException *exception) {}
        
        
        if(self.selectedIndex != targetIdx){
            self.selectedIndex = targetIdx;
            
            if (self.selectedItem){
                [self didSelectItem:self.selectedItem];
            }
        }
        
        [self scrollToIndex:targetIdx animated:YES];
        
        
    }
}

@end
