//
//  LITCollectionLayoutGridItems.m
//  AboveGEM
//
//  Created by Tao Yunfei on 19/09/2017.
//
//

#import "LITCollectionLayoutFullGridItems.h"

@interface LITCollectionLayoutFullGridItems(){

}

@property (nonatomic, strong) NSMutableDictionary *attributesDic;

@end

@implementation LITCollectionLayoutFullGridItems

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setHSpace:12.0];
        [self setVSpace:15.0];
    }
    return self;
}

- (void)prepareLayout{
    
    CGFloat x = 0;
    CGFloat y = self.vSpace;
    CGFloat w = self.itemSize.width;
    CGFloat h = self.itemSize.height;
    
    for (NSInteger i = 0; i<self.numberOfItems; i++) {
        
        if (i&&(i%self.itemsPerLine == 0)){ //going to new line
            y += h + self.vSpace;
            x = 0;
        }
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        
        [attributes setFrame:CGRectMake(x, y, w, h)];
        [self.attributesDic setObject:attributes forKey:indexPath];
        
        x += w + self.hSpace;
    
    }
    
//    TLOG(@"numberOfLines -> %@", @(self.numberOfLines));
    
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [self.attributesDic objectForKey:indexPath];
}

- (CGSize)collectionViewContentSize{
    CGFloat w = self.collectionView.frame.size.width;
    CGFloat h = self.numberOfLines * self.itemSize.height + (self.numberOfLines + 1)*self.vSpace;
    return CGSizeMake(w, h);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
//    TLOG(@"self.attributesDic.allValues -> %@", self.attributesDic.allValues);
    return self.attributesDic.allValues;
}

#pragma mark -

- (void)setItemsPerLine:(NSInteger)itemsPerLine withItemHeight:(CGFloat)itemH {
    CGFloat itemW = (self.collectionW - self.hSpace*(itemsPerLine - 1))/itemsPerLine;
    [self setItemSize:CGSizeMake(itemW, itemH)];
}


#pragma mark - properties

- (NSInteger)itemsPerLine{
    NSInteger num = ceilf(self.collectionW/self.itemSize.width);
    CGFloat hSpaceLeft = (int)self.collectionW%(int)self.itemSize.width;
//    TLOG(@"hSpaceLeft -> %@ num -> %@ collectionW -> %@ itemW -> %@", @(hSpaceLeft), @(num), @(self.collectionW), @(self.itemSize.width));
    if (hSpaceLeft - (num-1)*self.hSpace < 0) {
        num --;
    }
    return num;
}

- (NSInteger)hSpacesPerLine{
    return self.itemsPerLine - 1;
}

- (NSInteger)numberOfItems{
    return [self.collectionView numberOfItemsInSection:0];
}

- (NSInteger)numberOfLines{
    return ceilf((float)self.numberOfItems/(float)self.itemsPerLine);
}

- (NSMutableDictionary *)attributesDic{
    if (!_attributesDic){
        _attributesDic = [NSMutableDictionary dictionary];
    }
    return _attributesDic;
}

#pragma mark - styles

- (CGFloat)collectionW{
    
    if (self.collectionView.frame.size.width) return self.collectionView.frame.size.width;
    return _collectionW;
}

//- (CGFloat)vSpace{
//    return 15;
//}

//- (CGFloat)hSpace{
//    return 12.0;
//}

- (CGSize)itemSize{
    if (CGSizeEqualToSize(CGSizeZero, [super itemSize])){
        CGFloat itemsPerLine = 3.0;
        CGFloat w = (self.collectionW - self.hSpace*(itemsPerLine-1))/itemsPerLine;
        CGFloat h = 50;
        [super setItemSize:CGSizeMake(w, h)];
    }
    return [super itemSize];
}

@end
