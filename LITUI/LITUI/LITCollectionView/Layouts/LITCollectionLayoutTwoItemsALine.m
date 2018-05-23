//
//  LITCellProductionCollectionLayout.m
//  AboveGEM
//
//  Created by Tao Yunfei on 17/09/2017.
//
//

@import LITCommon;

#import "LITCollectionLayoutTwoItemsALine.h"


@interface LITCollectionLayoutTwoItemsALine(){

}


@end

@implementation LITCollectionLayoutTwoItemsALine

#pragma mark -

- (void)prepareLayout{
//    for(NSInteger section = 0; section < self.numberOfSections; section++){
//        NSInteger numberOfItems = [self numberOfItemsInSection:section];
//        for(NSInteger index = 0; index < numberOfItems; index++){
//            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:section];
//            UICollectionViewLayoutAttributes *attributes = [self attributesForIndexPath:indexPath];
//            [self.attributesDic setObject:attributes forKey:indexPath];
//        }
//    }
    //end of first section
    
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger idx = indexPath.row;
    UICollectionViewLayoutAttributes *attributes;
//    TLOG(@"indexPath -> %@", indexPath);
    @try {
        attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        NSInteger lineIdx = floor(idx/2);
        CGFloat w = self.itemSize.width - self.hSpace/2.0;
        CGFloat h = self.itemSize.height;
        CGFloat x = (idx%2)*w;
        CGFloat y = lineIdx * self.itemSize.height + lineIdx*self.vSpace;
        
        x = (x==0) ? 0:(x+self.hSpace);
        
        [attributes setFrame:CGRectMake(x, y, w, h)];
    } @catch (NSException *exception) {
        TLOG(@"exception -> %@", exception);
    } @finally {
        
    }
    
//    TLOG(@"attributes -> %@", attributes);
    
    return attributes;
}

- (CGSize)collectionViewContentSize{
    CGFloat w = self.collectionView.frame.size.width;
    CGFloat h = self.numberOfLines*self.itemSize.height + self.vSpace*(self.numberOfLines-1);
    return CGSizeMake(w, h);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *tmpArr = [NSMutableArray array];
    CGFloat startY = rect.origin.y;
    CGFloat endY = startY + rect.size.height;
    NSInteger startLine = floorf(startY/(self.itemSize.height+self.vSpace));
    NSInteger endLine = ceilf(endY/(float)(self.itemSize.height+self.vSpace));
    
    startLine = startLine>0 ? startLine:0;
    endLine = endLine>0 ? endLine:0;
    
//    TLOG(@"startLine -> %@ endLine -> %@ ", @(startLine),@(endLine));
    
    for (NSInteger line = startLine; line < endLine; line ++) {
        NSInteger idxL = line*2;
        NSInteger idxR = idxL + 1;
        [self appendAttributesAtIndex:idxL toArr:tmpArr];
        [self appendAttributesAtIndex:idxR toArr:tmpArr];
    }
    
    return tmpArr;
}

- (void)appendAttributesAtIndex:(NSInteger)idx toArr:(NSMutableArray *)tmpArr{
    NSInteger section = 0;
    NSInteger lastIdx = self.numberOfItems - 1;
    if (idx <= lastIdx){
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:section];
        [tmpArr addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
}


#pragma mark - properties

- (NSInteger)numberOfLines{
    return ceilf((float)self.numberOfItems/2.0);
}

- (NSInteger)numberOfItems{
    return [self.collectionView numberOfItemsInSection:0];
}

#pragma mark - styles

- (CGFloat)vSpace{
    return 6; 
}

- (CGFloat)hSpace{
    return 6;
}

@end
