//
//  AGSelectorLayoutStyleHorizontal.m
//  AboveGEM
//
//  Created by traintrackcn on 21/10/14.
//
//

#import "AGCollectionViewLayoutHorizontalUnits.h"

@interface AGCollectionViewLayoutHorizontalUnits(){
    
}

@end

@implementation AGCollectionViewLayoutHorizontalUnits

//- (id)initWithCellSize:(CGSize)size{
//    self = [super init];
//    if (self) {
//        [self setCellW:size.width];
//        [self setCellH:size.height]; //CollectionViewCell
//    }
//    return self;
//}

#pragma mark -

- (void)prepareLayout{
    NSInteger numSections = [self.collectionView numberOfSections];
    for(NSInteger section = 0; section < numSections; section++){
        NSInteger numCells = [self.collectionView numberOfItemsInSection:section];
        CGFloat targetX = 0;
        for(NSInteger index = 0; index < numCells; index++){
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:section];
            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            [attributes setFrame:CGRectMake(targetX, 0, self.cellSize.width, self.cellSize.height)];
            targetX += self.cellSize.width;
            [self.cellAttributes setObject:attributes forKey:indexPath];
        }
    }
    //end of first section
    
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
//    TLOG(@"self.collectionView.frame -> %@", NSStringFromCGRect(self.collectionView.frame));
    
    return [self.cellAttributes objectForKey:indexPath];
}

- (CGSize)collectionViewContentSize{
    NSInteger numCells = [self.collectionView numberOfItemsInSection:0];
    return CGSizeMake(numCells*self.cellSize.width, self.cellSize.height);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *visibleCellAttributes = [NSMutableArray array];
    CGFloat minX = rect.origin.x;
    CGFloat maxX = minX + rect.size.width;
    NSInteger numSections = [self.collectionView numberOfSections];
    
    //    TLOG(@"rect -> %@", NSStringFromCGRect(rect));
    
    for (NSInteger section = 0; section < numSections; section ++) {
        NSInteger numCells = [self.collectionView numberOfItemsInSection:section];
        NSInteger maxIdx = numCells - 1;
        CGFloat unitW = self.cellSize.width;
        NSInteger startIdx = floorf(minX/unitW);
        NSInteger endIdx = ceilf(maxX/unitW);
        
        if (endIdx > maxIdx) endIdx = maxIdx;
        if (startIdx < 0) startIdx = 0;
//        TLOG(@"unitW -> %f", unitW);
//        TLOG(@"minX -> %f maxX -> %f", minX, maxX);
//        TLOG(@"startIdx -> %d endIdx -> %d", startIdx, endIdx);
 //       TLOG(@"cellAttributesDic -> %@", cellAttributesDic);
        for (NSInteger i = startIdx; i<= endIdx; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            UICollectionViewLayoutAttributes *attributes = [self.cellAttributes objectForKey:indexPath];
            //            TLOG(@"attributes -> %@ indexPath -> %@", attributes, indexPath);
            [visibleCellAttributes addObject:attributes];
        }
    }
    
    
    
    return visibleCellAttributes;
}

@end
