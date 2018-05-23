//
//  LITCollectionLayoutCellProductContainer.m
//  AboveGEM
//
//  Created by Tao Yunfei on 17/09/2017.
//
//

#import "LITCollectionLayoutPageItems.h"

@import LITUICommon;

@interface LITCollectionLayoutPageItems(){

}



@end

@implementation LITCollectionLayoutPageItems

- (void)prepareLayout{
    
    
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
//    TLOG(@"indexPath -> %@", indexPath);
    NSInteger idx = indexPath.row;
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat w = self.itemSize.width;
    CGFloat h = self.itemSize.height;
    CGFloat x = idx*w;
    CGFloat y = 0;
    [attributes setFrame:CGRectMake(x, y, w, h)];
    return attributes;
}

- (CGSize)collectionViewContentSize{
    CGFloat w = STYLE_DEVICE_WIDTH * self.numberOfItems;
    CGFloat h = self.itemSize.height;
    return CGSizeMake(w, h);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *tmpArr = [NSMutableArray array];
    CGFloat startX = rect.origin.x;
    CGFloat endX = startX + rect.size.width;
    NSInteger startIdx = floorf(startX/STYLE_DEVICE_WIDTH);
    NSInteger endIdx = ceilf(endX/(float)STYLE_DEVICE_WIDTH);
    
    startIdx = startIdx>0 ? startIdx:0;
    endIdx = endIdx>0 ? endIdx:0;
    
//    TLOG(@"startIdx -> %@  endIdx -> %@ ", @(startIdx), @(endIdx));
    NSInteger section = 0;
    for (NSInteger i = startIdx; i < endIdx; i ++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:section];
        [tmpArr addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    
    return tmpArr;
}


#pragma mark - properties

- (NSInteger)numberOfItems{
    return [self.collectionView numberOfItemsInSection:0];
}

#pragma mark - styles

- (CGSize)itemSize{
    if (CGSizeEqualToSize(CGSizeZero, [super itemSize])){
        CGFloat w = STYLE_DEVICE_WIDTH;
        CGFloat h = STYLE_DEVICE_HEIGHT;
        [super setItemSize:CGSizeMake(w, h)];
    }
    return [super itemSize];
}

@end
