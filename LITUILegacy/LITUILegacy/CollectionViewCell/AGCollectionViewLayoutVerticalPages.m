//
//  AGVerticalPageLayout.m
//  AboveGEM
//
//  Created by traintrackcn on 5/11/14.
//
//

#import "AGCollectionViewLayoutVerticalPages.h"

@implementation AGCollectionViewLayoutVerticalPages

- (id)init{
    self = [super init];
    if (self) {
        cellAttributesDic = [NSMutableDictionary dictionary];
        
        
    }
    return self;
}


#pragma mark -

- (void)prepareLayout{
    
    cellW = self.collectionView.frame.size.width;
    cellH = self.collectionView.frame.size.height; //CollectionViewCell
    
    NSInteger numSections = [self.collectionView numberOfSections];
    for(NSInteger section = 0; section < numSections; section++){
        NSInteger numCells = [self.collectionView numberOfItemsInSection:section];
        CGFloat targetY = 0;
        for(NSInteger index = 0; index < numCells; index++){
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:section];
            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            [attributes setFrame:CGRectMake(0, targetY, cellW, cellH)];
            targetY += cellH;
            [cellAttributesDic setObject:attributes forKey:indexPath];
        }
    }
    //end of first section
    
}


- (CGSize)collectionViewContentSize{
    NSInteger numCells = [self.collectionView numberOfItemsInSection:0];
//    TLOG(@"numCells -> %ld", numCells);
    return CGSizeMake(cellW, numCells*cellH);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *visibleCellsAttributes = [NSMutableArray array];
    CGFloat minY = rect.origin.y;
    CGFloat maxY = minY + rect.size.height;
    NSInteger numSections = [self.collectionView numberOfSections];
    
    //    TLOG(@"rect -> %@", NSStringFromCGRect(rect));
    
    for (NSInteger section = 0; section < numSections; section ++) {
        NSInteger numCells = [self.collectionView numberOfItemsInSection:section];
        NSInteger maxIdx = numCells - 1;
        NSInteger startIdx = floorf(minY/cellH);
        NSInteger endIdx = ceilf(maxY/cellH);
        
        if (endIdx > maxIdx) endIdx = maxIdx;
        if (startIdx < 0) startIdx = 0;
        //        TLOG(@"unitW -> %f", unitW);
        //        TLOG(@"minX -> %f maxX -> %f", minX, maxX);
        //        TLOG(@"startIdx -> %d endIdx -> %d", startIdx, endIdx);
        //        TLOG(@"cellAttributesDic -> %@", cellAttributesDic);
        for (NSInteger i = startIdx; i<= endIdx; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            UICollectionViewLayoutAttributes *attributes = [cellAttributesDic objectForKey:indexPath];
            //            TLOG(@"attributes -> %@ indexPath -> %@", attributes, indexPath);
            [visibleCellsAttributes addObject:attributes];
        }
    }
    
    
    
    return visibleCellsAttributes;
}

@end
