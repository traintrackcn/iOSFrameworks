//
//  LITCollectionViewLayout.m
//  AboveGEM
//
//  Created by Tao Yunfei on 21/08/2017.
//
//

#import "LITCollectionLayoutHorizontalUnits.h"

typedef NS_ENUM(NSInteger, Section) {
    SectionDefault,
    SectionCount
};

@implementation LITCollectionLayoutHorizontalUnits

//- (id)initWithCellSize:(CGSize)size{
//    self = [super init];
//    if (self) {
//        CGFloat cellW = (STYLE_DEVICE_WIDTH - self.paddingLR*2 - self.cellHSpace*2)/3.0;
//        
//        [self setCellW:cellW];
//        [self setCellH:size.height]; //CollectionViewCell
//    }
//    return self;
//}

#pragma mark -

- (void)prepareLayout{
    NSInteger numSections = [self.collectionView numberOfSections];
    for(NSInteger section = 0; section < numSections; section++){
        NSInteger numCells = [self.collectionView numberOfItemsInSection:section];
        CGFloat targetX = self.paddingLR;
        for(NSInteger index = 0; index < numCells; index++){
            
            
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:section];
            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            [attributes setFrame:CGRectMake(targetX, 0, self.cellSize.width, self.cellSize.height)];
            if (index == numCells + 1){
                targetX += self.cellSize.width + self.paddingLR;
            }else{
                targetX += self.cellSize.width + self.cellHSpace;
            }
            [self.cellAttributes setObject:attributes forKey:indexPath];
        }
    }
    //end of first section
    
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
//        TLOG(@"self.collectionView.frame -> %@", NSStringFromCGRect(self.collectionView.frame));
    
    return [super layoutAttributesForItemAtIndexPath:indexPath];
}

- (CGSize)collectionViewContentSize{
    NSInteger numCells = [self.collectionView numberOfItemsInSection:0];
    CGFloat w = self.paddingLR*2 + self.cellSize.width*numCells + self.cellHSpace*(numCells-1);
    return CGSizeMake(w, self.cellSize.height);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *visibleCellAttributes = [NSMutableArray array];
    CGFloat minX = rect.origin.x - self.paddingLR;
    CGFloat maxX = minX + rect.size.width;
    NSInteger numSections = [self.collectionView numberOfSections];
    
    //    TLOG(@"rect -> %@", NSStringFromCGRect(rect));
    
    for (NSInteger section = 0; section < numSections; section ++) {
        NSInteger numCells = [self.collectionView numberOfItemsInSection:section];
        NSInteger maxIdx = numCells - 1;
        CGFloat unitW = self.cellSize.height;
        NSInteger startIdx = floorf(minX/(unitW+self.cellHSpace));
        NSInteger endIdx = ceilf(maxX/(unitW+self.cellHSpace));
        
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

#pragma mark - styles

- (CGFloat)paddingLR{
    return STYLE_PADDING_LR_DEFAULT;
}

- (CGFloat)cellHSpace{
    return 8;
}

- (CGSize)cellSize{
    CGSize size = [super cellSize];
    CGFloat w = (STYLE_DEVICE_WIDTH - self.paddingLR*2 - self.cellHSpace*2)/3.0;
    CGFloat h = size.height;
    return CGSizeMake(w, h);
}

@end
