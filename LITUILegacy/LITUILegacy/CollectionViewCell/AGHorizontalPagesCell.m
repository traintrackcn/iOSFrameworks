//
//  AGCellStyleSelector.m
//  AboveGEM
//
//  Created by traintrackcn on 5/9/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

@import LITCommon;

#import "AGHorizontalPagesCell.h"
#import "AGCollectionViewLayoutHorizontalPages.h"
#import "AGCollectionViewLayoutHorizontalUnits.h"
#import "AGCollectionViewCell.h"
//#import "DSDeviceUtil.h"
//#import "DSValueUtil.h"
//#import "GlobalDefine.h"

@interface AGHorizontalPagesCell() <UICollectionViewDataSource, UICollectionViewDelegate>{
    
}

@property (nonatomic, assign) BOOL switchingIndexByOtherComponents;

@end

@implementation AGHorizontalPagesCell

@synthesize collectionViewItems = _collectionViewItems;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        selectedIndex = NSNotFound;
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    if (newSuperview) {
        [self.contentView addSubview:self.collectionView];
        [self makeDefaultSelection];
    }
}

#pragma mark - assemblers

- (UICollectionView *)collectionView{
//    TLOG(@"");
    if (!_collectionView) {
        Class cls = self.collectionViewCellCls;
        UICollectionViewLayout *layout = self.collectionViewLayout;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [DSDeviceUtil bounds].size.width, self.height) collectionViewLayout:layout];
        [_collectionView setDelegate:self];
        [_collectionView setDataSource:self];
        [_collectionView registerClass:cls forCellWithReuseIdentifier:NSStringFromClass(cls)];
        [_collectionView setBackgroundColor:[UIColor whiteColor]];
//        [self.contentView addSubview:collectionV];
        [_collectionView setPagingEnabled:YES];
    }
    
    return _collectionView;
}



#pragma mark - properties

- (Class)collectionViewCellCls{
    return nil;
}
   
//- (UICollectionView *)collectionView{
//   return collectionV;
//}

- (UICollectionViewLayout *)collectionViewLayout{
    if ([DSValueUtil isNotAvailable:collectionViewLayout]) {
            collectionViewLayout = [[AGCollectionViewLayoutHorizontalPages alloc] init];
        CGSize size = CGSizeMake([DSDeviceUtil bounds].size.width, self.height);
        [collectionViewLayout setCellSize:size]; //CollectionViewCell
    }
    return collectionViewLayout;
}

#pragma mark - selection ops

- (NSInteger)selectedIndex{
    return selectedIndex;
}


- (BOOL)selectIndex:(NSInteger)index{
//    TLOG(@"selectedIndex -> %d index -> %d", selectedIndex, index);
    if(selectedIndex == index) return NO;
    selectedIndex = index;
    return YES;
}

- (void)selectIndexAndDispatchSelectedItem:(NSInteger)index{
    if ([self selectIndex:index]) {
        [self dispatchSelectedItem];
//        [self didDisplayCellAtIndex:index];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
        id cell = [self.collectionView cellForItemAtIndexPath:indexPath];
        [self didDisplayCell:cell];
    }
    
}

- (void)selectIndexAndScrollToIndex:(NSInteger)index{
    if ([self selectIndex:index]) {
        [self setSwitchingIndexByOtherComponents:YES];
        [self scrollToIndex:index animated:YES];
//        [self didDisplayCellAtIndex:index];
//                [self performSelector:@selector(didDisplayCellAtIndex:) withObject:[NSNumber numberWithInt:index] afterDelay:2.0f];
    }
}

- (void)dispatchSelectedItem{
    if (self.selectedItem){
        [self didSelectItem:self.selectedItem];
    }
}



- (void)scrollToIndex:(NSInteger)index animated:(BOOL)animated{
    
    CGFloat targetContentOffsetX = [DSDeviceUtil bounds].size.width * index;
//    TLOG(@"targetContentOffsetX:%f collectionV.contentOffset.x:%f %@", targetContentOffsetX, collectionV.contentOffset.x, collectionV);
    if (self.collectionView.contentOffset.x != targetContentOffsetX){
        [self.collectionView setContentOffset:CGPointMake(targetContentOffsetX, 0) animated:animated];
    }
}

- (void)didDisplayCell:(id)cell{
    
}

- (void)didSelectItem:(id)item{
    
}

- (id)selectedItem{
    if (!self.items) return nil;
    return [self.items objectAtIndex:selectedIndex];
}

- (void)makeDefaultSelection{
    if (selectedIndex != NSNotFound) return;
    [self selectIndex:0];
}



#pragma mark - setter


- (void)setCollectionViewItems:(NSArray *)collectionViewItems{
//    TLOG(@"theItems -> %@", theItems);
//    if (_items) return;
    if (![collectionViewItems isKindOfClass:[NSArray class]]) return;
    _collectionViewItems = collectionViewItems;
    [self.collectionView reloadData];
}

- (NSArray *)items{
    if (!_collectionViewItems) return @[];
    return _collectionViewItems;
}

- (void)didSetValue:(id)value{
//    [super setValue:value];
    [self setCollectionViewItems:value];
//    TLOG(@"value -> %@", value);
}


#pragma mark - UICollectionViewDelegate & DataSource

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.switchingIndexByOtherComponents) {
        [self didDisplayCell:cell];
        [self setSwitchingIndexByOtherComponents:NO];
    }
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = indexPath.row;
    Class cls = self.collectionViewCellCls;
    NSString *cellId = NSStringFromClass(cls);
    id value = [self.items objectAtIndex:index];
    AGCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    [cell setAssociatedViewController:self.associatedViewController];
    [cell setValue:value];
//    TLOG(@"idx:%d value:%@", index, value);
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.items?self.items.count:0;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
//    CGFloat contentW = scrollView.contentSize.width;
    CGFloat targetContentOffsetX = (*targetContentOffset).x;
    NSInteger targetIdx = targetContentOffsetX/[DSDeviceUtil bounds].size.width;
//    TLOG(@"targetIdx -> %d", targetIdx);
//    TLOG(@"");
    [self selectIndexAndDispatchSelectedItem:targetIdx];
}


@end
