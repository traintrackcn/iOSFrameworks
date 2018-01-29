//
//  AGMultiValueView.m
//  AboveGEM
//
//  Created by traintrackcn on 5/1/15.
//
//

@import LITCommon;
@import LITUICommon;

#import "AGMultiValueView.h"
#import "AGCollectionViewCell.h"
#import "AGCollectionViewCellOfMultiValueCell.h"
#import "AGCollectionViewLayoutHorizontalLabels.h"


@interface AGMultiValueView()<UICollectionViewDataSource, UICollectionViewDelegate>{
    
}

@end

@implementation AGMultiValueView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        paddingLR = 16.0;
        [self addSubview:self.collectionView];
    }
    return self;
}


#pragma mark -

- (UICollectionView *)collectionView{
    if ([DSValueUtil isNotAvailable:_collectionView]) {
        Class cls = self.collectionViewCellCls;
        UICollectionViewLayout *layout = self.collectionViewLayout;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
        
        [_collectionView setDelegate:self];
        [_collectionView setDataSource:self];
        [_collectionView registerClass:cls forCellWithReuseIdentifier:NSStringFromClass(cls)];
        [_collectionView setBackgroundColor:COLOR(RGB_BACKGROUND_NORMAL)];
        
//        [_collectionView setPagingEnabled:YES];
        [_collectionView setShowsHorizontalScrollIndicator:NO];
        [_collectionView setDelegate:self];
        [_collectionView setAllowsSelection:NO];
        [_collectionView setAllowsMultipleSelection:NO];
        
        //        [AGDebugUtil makeBorderForView:collectionV];
    }
    return _collectionView;
}

#pragma mark - properties

- (CGFloat)availableW{
    return [DSDeviceUtil bounds].size.width - paddingLR*2;
}

- (Class)collectionViewCellCls{    
    return [AGCollectionViewCellOfMultiValueCell class];
}

- (UICollectionViewLayout *)collectionViewLayout{
    if ([DSValueUtil isNotAvailable:_collectionViewLayout]) {
        CGSize size = CGSizeMake(self.frame.size.width / 3, 44.0);
        _collectionViewLayout = [[AGCollectionViewLayoutHorizontalLabels alloc] initWithCellSize:size];
    }
    return _collectionViewLayout;
}

- (UIColor *)cellBackgroundColor{
    if (_cellBackgroundColor) {
        return _cellBackgroundColor;
    }
    return [UIColor whiteColor];
}

#pragma mark - 

- (void)setContentOffset:(CGPoint)offset{
    [self.collectionView setContentOffset:offset];
}

- (void)reloadData{
    [self.collectionView reloadData];
}



#pragma mark - UICollectionViewDelegate & DataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = indexPath.row;
    Class cls = self.collectionViewCellCls;
    NSString *cellId = NSStringFromClass(cls);
    AGCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    id value = [self.items objectAtIndex:index];
    //    TLOG(@"value -> %@", value);
    [cell setValue: value];
    [cell setBackgroundColor:[self cellBackgroundColor]];
    return cell;
}

- (void)scrollToIndex:(NSInteger)index animated:(BOOL)animated{
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [DSValueUtil isAvailable:self.items]?self.items.count:0;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint contentOffset = scrollView.contentOffset;
    [self dispatchContentOffsetDidChange:contentOffset];
}

#pragma mark - dispatchers

- (void)dispatchContentOffsetDidChange:(CGPoint)contentOffset{
    if (_delegate && [_delegate respondsToSelector:@selector(multiValueViewContentOffsetDidChange:)]) {
        [_delegate multiValueViewContentOffsetDidChange:contentOffset];
    }
}

@end
